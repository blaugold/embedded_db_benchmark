import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:tabular/tabular.dart';

import 'benchmark_database.dart';
import 'benchmark_parameter.dart';
import 'database_provider/database_provider.dart';
import 'parameter.dart';

class BenchmarkRun {
  BenchmarkRun({
    required this.benchmark,
    required this.database,
    required this.parameterCombination,
    required this.result,
  });

  final String benchmark;
  final String database;
  final ParameterCombination parameterCombination;
  final BenchmarkResult result;
}

class BenchmarkResult {
  BenchmarkResult({required this.operations, required this.duration});

  final int operations;

  double get operationsPerSecond =>
      operations / (duration.inMicroseconds / 10e5);

  final Duration duration;

  double get timePerOperationInMicroseconds =>
      duration.inMicroseconds / operations;
}

abstract class Benchmark {
  String get name;

  Iterable<ParameterCombination> get supportedParameterCombinations;

  BenchmarkRunner createRunner(ParameterCombination parameterCombination);
}

abstract class _BenchmarkDuration {
  const _BenchmarkDuration();

  bool isDone(BenchmarkRunner benchmark);

  int? maxAdditionalOperations(BenchmarkRunner benchmark);
}

class _FixedTimedDuration extends _BenchmarkDuration {
  const _FixedTimedDuration(this.duration);

  final Duration duration;

  @override
  bool isDone(BenchmarkRunner benchmark) =>
      benchmark.executionTimeInMicroseconds >= duration.inMicroseconds;

  @override
  int? maxAdditionalOperations(BenchmarkRunner benchmark) => null;
}

// ignore: unused_element
class _FixedOperationsDuration extends _BenchmarkDuration {
  const _FixedOperationsDuration(this.operations);

  final int operations;

  @override
  bool isDone(BenchmarkRunner benchmark) =>
      benchmark.executedOperations >= operations;

  @override
  int? maxAdditionalOperations(BenchmarkRunner benchmark) =>
      operations - benchmark.executedOperations;
}

abstract class BenchmarkRunner {
  late final DatabaseProvider _databaseProvider;
  late final ParameterCombination _parameterCombination;
  late final _BenchmarkDuration _duration;

  int get executedOperations => _executedOperations;
  var _executedOperations = 0;

  int? get maxAdditionalOperations => _duration.maxAdditionalOperations(this);

  int get executionTimeInMicroseconds => _stopwatch.elapsedMicroseconds;
  final _stopwatch = Stopwatch();

  @protected
  late final BenchmarkDatabase database;

  Future<BenchmarkResult> run(
    DatabaseProvider databaseProvider,
    ParameterCombination parameterCombination,
    _BenchmarkDuration duration,
  ) async {
    _duration = duration;
    _parameterCombination = parameterCombination;
    _databaseProvider = databaseProvider;

    await setup();

    while (!_duration.isDone(this)) {
      await executeOperations();
    }

    await teardown();

    return BenchmarkResult(
      operations: executedOperations,
      duration: Duration(microseconds: executionTimeInMicroseconds),
    );
  }

  @protected
  @mustCallSuper
  Future<void> setup() async {
    final directory = Directory.systemTemp.createTempSync();
    database = await _databaseProvider.openDatabase(
      directory.path,
      _parameterCombination,
    );
  }

  @protected
  FutureOr<void> executeOperations();

  @protected
  @mustCallSuper
  FutureOr<void> teardown() => database.close();

  @protected
  @pragma('vm:prefer-inline')
  Future<void> measureOperationsAsync(
    Future<void> Function() fn, {
    int operations = 1,
  }) async {
    _stopwatch.start();
    await fn();
    _stopwatch.stop();
    _executedOperations += operations;
  }

  @protected
  @pragma('vm:prefer-inline')
  void measureOperationsSync(void Function() fn, {int operations = 1}) {
    _stopwatch.start();
    fn();
    _stopwatch.stop();
    _executedOperations += operations;
  }
}

Future<BenchmarkResult> _runBenchmark({
  required Benchmark benchmark,
  required DatabaseProvider databaseProvider,
  required ParameterCombination parameterCombination,
}) async {
  Future<BenchmarkResult> _runBenchmark(_BenchmarkDuration duration) =>
      benchmark
          .createRunner(parameterCombination)
          .run(databaseProvider, parameterCombination, duration);

  const warmUpDuration = _FixedTimedDuration(Duration(milliseconds: 500));
  const runDuration = _FixedTimedDuration(Duration(seconds: 2));

  await _runBenchmark(warmUpDuration);
  return _runBenchmark(runDuration);
}

Future<List<BenchmarkRun>> runBenchmarks({
  required List<Benchmark> benchmarks,
  required List<DatabaseProvider> databasesProviders,
  Logger? logger,
}) async {
  logger ??= Logger('BenchmarkRunner');

  [
    'Running the following benchmarks:',
    for (final benchmark in benchmarks) ' - ${benchmark.name}'
  ].forEach(logger.info);

  [
    'Benchmarking the following databases:',
    for (final databaseProvider in databasesProviders)
      ' - ${databaseProvider.name}'
  ].forEach(logger.info);

  final runs = <BenchmarkRun>[];

  for (final benchmark in benchmarks) {
    logger.info('-> ${benchmark.name}');

    for (final parameterCombination
        in benchmark.supportedParameterCombinations) {
      logger.info('   -> ${parameterCombination.toString()}');

      for (final databaseProvider in databasesProviders) {
        if (!databaseProvider
            .supportsParameterCombination(parameterCombination)) {
          logger.fine('     -> ${databaseProvider.name} [SKIPPED]');
          continue;
        }

        logger.info('     -> ${databaseProvider.name}');

        final result = await _runBenchmark(
          benchmark: benchmark,
          databaseProvider: databaseProvider,
          parameterCombination: parameterCombination,
        );

        [
          '        Ops:     ${result.operations}',
          '        Ops/s:   ${result.operationsPerSecond.floor()}',
          '        Time:    ${result.duration.inMicroseconds / 10e5}s',
          '        Time/Op: ${result.timePerOperationInMicroseconds.ceil()}us'
        ].forEach(logger.info);

        runs.add(BenchmarkRun(
          benchmark: benchmark.name,
          database: databaseProvider.name,
          parameterCombination: parameterCombination,
          result: result,
        ));
      }
    }
  }

  return runs;
}

String printRuns(List<BenchmarkRun> runs) {
  final allParameters = runs
      .expand((run) => run.parameterCombination.parameters)
      .toSet()
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));

  final header = [
    'Benchmark',
    'Database',
    'Ops',
    'Ops/s',
    'Time',
    'Time/Op',
    ...allParameters.map((p) => p.name)
  ];

  Object? _formatParameterValue(Object? value) {
    if (value is Enum) {
      return value.name;
    }
    return value;
  }

  final rows = runs.map((run) => <Object?>[
        run.benchmark,
        run.database,
        run.result.operations,
        run.result.operationsPerSecond.floor(),
        '${(run.result.duration.inMicroseconds / 10e5).toStringAsFixed(3)}s',
        '${run.result.timePerOperationInMicroseconds.ceil()}us',
        for (final parameter in allParameters)
          _formatParameterValue(
                run.parameterCombination.get<Object?>(parameter),
              ) ??
              '',
      ]);

  return tabular(
    [header, ...rows],
    align: <String, Side>{
      'Ops': Side.end,
      'Ops/s': Side.end,
      'Time': Side.end,
      'Time/Op': Side.end,
      for (final parameter in allParameters) parameter.name: Side.end,
    },
    sort: [
      Sort('Benchmark'),
      Sort('Database'),
      Sort(execution.name),
      Sort(dataModel.name),
      Sort(batchSize.name),
    ],
  );
}

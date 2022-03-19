import 'dart:async';
import 'dart:io';

import 'package:benchmark_document/benchmark_document.dart';
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
    required this.parameterArguments,
    required this.result,
  });

  final String benchmark;
  final String database;
  final ParameterArguments parameterArguments;
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

  bool supportsParameterArguments(ParameterArguments arguments);

  BenchmarkRunner<ID, T>
      createRunner<ID extends Object, T extends BenchmarkDoc<ID>>(
    ParameterArguments parameterArguments,
  );
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

abstract class BenchmarkRunner<ID extends Object, T extends BenchmarkDoc<ID>> {
  late final DatabaseProvider<ID, T> _databaseProvider;
  late final ParameterArguments _parameterArguments;
  late final _BenchmarkDuration _duration;
  late final Directory _tempDirectory;

  int get executedOperations => _executedOperations;
  var _executedOperations = 0;

  int? get maxAdditionalOperations => _duration.maxAdditionalOperations(this);

  int get executionTimeInMicroseconds => _stopwatch.elapsedMicroseconds;
  final _stopwatch = Stopwatch();

  @protected
  late final Logger logger;

  @protected
  late final BenchmarkDatabase<ID, T> database;

  Future<BenchmarkResult> run(
    DatabaseProvider<ID, T> databaseProvider,
    ParameterArguments parameterArguments,
    _BenchmarkDuration duration,
    Logger logger,
  ) async {
    _duration = duration;
    _parameterArguments = parameterArguments;
    _databaseProvider = databaseProvider;
    this.logger = logger;

    await setup();

    await validateDatabase();
    resetMeasuredOperations();

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
    _tempDirectory = Directory.systemTemp.createTempSync();
    logger.fine('Opening database in ${_tempDirectory.path}');

    database = await _databaseProvider.openDatabase(
      _tempDirectory.path,
      _parameterArguments,
    );
  }

  @protected
  FutureOr<void> validateDatabase();

  @protected
  FutureOr<void> executeOperations();

  @protected
  @mustCallSuper
  FutureOr<void> teardown() async {
    await database.close();
    await _tempDirectory.delete(recursive: true);
  }

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

  void resetMeasuredOperations() {
    _stopwatch.reset();
    _executedOperations = 0;
  }
}

Future<BenchmarkResult> _runBenchmark({
  required Benchmark benchmark,
  required DatabaseProvider databaseProvider,
  required ParameterArguments parameterArguments,
  required Logger logger,
}) async {
  Future<BenchmarkResult> _runBenchmark(_BenchmarkDuration duration) =>
      databaseProvider.runWith(
        <ID extends Object, T extends BenchmarkDoc<ID>>(provider) {
          final runner = benchmark.createRunner<ID, T>(parameterArguments);
          return runner.run(provider, parameterArguments, duration, logger);
        },
      );

  const warmUpDuration = _FixedTimedDuration(Duration(milliseconds: 500));
  const runDuration = _FixedTimedDuration(Duration(seconds: 2));

  logger.info('Warming up');
  await _runBenchmark(warmUpDuration);
  logger.info('Running benchmark');
  return _runBenchmark(runDuration);
}

Future<List<BenchmarkRun>> runBenchmarks({
  required List<Benchmark> benchmarks,
  required List<DatabaseProvider> databasesProviders,
  bool catchExceptions = false,
  Logger? logger,
}) async {
  logger ??= Logger('BenchmarkRunner');

  [
    'Running the following benchmarks:',
    for (final benchmark in benchmarks) ' - ${benchmark.name}'
  ].forEach(logger.info);
  logger.info('');

  [
    'Benchmarking the following databases:',
    for (final databaseProvider in databasesProviders)
      ' - ${databaseProvider.name}'
  ].forEach(logger.info);
  logger.info('');

  final runs = <BenchmarkRun>[];

  final allArguments = <ParameterRange<Object?>>[
    ParameterRange.all(execution),
    ListParameterRange(batchSize, [1, 100, 1000]),
  ].crossProduct();

  for (final benchmark in benchmarks) {
    logger.info('=== Benchmark: ${benchmark.name} '.padRight(80, '='));
    logger.info('');

    for (final arguments in allArguments) {
      final benchmarkSupportsArguments =
          benchmark.supportsParameterArguments(arguments);
      logger.info(
        '*** Parameter arguments '
                '${benchmarkSupportsArguments ? '' : '[SKIPPED] '}'
            .padRight(80, '*'),
      );
      logger.info(arguments.toString());

      if (!benchmarkSupportsArguments) {
        logger.info('Parameter arguments not supported by benchmark');
        logger.info('');
        continue;
      } else {
        logger.info('');
      }

      for (final databaseProvider in databasesProviders) {
        final databaseSupportsArguments =
            databaseProvider.supportsParameterArguments(arguments);

        logger.info(
          '--- Database:  ${databaseProvider.name} '
                  '${databaseSupportsArguments ? '' : '[SKIPPED] '} '
              .padRight(80, '-'),
        );

        if (!databaseSupportsArguments) {
          logger.info('Parameter arguments not supported by database');
          logger.info('');
          continue;
        }

        try {
          final result = await _runBenchmark(
            benchmark: benchmark,
            databaseProvider: databaseProvider,
            parameterArguments: arguments,
            logger: logger,
          );

          logger.info('Results:');

          [
            'Ops:     ${result.operations}',
            'Ops/s:   ${result.operationsPerSecond.floor()}',
            'Time:    ${result.duration.inMicroseconds / 10e5}s',
            'Time/Op: ${result.timePerOperationInMicroseconds.ceil()}us'
          ].forEach(logger.info);

          logger.info('');

          runs.add(BenchmarkRun(
            benchmark: benchmark.name,
            database: databaseProvider.name,
            parameterArguments: arguments,
            result: result,
          ));
        } catch (e, s) {
          if (catchExceptions) {
            logger.severe('Error running benchmark: $e', e, s);
          } else {
            rethrow;
          }
        }
      }
    }
  }

  return runs;
}

Object? _formatParameterArgument(Object? value) {
  if (value is Enum) {
    return value.name;
  }
  return value;
}

  final allParameters = runs
      .expand((run) => run.parameterArguments.parameters)
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

  final rows = runs.map((run) => <Object?>[
        run.benchmark,
        run.database,
        run.result.operations,
        run.result.operationsPerSecond.floor(),
        '${(run.result.duration.inMicroseconds / 10e5).toStringAsFixed(3)}s',
        '${run.result.timePerOperationInMicroseconds.ceil()}us',
        for (final parameter in allParameters)
          _formatParameterArgument(
                run.parameterArguments.get<Object?>(parameter),
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
      Sort(batchSize.name),
    ],
  );
}

import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:tabular/tabular.dart';

import 'benchmark_database.dart';
import 'benchmark_document.dart';
import 'benchmark_parameter.dart';
import 'database_provider.dart';
import 'parameter.dart';

/// Record of a single benchmark run. Contains the benchmark configuration
/// and the results of the run.
class BenchmarkRun {
  BenchmarkRun({
    required this.benchmark,
    required this.database,
    required this.arguments,
    required this.result,
  });

  /// The name of the executed benchmark.
  final String benchmark;

  /// The name of the database which was benchmarked.
  final String database;

  /// The parameter arguments which were used to execute the benchmark.
  final ParameterArguments arguments;

  /// The results of this benchmark run.
  final BenchmarkResult result;
}

/// The result of a single benchmark run.
class BenchmarkResult {
  BenchmarkResult({
    required this.operations,
    required this.operationsRunTime,
    required this.benchmarkRunTime,
  });

  /// The total number of operations which were executed.
  final int operations;

  /// The total time it took to execute all [operations].
  ///
  /// Only time spent executing operations by the database is included.
  /// See [benchmarkRunTime] for the total time it took to execute the
  /// benchmark.
  final Duration operationsRunTime;

  /// The total time it took to execute the benchmark, including setup,
  /// preparing to execute operations and teardown.
  final Duration benchmarkRunTime;

  /// The number operations that were executed per second, on average.
  double get operationsPerSecond =>
      operations / (operationsRunTime.inMicroseconds / 10e5);

  /// The number of microseconds it took to execute a single operation, on
  /// average.
  double get timePerOperationInMicroseconds =>
      operationsRunTime.inMicroseconds / operations;
}

/// A benchmark which measures the performance of an operation of a database.
///
/// Benchmarks are parameterized through [Parameter]s. To execute a benchmark,
/// create a [BenchmarkRunner] by passing the concrete [ParameterArguments] to
/// [createRunner] and call [BenchmarkRunner._run].
///
/// Not every benchmark supports all [Parameter]s or every possible parameter
/// argument or combination of arguments. Before you call [createRunner] you
/// must check if the benchmark supports the given [ParameterArguments] with
/// [supportsParameterArguments].
abstract class Benchmark {
  const Benchmark();

  /// The name of the benchmark.
  String get name;

  /// Returns whether this benchmark supports the given [arguments].
  bool supportsParameterArguments(ParameterArguments arguments);

  /// Creates a [BenchmarkRunner] for given [arguments].
  BenchmarkRunner<ID, T>
      createRunner<ID extends Object, T extends BenchmarkDoc<ID>>(
    ParameterArguments arguments,
  );
}

/// The duration for which to run a benchmark.
///
/// Implementations of this class decide based on the state of the
/// [BenchmarkRunner] whether to continue running the benchmark or to stop.
///
/// See also:
///
/// * [FixedTimedDuration], which runs the benchmark for a fixed amount of time.
/// * [FixedOperationsDuration], which runs the benchmark for a fixed number of
///   operations.
abstract class BenchmarkDuration {
  const BenchmarkDuration();

  /// Decides whether the benchmark is done or whether it should run
  /// [BenchmarkRunner.executeOperations] once more.
  bool isDone(BenchmarkRunner runner);

  int? maxAdditionalOperations(BenchmarkRunner runner);

  double progress(BenchmarkRunner runner);
}

/// Executes a benchmark for a fixed amount of time.
class FixedTimedDuration extends BenchmarkDuration {
  const FixedTimedDuration(this.duration);

  /// The duration for which to run the benchmark.
  final Duration duration;

  @override
  bool isDone(BenchmarkRunner runner) =>
      runner.executionTimeInMicroseconds >= duration.inMicroseconds;

  @override
  int? maxAdditionalOperations(BenchmarkRunner runner) => null;

  @override
  double progress(BenchmarkRunner runner) =>
      runner.executionTimeInMicroseconds / duration.inMicroseconds;
}

/// Executes a benchmark for a fixed number of operations.
class FixedOperationsDuration extends BenchmarkDuration {
  const FixedOperationsDuration(this.operations);

  /// The number of operations for which to run the benchmark.
  final int operations;

  @override
  bool isDone(BenchmarkRunner runner) =>
      runner.executedOperations >= operations;

  @override
  int? maxAdditionalOperations(BenchmarkRunner runner) =>
      operations - runner.executedOperations;

  @override
  double progress(BenchmarkRunner runner) =>
      runner.executedOperations / operations;
}

enum BenchmarkRunnerLifecycle {
  created,
  setup,
  validateDatabase,
  executeOperations,
  teardown,
  done,
}

typedef OnBenchmarkRunnerChange = void Function(BenchmarkRunner runner);

/// Parameterized implementation of a [Benchmark] which actually executes it.
///
/// Sub classes of this class are implementation details of [Benchmarks] and
/// created in [Benchmark.createRunner].
abstract class BenchmarkRunner<ID extends Object, T extends BenchmarkDoc<ID>> {
  late final DatabaseProvider<ID, T> _databaseProvider;
  late final ParameterArguments _arguments;
  late final BenchmarkDuration _duration;
  late final Directory _tempDirectory;
  late final OnBenchmarkRunnerChange? _onChange;

  BenchmarkRunnerLifecycle get lifecycle => _lifecycle;
  var _lifecycle = BenchmarkRunnerLifecycle.created;

  /// The current progress of the benchmark between 0 and 1.
  ///
  /// This value can be larger than 1 if it is not possible to stop the
  /// execution of operations at the exact time the benchmark has completed
  /// its [BenchmarkDuration].
  double get progress => _progress;
  var _progress = 0.0;

  /// The total number of operations which have been executed up to this point.
  int get executedOperations => _executedOperations;
  var _executedOperations = 0;

  /// The maximal number of operations that should be executed the next time
  /// this runner executes measured operations.
  // TODO: Make benchmarks actually take maxAdditionalOperations into account.
  int? get maxAdditionalOperations => _duration.maxAdditionalOperations(this);

  /// The total time it took to execute all [executedOperations].
  int get executionTimeInMicroseconds => _stopwatch.elapsedMicroseconds;
  final _stopwatch = Stopwatch();

  /// Logger for this benchmark runner.
  @protected
  late final Logger logger;

  /// The database which is benchmarked.
  @protected
  late final BenchmarkDatabase<ID, T> database;

  /// Prepares this runner for execution.
  @protected
  @mustCallSuper
  Future<void> setup() async {
    _tempDirectory = Directory.systemTemp.createTempSync();
    logger.fine('Opening database in ${_tempDirectory.path}');

    database = await _databaseProvider.openDatabase(
      _tempDirectory.path,
      _arguments,
    );
  }

  /// Validates that the benchmarked database is correctly executing the
  /// benchmarked operation.
  @protected
  FutureOr<void> validateDatabase();

  /// Executes the benchmarked operation an implementation specific number of
  /// times.
  ///
  /// This method is called repeatedly until [BenchmarkDuration.isDone] returns
  /// `true`.
  @protected
  FutureOr<void> executeOperations();

  /// Tears down this runner after it's done.
  @protected
  @mustCallSuper
  FutureOr<void> teardown() async {
    await database.close();
    await _tempDirectory.delete(recursive: true);
  }

  /// Measures the asynchronous execution of the benchmarked operations.
  ///
  /// You need to provide the number of [operations] that are going to be
  /// executed when [fn] is called.
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

  /// Measures the synchronous execution of the benchmarked operations.
  ///
  /// You need to provide the number of [operations] that are going to be
  /// executed when [fn] is called.
  @protected
  @pragma('vm:prefer-inline')
  void measureOperationsSync(void Function() fn, {int operations = 1}) {
    _stopwatch.start();
    fn();
    _stopwatch.stop();
    _executedOperations += operations;
  }

  Future<BenchmarkResult> _run(
    DatabaseProvider<ID, T> databaseProvider,
    ParameterArguments arguments,
    BenchmarkDuration duration,
    OnBenchmarkRunnerChange? onChange,
    Logger logger,
  ) async {
    assert(_executedOperations == 0);
    assert(_stopwatch.elapsedTicks == 0);

    _duration = duration;
    _arguments = arguments;
    _databaseProvider = databaseProvider;
    _onChange = onChange;
    this.logger = logger;

    final stopwatch = Stopwatch()..start();

    _lifecycle = BenchmarkRunnerLifecycle.setup;
    _notifyChangeHandler();
    await setup();

    _lifecycle = BenchmarkRunnerLifecycle.validateDatabase;
    _notifyChangeHandler();
    await validateDatabase();
    _resetMeasuredOperations();

    _lifecycle = BenchmarkRunnerLifecycle.executeOperations;
    _notifyChangeHandler();
    while (!_duration.isDone(this)) {
      await executeOperations();
      _progress = _duration.progress(this);
      _notifyChangeHandler();
    }

    _lifecycle = BenchmarkRunnerLifecycle.teardown;
    _notifyChangeHandler();
    await teardown();

    stopwatch.stop();

    _lifecycle = BenchmarkRunnerLifecycle.done;
    _notifyChangeHandler();

    return BenchmarkResult(
      operations: executedOperations,
      operationsRunTime: Duration(microseconds: executionTimeInMicroseconds),
      benchmarkRunTime: Duration(microseconds: stopwatch.elapsedMicroseconds),
    );
  }

  void _resetMeasuredOperations() {
    _stopwatch.reset();
    _executedOperations = 0;
  }

  void _notifyChangeHandler() {
    _onChange?.call(this);
  }
}

/// Runs a benchmark against a database.
Future<BenchmarkResult> runBenchmark({
  required Benchmark benchmark,
  required DatabaseProvider databaseProvider,
  required ParameterArguments arguments,
  required BenchmarkDuration warmUpDuration,
  required BenchmarkDuration runDuration,
  OnBenchmarkRunnerChange? onRunnerChange,
  required Logger logger,
}) async {
  Future<BenchmarkResult> _runBenchmarkRunner(BenchmarkDuration duration) =>
      databaseProvider.runWith(
        <ID extends Object, T extends BenchmarkDoc<ID>>(provider) {
          final runner = benchmark.createRunner<ID, T>(arguments);
          return runner._run(
              provider, arguments, duration, onRunnerChange, logger);
        },
      );

  logger.info('Warming up');
  await _runBenchmarkRunner(warmUpDuration);
  logger.info('Running benchmark');
  return _runBenchmarkRunner(runDuration);
}

Object? _formatParameterArgument(Object? value) {
  if (value is Enum) {
    return value.name;
  }
  return value;
}

String runsToAsciiTable(List<BenchmarkRun> runs) {
  final allParameters = runs
      .expand((run) => run.arguments.parameters)
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
        '${(run.result.operationsRunTime.inMicroseconds / 10e5).toStringAsFixed(3)}s',
        '${run.result.timePerOperationInMicroseconds.ceil()}us',
        for (final parameter in allParameters)
          _formatParameterArgument(
                run.arguments.get<Object?>(parameter),
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

String runsToCsv(List<BenchmarkRun> runs) {
  final allParameters = runs
      .expand((run) => run.arguments.parameters)
      .toSet()
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));

  final header = <String>[
    'benchmark',
    'database',
    for (final parameter in allParameters) parameter.name,
    'duration',
    'operations',
    'operationsPerSecond',
    'timePerOperationInMicroseconds',
  ];

  final rows = [
    for (final run in runs)
      [
        run.benchmark,
        run.database,
        for (final parameter in allParameters)
          _formatParameterArgument(
            run.arguments.get<Object?>(parameter),
          ),
        run.result.operationsRunTime.inMicroseconds,
        run.result.operations,
        run.result.operationsPerSecond,
        run.result.timePerOperationInMicroseconds,
      ],
  ];

  return const ListToCsvConverter().convert([header, ...rows]);
}

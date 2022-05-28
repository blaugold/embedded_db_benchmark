import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:tabular/tabular.dart';

import 'benchmark_database.dart';
import 'benchmark_document.dart';
import 'benchmark_parameter.dart';
import 'database_provider.dart';
import 'parameter.dart';

@immutable
class BenchmarkRunConfiguration {
  const BenchmarkRunConfiguration({
    required this.benchmark,
    required this.databaseProvider,
    required this.arguments,
  });

  final Benchmark benchmark;
  final DatabaseProvider databaseProvider;
  final ParameterArguments arguments;

  bool get isRunnable =>
      benchmark.supportsParameterArguments(arguments) &&
      databaseProvider.supportsParameterArguments(arguments);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkRunConfiguration &&
          runtimeType == other.runtimeType &&
          benchmark == other.benchmark &&
          databaseProvider == other.databaseProvider &&
          arguments == other.arguments;

  @override
  int get hashCode =>
      benchmark.hashCode ^ databaseProvider.hashCode ^ arguments.hashCode;

  @override
  String toString() => 'BenchmarkRunConfiguration('
      'benchmark: $benchmark, '
      'databaseProvider: $databaseProvider, '
      'arguments: $arguments'
      ')';

  Map<String, Object?> toJson() => <String, Object?>{
        'benchmark': benchmark.name,
        'databaseProvider': databaseProvider.name,
        'arguments': arguments.toJson(),
      };

  factory BenchmarkRunConfiguration.fromJson(
    Map<String, Object?> json, {
    required Map<String, Benchmark> benchmarks,
    required Map<String, DatabaseProvider> databaseProviders,
    required Map<String, Parameter> parameters,
  }) =>
      BenchmarkRunConfiguration(
        benchmark: benchmarks[json['benchmark']! as String]!,
        databaseProvider:
            databaseProviders[json['databaseProvider']! as String]!,
        arguments: ParameterArguments.fromJson(
          json['arguments']! as Map<String, Object?>,
          parameters: parameters,
        ),
      );
}

@immutable
class BenchmarkPlan {
  const BenchmarkPlan({
    required this.warmUpDuration,
    required this.benchmarkDuration,
    required this.runConfigurations,
  });

  final BenchmarkDuration warmUpDuration;
  final BenchmarkDuration benchmarkDuration;
  final List<BenchmarkRunConfiguration> runConfigurations;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkPlan &&
          runtimeType == other.runtimeType &&
          warmUpDuration == other.warmUpDuration &&
          benchmarkDuration == other.benchmarkDuration &&
          const DeepCollectionEquality()
              .equals(runConfigurations, other.runConfigurations);

  @override
  int get hashCode =>
      warmUpDuration.hashCode ^
      benchmarkDuration.hashCode ^
      const DeepCollectionEquality().hash(runConfigurations);

  @override
  String toString() => 'BenchmarkPlan('
      'warmUpDuration: $warmUpDuration, '
      'benchmarkDuration: $benchmarkDuration, '
      'runConfigurations: $runConfigurations'
      ')';

  Map<String, Object?> toJson() => <String, Object?>{
        'warmUpDuration': warmUpDuration.toJson(),
        'benchmarkDuration': benchmarkDuration.toJson(),
        'runConfigurations': [
          for (final runConfiguration in runConfigurations)
            runConfiguration.toJson()
        ],
      };

  factory BenchmarkPlan.fromJson(
    Map<String, Object?> json, {
    required Map<String, Benchmark> benchmarks,
    required Map<String, DatabaseProvider> databaseProviders,
    required Map<String, Parameter> parameters,
  }) =>
      BenchmarkPlan(
        warmUpDuration: BenchmarkDuration.fromJson(
          json['warmUpDuration']! as Map<String, Object?>,
        ),
        benchmarkDuration: BenchmarkDuration.fromJson(
          json['benchmarkDuration']! as Map<String, Object?>,
        ),
        runConfigurations: (json['runConfigurations']! as List<Object?>)
            .map(
              (runConfiguration) => BenchmarkRunConfiguration.fromJson(
                runConfiguration as Map<String, Object?>,
                benchmarks: benchmarks,
                databaseProviders: databaseProviders,
                parameters: parameters,
              ),
            )
            .toList(),
      );

  List<Parameter> get allParameters => runConfigurations
      .expand((runConfiguration) => runConfiguration.arguments.parameters)
      .toSet()
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));
}

/// The result of a single benchmark run.
@immutable
class BenchmarkResult {
  const BenchmarkResult({
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkResult &&
          runtimeType == other.runtimeType &&
          operations == other.operations &&
          operationsRunTime == other.operationsRunTime &&
          benchmarkRunTime == other.benchmarkRunTime;

  @override
  int get hashCode =>
      operations.hashCode ^
      operationsRunTime.hashCode ^
      benchmarkRunTime.hashCode;

  @override
  String toString() => 'BenchmarkResult('
      'operations: $operations, '
      'operationsRunTime: $operationsRunTime, '
      'benchmarkRunTime: $benchmarkRunTime'
      ')';

  Map<String, Object?> toJson() => {
        'operations': operations,
        'operationsRunTime': operationsRunTime.inMicroseconds,
        'benchmarkRunTime': benchmarkRunTime.inMicroseconds,
      };

  factory BenchmarkResult.fromJson(Map<String, Object?> json) =>
      BenchmarkResult(
        operations: json['operations']! as int,
        operationsRunTime:
            Duration(microseconds: json['operationsRunTime']! as int),
        benchmarkRunTime:
            Duration(microseconds: json['benchmarkRunTime']! as int),
      );
}

@immutable
class BenchmarkThrewException extends Error {
  BenchmarkThrewException(this.message, this.stackTrace);

  final String message;

  @override
  final StackTrace stackTrace;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkThrewException &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          const DeepCollectionEquality().equals(stackTrace, other.stackTrace);

  @override
  int get hashCode => message.hashCode ^ stackTrace.hashCode;

  @override
  String toString() => 'BenchmarkThrewException: $message';

  Map<String, Object?> toJson() => <String, Object?>{
        'message': message,
        'stackTrace': stackTrace.toString(),
      };

  factory BenchmarkThrewException.fromJson(Map<String, Object?> json) =>
      BenchmarkThrewException(
        json['message']! as String,
        StackTrace.fromString(json['stackTrace']! as String),
      );
}

@immutable
class BenchmarkResults {
  BenchmarkResults({
    required this.plan,
    required Map<BenchmarkRunConfiguration, BenchmarkThrewException> failedRuns,
    required Map<BenchmarkRunConfiguration, BenchmarkResult> successfulRuns,
  })  : failedRuns = Map.unmodifiable(failedRuns),
        successfulRuns = Map.unmodifiable(successfulRuns) {
    for (final runConfiguration in [
      ...failedRuns.keys,
      ...successfulRuns.keys
    ]) {
      if (!plan.runConfigurations.contains(runConfiguration)) {
        throw ArgumentError.value(
          runConfiguration,
          null,
          'Run configuration is not part of the benchmark plan.',
        );
      }
    }
  }

  final BenchmarkPlan plan;
  final Map<BenchmarkRunConfiguration, BenchmarkThrewException> failedRuns;
  final Map<BenchmarkRunConfiguration, BenchmarkResult> successfulRuns;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkResults &&
          runtimeType == other.runtimeType &&
          plan == other.plan &&
          const DeepCollectionEquality().equals(failedRuns, other.failedRuns) &&
          const DeepCollectionEquality()
              .equals(successfulRuns, other.successfulRuns);

  @override
  int get hashCode =>
      plan.hashCode ^
      const DeepCollectionEquality().hash(failedRuns) ^
      const DeepCollectionEquality().hash(successfulRuns);

  @override
  String toString() => 'BenchmarkResults('
      'plan: $plan, '
      'failedRuns: $failedRuns, '
      'successfulRuns: $successfulRuns'
      ')';

  Map<String, Object?> toJson() => <String, Object?>{
        'plan': plan.toJson(),
        'failedRuns': [
          for (final failedRun in failedRuns.entries)
            <String, Object?>{
              'runConfiguration': plan.runConfigurations.indexOf(failedRun.key),
              'error': failedRun.value.toJson(),
            }
        ],
        'successfulRuns': [
          for (final successfulRun in successfulRuns.entries)
            <String, Object?>{
              'runConfiguration':
                  plan.runConfigurations.indexOf(successfulRun.key),
              'result': successfulRun.value.toJson(),
            }
        ],
      };

  factory BenchmarkResults.fromJson(
    Map<String, Object?> json, {
    required Map<String, Benchmark> benchmarks,
    required Map<String, DatabaseProvider> databaseProviders,
    required Map<String, Parameter> parameters,
  }) {
    final plan = BenchmarkPlan.fromJson(
      json['plan']! as Map<String, Object?>,
      benchmarks: benchmarks,
      databaseProviders: databaseProviders,
      parameters: parameters,
    );

    final failedRuns = <BenchmarkRunConfiguration, BenchmarkThrewException>{};
    for (final failedRun in (json['failedRuns']! as List<Object?>)
        .cast<Map<String, Object?>>()) {
      final runConfiguration =
          plan.runConfigurations[failedRun['runConfiguration']! as int];
      failedRuns[runConfiguration] = BenchmarkThrewException.fromJson(
          failedRun['error']! as Map<String, Object?>);
    }

    final successfulRuns = <BenchmarkRunConfiguration, BenchmarkResult>{};
    for (final successfulRun in (json['successfulRuns']! as List<Object?>)
        .cast<Map<String, Object?>>()) {
      final runConfiguration =
          plan.runConfigurations[successfulRun['runConfiguration']! as int];
      successfulRuns[runConfiguration] = BenchmarkResult.fromJson(
        successfulRun['result']! as Map<String, Object?>,
      );
    }
    return BenchmarkResults(
      plan: plan,
      failedRuns: failedRuns,
      successfulRuns: successfulRuns,
    );
  }

  String toAsciiTable() {
    final allParameters = plan.allParameters;

    final header = [
      '', // Status column (skipped, success, error).
      'Benchmark',
      'Database',
      'Ops',
      'Ops/s',
      'Time',
      'Time/Op',
      ...allParameters.map((parameter) => parameter.name)
    ];

    final rows = plan.runConfigurations.map((runConfiguration) {
      List<Object?> buildRow(String status, [BenchmarkResult? result]) =>
          <Object?>[
            status,
            runConfiguration.benchmark.name,
            runConfiguration.databaseProvider.name,
            if (result != null) ...[
              result.operations,
              result.operationsPerSecond.floor(),
              '${(result.operationsRunTime.inMicroseconds / 10e5).toStringAsFixed(3)}s',
              '${result.timePerOperationInMicroseconds.ceil()}us'
            ] else ...[
              '',
              '',
              '',
              ''
            ],
            ...allParameters.map((parameter) {
              final argument =
                  runConfiguration.arguments.get<Object?>(parameter);
              return argument == null ? '' : parameter.describe(argument);
            }),
          ];

      final error = failedRuns[runConfiguration];
      if (error != null) {
        return buildRow('✘');
      }

      final result = successfulRuns[runConfiguration];
      if (result != null) {
        return buildRow('✔', result);
      }

      // Skipped run configuration.
      return buildRow('-');
    });

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

  String toCsvTable() {
    final allParameters = plan.allParameters;

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
      for (final run in successfulRuns.entries)
        [
          run.key.benchmark.name,
          run.key.databaseProvider.name,
          for (final parameter in allParameters)
            parameter.describe(
              run.key.arguments.get<Object?>(parameter),
            ),
          run.value.operationsRunTime.inMicroseconds,
          run.value.operations,
          run.value.operationsPerSecond,
          run.value.timePerOperationInMicroseconds,
        ],
    ];

    return const ListToCsvConverter().convert([header, ...rows]);
  }
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

  @override
  String toString() => 'Benchmark(name)';
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
@immutable
abstract class BenchmarkDuration {
  const BenchmarkDuration();

  /// Decides whether the benchmark is done or whether it should run
  /// [BenchmarkRunner.executeOperations] once more.
  bool isDone(BenchmarkRunner runner);

  int? maxAdditionalOperations(BenchmarkRunner runner);

  double progress(BenchmarkRunner runner);

  Map<String, Object?> toJson();

  factory BenchmarkDuration.fromJson(Map<String, Object?> json) {
    final duration = json['duration'] as int?;
    if (duration != null) {
      return FixedTimedDuration(Duration(microseconds: duration));
    } else {
      final operations = json['operations']! as int;
      return FixedOperationsDuration(operations);
    }
  }
}

/// Executes a benchmark for a fixed amount of time.
@immutable
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FixedTimedDuration &&
          runtimeType == other.runtimeType &&
          duration == other.duration;

  @override
  int get hashCode => duration.hashCode;

  @override
  String toString() => 'FixedTimedDuration(duration: $duration)';

  @override
  Map<String, Object?> toJson() => {'duration': duration.inMicroseconds};
}

/// Executes a benchmark for a fixed number of operations.
@immutable
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FixedOperationsDuration &&
          runtimeType == other.runtimeType &&
          operations == other.operations;

  @override
  int get hashCode => operations.hashCode;

  @override
  String toString() => 'FixedOperationsDuration(operations: $operations)';

  @override
  Map<String, Object?> toJson() => {'operations': operations};
}

enum BenchmarkRunnerLifecycle {
  created,
  setup,
  validateDatabase,
  warmUp,
  run,
  teardown,
  done,
}

typedef _OnBenchmarkRunnerChange = void Function(BenchmarkRunner runner);

/// Parameterized implementation of a [Benchmark] which actually executes it.
///
/// Sub classes of this class are implementation details of [Benchmarks] and
/// created in [Benchmark.createRunner].
abstract class BenchmarkRunner<ID extends Object, T extends BenchmarkDoc<ID>> {
  late final DatabaseProvider<ID, T> _databaseProvider;
  late final ParameterArguments _arguments;
  late final BenchmarkDuration _warmUpDuration;
  late final BenchmarkDuration _runDuration;
  late final Directory _tempDirectory;
  late final _OnBenchmarkRunnerChange? _onChange;

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
  int? get maxAdditionalOperations =>
      _lifecycle == BenchmarkRunnerLifecycle.warmUp
          ? _warmUpDuration.maxAdditionalOperations(this)
          : _runDuration.maxAdditionalOperations(this);

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

  /// Measures the execution of the benchmarked operations.
  ///
  /// You need to provide the number of [operations] that are going to be
  /// executed when [fn] is called.
  @protected
  @pragma('vm:prefer-inline')
  Future<void> measureOperations(
    FutureOr<void> Function() fn, {
    int operations = 1,
  }) async {
    _stopwatch.start();
    await fn();
    _stopwatch.stop();
    _executedOperations += operations;
  }

  Future<BenchmarkResult> _run(
    DatabaseProvider<ID, T> databaseProvider,
    ParameterArguments arguments,
    BenchmarkDuration warmUpDuration,
    BenchmarkDuration runDuration,
    _OnBenchmarkRunnerChange? onChange,
    Logger logger,
  ) async {
    assert(_executedOperations == 0);
    assert(_stopwatch.elapsedTicks == 0);

    _warmUpDuration = warmUpDuration;
    _runDuration = runDuration;
    _arguments = arguments;
    _databaseProvider = databaseProvider;
    _onChange = onChange;
    this.logger = logger;

    final stopwatch = Stopwatch()..start();

    _lifecycle = BenchmarkRunnerLifecycle.setup;
    _notifyChangeHandler();
    await Future(setup);

    _lifecycle = BenchmarkRunnerLifecycle.validateDatabase;
    _notifyChangeHandler();
    await Future(validateDatabase);
    _resetMeasuredOperations();

    _lifecycle = BenchmarkRunnerLifecycle.warmUp;
    _notifyChangeHandler();
    while (!_warmUpDuration.isDone(this)) {
      await Future(executeOperations);
      _progress = _warmUpDuration.progress(this);
      _notifyChangeHandler();
    }
    _resetMeasuredOperations();

    _lifecycle = BenchmarkRunnerLifecycle.run;
    _progress = 0;
    _notifyChangeHandler();
    while (!_runDuration.isDone(this)) {
      await Future(executeOperations);
      _progress = _runDuration.progress(this);
      _notifyChangeHandler();
    }

    _lifecycle = BenchmarkRunnerLifecycle.teardown;
    _notifyChangeHandler();
    await Future(teardown);

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

enum PlanRunnerStatus {
  notRunning,
  running,
  stopping,
  done,
  failed,
}

class BenchmarkPlanRunner {
  BenchmarkPlanRunner({
    required this.plan,
    required this.catchExceptions,
    BenchmarkPlanObserver? observer,
    required Logger logger,
  })  : _observer = observer,
        _logger = logger,
        _runConfigurations = List.from(plan.runConfigurations);

  final BenchmarkPlan plan;

  final bool catchExceptions;

  PlanRunnerStatus get status => _status;
  PlanRunnerStatus _status = PlanRunnerStatus.notRunning;

  BenchmarkResults get results => BenchmarkResults(
        plan: plan,
        successfulRuns: _successfulRuns,
        failedRuns: _failedRuns,
      );

  Future<BenchmarkResults> get done => _done.future;
  final _done = Completer<BenchmarkResults>();

  final BenchmarkPlanObserver? _observer;
  final Logger _logger;
  final List<BenchmarkRunConfiguration> _runConfigurations;
  final _failedRuns = <BenchmarkRunConfiguration, BenchmarkThrewException>{};
  final _successfulRuns = <BenchmarkRunConfiguration, BenchmarkResult>{};
  Future<void>? _currentExecution;

  Future<BenchmarkResults> runUntilDone() {
    start();
    return done;
  }

  void start() {
    assert(_status == PlanRunnerStatus.notRunning);

    _status = PlanRunnerStatus.running;
    _observer?.didChangePlanRunner(this);

    _currentExecution = _runPlan().onError((error, stackTrace) {
      _status = PlanRunnerStatus.failed;
      _done.completeError(error!, stackTrace);
    });
  }

  Future<void> stop() async {
    assert(_status == PlanRunnerStatus.running);

    _status = PlanRunnerStatus.stopping;
    _observer?.didChangePlanRunner(this);

    await _currentExecution;
    _currentExecution = null;

    if (_status != PlanRunnerStatus.done &&
        _status != PlanRunnerStatus.failed) {
      _status = PlanRunnerStatus.notRunning;
      _observer?.didChangePlanRunner(this);
    }
  }

  Future<void> _runPlan() async {
    while (
        _status == PlanRunnerStatus.running && _runConfigurations.isNotEmpty) {
      final runConfiguration = _runConfigurations.removeAt(0);

      if (!runConfiguration.isRunnable) {
        _observer?.didSkipRun(this, runConfiguration);
        continue;
      }

      _observer?.willStartRun(this, runConfiguration);

      try {
        final result = _successfulRuns[runConfiguration] =
            await _runBenchmark(runConfiguration);

        _observer?.didFinishRun(this, runConfiguration, result);
      } catch (e, s) {
        if (!catchExceptions) {
          rethrow;
        }

        _failedRuns[runConfiguration] =
            BenchmarkThrewException(e.toString(), s);

        _observer?.didFinishRunWithError(this, runConfiguration, e, s);
      }
    }

    if (_runConfigurations.isEmpty) {
      _status = PlanRunnerStatus.done;
      _observer?.didChangePlanRunner(this);

      _done.complete(results);
    }
  }

  Future<BenchmarkResult> _runBenchmark(
    BenchmarkRunConfiguration configuration,
  ) =>
      configuration.databaseProvider.runWith(
        <ID extends Object, T extends BenchmarkDoc<ID>>(provider) {
          final runner = configuration.benchmark
              .createRunner<ID, T>(configuration.arguments);

          return runner._run(
            provider,
            configuration.arguments,
            plan.warmUpDuration,
            plan.benchmarkDuration,
            (runner) => _observer?.didChangeBenchmarkRunner(
              this,
              configuration,
              runner,
            ),
            _logger,
          );
        },
      );
}

abstract class BenchmarkPlanObserver {
  void didChangePlanRunner(BenchmarkPlanRunner runner) {}

  void didSkipRun(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
  ) {}

  void willStartRun(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
  ) {}

  void didChangeBenchmarkRunner(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
    BenchmarkRunner benchmarkRunner,
  ) {}

  void didFinishRun(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
    BenchmarkResult result,
  ) {}

  void didFinishRunWithError(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
    Object error,
    StackTrace stackTrace,
  ) {}
}

class LoggerBenchmarkPlanObserver extends BenchmarkPlanObserver {
  LoggerBenchmarkPlanObserver(this._logger);

  final Logger _logger;
  final _hasTerminal = stdout.hasTerminal;
  int? _lastProgress;

  @override
  void didSkipRun(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
  ) {
    _logBenchmarkConfig(configuration);
    _logger.info(
      'Skipping run configuration because the combination of benchmark, '
      'database and arguments is not runnable.',
    );
    _logger.info('');
  }

  @override
  void willStartRun(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
  ) {
    _logBenchmarkConfig(configuration);
  }

  @override
  void didChangeBenchmarkRunner(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
    BenchmarkRunner benchmarkRunner,
  ) {
    if (_hasTerminal) {
      _reportProgressOnConsole(benchmarkRunner);
    }
  }

  @override
  void didFinishRun(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
    BenchmarkResult result,
  ) {
    [
      'Ops:     ${result.operations}',
      'Ops/s:   ${result.operationsPerSecond.floor()}',
      'Time:    ${result.operationsRunTime.inMicroseconds / 10e5}s',
      'Time/Op: ${result.timePerOperationInMicroseconds.ceil()}us'
    ].forEach(_logger.info);
    _logger.info('');
  }

  @override
  void didFinishRunWithError(
      BenchmarkPlanRunner runner,
      BenchmarkRunConfiguration configuration,
      Object error,
      StackTrace stackTrace) {
    _logger.severe('Benchmark threw an exception', error, stackTrace);
    _logger.info('');
  }

  void _logBenchmarkConfig(BenchmarkRunConfiguration configuration) {
    final arguments = configuration.arguments;
    _logger.info([
      configuration.benchmark.name,
      configuration.databaseProvider.name,
      for (final parameter in arguments.parameters)
        '${parameter.name}: ${parameter.describe(arguments.get<Object?>(parameter))}',
    ].join(' - '));
  }

  void _reportProgressOnConsole(BenchmarkRunner runner) {
    if (runner.lifecycle != BenchmarkRunnerLifecycle.warmUp &&
        runner.lifecycle != BenchmarkRunnerLifecycle.run) {
      _lastProgress = null;
      return;
    }

    final newProgress = (runner.progress * 100).toInt();
    if (newProgress == _lastProgress) {
      // Don't print the same progress multiple times.
      return;
    }

    _lastProgress = newProgress;

    if (_lastProgress != 0) {
      stdout.write('\u001B[A\u001B[K\r');
    }

    final isWarmUp = runner.lifecycle == BenchmarkRunnerLifecycle.warmUp;
    stdout.write(isWarmUp ? 'Warm-up' : 'Benchmark');
    stdout.write('${newProgress.toInt()}%'.padLeft(5));
    stdout.write('\n');
  }
}

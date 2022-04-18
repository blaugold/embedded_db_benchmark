import 'package:benchmark/benchmark.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

enum RunControllerStatus {
  notRunning,
  running,
  stopping,
}

class RunController extends ChangeNotifier with BenchmarkPlanObserver {
  RunController({required BenchmarkPlan plan}) : _plan = plan {
    _updateForNewPlan();
  }

  BenchmarkPlan get plan => _plan;
  BenchmarkPlan _plan;

  set plan(BenchmarkPlan value) {
    assert(_status == RunControllerStatus.notRunning);
    _plan = value;
    _updateForNewPlan();
    notifyListeners();
  }

  void _updateForNewPlan() {
    _updateResultsForNewPlan();
    _updateRunnableConfigurationsForNewPlan();
  }

  bool get showAllRunConfigurations => _showAllRunConfigurations;
  bool _showAllRunConfigurations = false;

  set showAllRunConfigurations(bool value) {
    if (_showAllRunConfigurations != value) {
      _showAllRunConfigurations = value;
      notifyListeners();
    }
  }

  List<BenchmarkRunConfiguration> get visibleRunConfigurations {
    if (showAllRunConfigurations) {
      return allRunConfigurations;
    } else {
      return _runnableRunConfigurations;
    }
  }

  List<BenchmarkRunConfiguration> get allRunConfigurations =>
      _plan.runConfigurations;

  List<BenchmarkRunConfiguration> get runnableRunConfigurations =>
      _runnableRunConfigurations;
  List<BenchmarkRunConfiguration> _runnableRunConfigurations = [];

  void _updateRunnableConfigurationsForNewPlan() {
    _runnableRunConfigurations = _plan.runConfigurations
        .where((configuration) => configuration.isRunnable)
        .toList();
  }

  bool get isRunning => _status != RunControllerStatus.notRunning;

  RunControllerStatus get status => _status;
  RunControllerStatus _status = RunControllerStatus.notRunning;

  BenchmarkRunConfiguration? get currentConfiguration => _currentConfiguration;
  BenchmarkRunConfiguration? _currentConfiguration;

  BenchmarkRunnerLifecycle? get lifecycle => _lifecycle;
  BenchmarkRunnerLifecycle? _lifecycle;

  bool? get isWarmUp => _isWarmUp;
  bool? _isWarmUp;

  final progress = ValueNotifier<int?>(null);

  BenchmarkPlanRunner? _planRunner;

  void runConfigurations({bool onlyIfWithoutResult = false}) {
    assert(_status == RunControllerStatus.notRunning);
    var configurations = _plan.runConfigurations;
    if (onlyIfWithoutResult) {
      configurations = configurations
          .where((configuration) => getResults(configuration).isEmpty)
          .toList();
    }

    _runConfigurations(configurations);
  }

  void runConfiguration(BenchmarkRunConfiguration configuration) {
    assert(_status == RunControllerStatus.notRunning);
    assert(plan.runConfigurations.contains(configuration));

    _runConfigurations([configuration]);
  }

  void _runConfigurations(List<BenchmarkRunConfiguration> configurations) {
    if (configurations.isEmpty) {
      return;
    }

    final runPlan = BenchmarkPlan(
      warmUpDuration: plan.warmUpDuration,
      benchmarkDuration: plan.benchmarkDuration,
      runConfigurations: configurations,
    );

    _planRunner = BenchmarkPlanRunner(
      plan: runPlan,
      logger: Logger.root,
      catchExceptions: true,
      observer: this,
    );
    _planRunner!.start();

    _status = RunControllerStatus.running;
    notifyListeners();
  }

  void stop() {
    assert(_status == RunControllerStatus.running);

    _planRunner!.stop().then((_) {
      _status = RunControllerStatus.notRunning;
      notifyListeners();
    });

    _status = RunControllerStatus.stopping;
    notifyListeners();
  }

  @override
  void didChangePlanRunner(BenchmarkPlanRunner runner) {
    if (runner.status == PlanRunnerStatus.done ||
        runner.status == PlanRunnerStatus.failed ||
        runner.status == PlanRunnerStatus.notRunning) {
      _planRunner = null;
      _status = RunControllerStatus.notRunning;
      notifyListeners();
    }
  }

  @override
  void willStartRun(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
  ) {
    _currentConfiguration = configuration;
    notifyListeners();
  }

  @override
  void didChangeBenchmarkRunner(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
    BenchmarkRunner<Object, BenchmarkDoc<Object>> benchmarkRunner,
  ) {
    final isWarmUp =
        benchmarkRunner.lifecycle == BenchmarkRunnerLifecycle.warmUp;
    if (_isWarmUp != isWarmUp) {
      _isWarmUp = isWarmUp;
      notifyListeners();
    }

    if (_lifecycle != benchmarkRunner.lifecycle) {
      _lifecycle = benchmarkRunner.lifecycle;
      notifyListeners();
    }

    if (benchmarkRunner.lifecycle == BenchmarkRunnerLifecycle.warmUp ||
        benchmarkRunner.lifecycle == BenchmarkRunnerLifecycle.run) {
      progress.value = (benchmarkRunner.progress * 100).toInt();
    }
  }

  @override
  void didFinishRun(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
    BenchmarkResult result,
  ) {
    _currentConfiguration = null;
    _lifecycle = null;
    progress.value = null;
    _isWarmUp = null;
    notifyListeners();

    _addResult(configuration, result);
  }

  @override
  void didFinishRunWithError(
    BenchmarkPlanRunner runner,
    BenchmarkRunConfiguration configuration,
    Object error,
    StackTrace stackTrace,
  ) {
    _currentConfiguration = null;
    _lifecycle = null;
    progress.value = null;
    _isWarmUp = null;
    notifyListeners();

    _addResult(
      configuration,
      BenchmarkThrewException(error.toString(), stackTrace),
    );
  }

  final _resultsByConfiguration = <BenchmarkRunConfiguration, List<Object>>{};

  List<Object> getResults(BenchmarkRunConfiguration configuration) {
    return List.unmodifiable(_resultsByConfiguration[configuration]!);
  }

  void resetResults({BenchmarkRunConfiguration? configuration}) {
    if (configuration != null) {
      assert(plan.runConfigurations.contains(configuration));
      _resultsByConfiguration[configuration]!.clear();
    } else {
      for (final results in _resultsByConfiguration.values) {
        results.clear();
      }
    }
    notifyListeners();
  }

  void _addResult(BenchmarkRunConfiguration configuration, Object result) {
    assert(result is BenchmarkResult || result is BenchmarkThrewException);
    _resultsByConfiguration[configuration]!.add(result);
    notifyListeners();
  }

  void _updateResultsForNewPlan() {
    // Ensure there is a List for every configuration in
    // _resultsByConfiguration.
    for (final configuration in plan.runConfigurations) {
      _resultsByConfiguration[configuration] ??= <Object>[];
    }
  }
}

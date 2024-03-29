import 'dart:convert';
import 'dart:io';

import 'package:benchmark/benchmark.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'save_file.dart';
import 'settings_controller.dart';

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
      return allRunConfigurations
          .where((config) => config.isRunnable || hasResult(config))
          .toList();
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
    var configurations =
        _plan.runConfigurations.where((config) => config.isRunnable).toList();
    if (onlyIfWithoutResult) {
      configurations = configurations.whereNot(hasResult).toList();
    }

    _runConfigurations(configurations);
  }

  void runConfiguration(BenchmarkRunConfiguration configuration) {
    assert(_status == RunControllerStatus.notRunning);
    assert(configuration.isRunnable);
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
    // TODO: make errors viewable in UI
    print(error);
    print(stackTrace);
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

  bool hasResult(BenchmarkRunConfiguration configuration) =>
      (_resultsByConfiguration[configuration]?.isNotEmpty ?? false);

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

  Future<void> exportResults() async {
    final now = DateTime.now().toUtc();
    final fileName = 'DB_Bench-${now.millisecondsSinceEpoch}.json';
    late final jsonResults = JsonUtf8Encoder().convert(MultiBenchmarkResults(
      plan: plan,
      resultsByConfiguration: _resultsByConfiguration,
    ).toJson()) as Uint8List;

    String? filePath;
    if (Platform.isIOS) {
      filePath =
          path.join((await getApplicationDocumentsDirectory()).path, fileName);
    } else if (Platform.isAndroid) {
      return await FileSelectorPlugin.instance.saveFile(
        title: fileName,
        contentType: 'application/json',
        data: jsonResults,
      );
    } else if (kIsWeb) {
      throw UnimplementedError('Exporting results is not supported on web.');
    } else {
      filePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Export results',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
    }

    if (filePath != null) {
      await File(filePath).writeAsBytes(jsonResults);
    }
  }

  Future<void> importResults() async {
    final pickedFiles = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
      dialogTitle: 'Import results',
    );
    final pickedFile = pickedFiles?.files.first;

    if (pickedFile == null) {
      // User cancelled.
      return;
    }

    if (pickedFile.extension != 'json') {
      throw Exception('Invalid file extension: ${pickedFile.extension}');
    }

    final resultsAsJson =
        json.fuse(utf8).decode(pickedFile.bytes!) as Map<String, Object?>;

    final results = MultiBenchmarkResults.fromJson(
      resultsAsJson,
      benchmarks: {
        for (final benchmark in allBenchmarks) benchmark.name: benchmark,
      },
      databaseProviders: {
        for (final databaseProvider in allDatabaseProviders)
          databaseProvider.name: databaseProvider,
      },
      parameters: {
        for (final parameter in <Parameter>[execution, batchSize])
          parameter.name: parameter,
      },
    );

    _resultsByConfiguration.clear();
    _resultsByConfiguration.addAll(results.resultsByConfiguration);
    plan = results.plan;
  }
}

import 'package:benchmark/benchmark.dart';
import 'package:cbl_provider/cbl_provider.dart';
import 'package:drift_provider/drift_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_provider/hive_provider.dart';
import 'package:isar_provider/isar_provider.dart';
import 'package:objectbox_provider/objectbox_provider.dart';
import 'package:realm_provider/realm_provider.dart';

final _allDatabaseProviders = <Symbol, DatabaseProvider>{
  #cbl: CblProvider(),
  #drift: DriftProvider(),
  #hive: HiveProvider(),
  #isar: IsarProvider(),
  #objectBox: ObjectBoxProvider(),
  #realm: RealmProvider(),
};

final allDatabaseProviders = _allDatabaseProviders.values.toList();

final databaseProviderColors = <DatabaseProvider, Color>{
  _allDatabaseProviders[#cbl]!: Colors.blue,
  _allDatabaseProviders[#drift]!: Colors.green,
  _allDatabaseProviders[#hive]!: Colors.purple,
  _allDatabaseProviders[#isar]!: Colors.orange,
  _allDatabaseProviders[#objectBox]!: Colors.red,
  _allDatabaseProviders[#realm]!: Colors.yellow,
};

const _defaultBatchSizes = [1, 10, 100, 1000, 10000];
const _defaultEnabledBatchSizes = [1, 10, 100, 1000, 10000];

class SettingsController extends ChangeNotifier {
  final warmUpDuration = const FixedTimedDuration(Duration(milliseconds: 100));
  final benchmarkDuration = const FixedTimedDuration(Duration(seconds: 1));

  List<Benchmark> get benchmarks => _benchmarks;
  final List<Benchmark> _benchmarks = [...allBenchmarks];

  void setBenchmarkEnabled(Benchmark benchmark, {required bool isEnabled}) {
    if (isEnabled) {
      _benchmarks.add(benchmark);
      _benchmarks.sort((a, b) => a.name.compareTo(b.name));
    } else {
      _benchmarks.remove(benchmark);
    }
    notifyListeners();
  }

  List<DatabaseProvider> get databaseProviders => _databaseProviders;
  final List<DatabaseProvider> _databaseProviders = [
    ..._allDatabaseProviders.values
  ];

  void setDatabaseProviderEnabled(
    DatabaseProvider databaseProvider, {
    required bool isEnabled,
  }) {
    if (isEnabled) {
      _databaseProviders.add(databaseProvider);
      _databaseProviders.sort((a, b) => a.name.compareTo(b.name));
    } else {
      _databaseProviders.remove(databaseProvider);
    }
    notifyListeners();
  }

  List<Execution> get executions => _executions;
  final _executions = Execution.values.toList();

  void setExecutionEnabled(Execution execution, {required bool isEnabled}) {
    if (isEnabled) {
      _executions.add(execution);
      _executions.sort((a, b) => a.name.compareTo(b.name));
    } else {
      _executions.remove(execution);
    }
    notifyListeners();
  }

  List<int> get batchSizes => _batchSizes;
  final _batchSizes = [..._defaultBatchSizes];

  void removeBatchSize(int batchSize) {
    _batchSizes.remove(batchSize);
    _enabledBatchSizes.remove(batchSize);
    notifyListeners();
  }

  void addBatchSize(int batchSize) {
    _batchSizes.add(batchSize);
    _batchSizes.sort();
    _enabledBatchSizes.add(batchSize);
    _enabledBatchSizes.sort();
    notifyListeners();
  }

  List<int> get enabledBatchSize => _enabledBatchSizes;
  final _enabledBatchSizes = [..._defaultEnabledBatchSizes];

  void setBatchSizeEnabled(int batchSize, {required bool isEnabled}) {
    if (isEnabled) {
      _enabledBatchSizes.add(batchSize);
      _enabledBatchSizes.sort();
    } else {
      _enabledBatchSizes.remove(batchSize);
    }
    notifyListeners();
  }

  BenchmarkPlan get plan {
    final allArguments = [
      ListParameterRange(execution, executions),
      ListParameterRange(batchSize, enabledBatchSize),
    ].crossProduct().toList();

    return BenchmarkPlan(
      warmUpDuration: warmUpDuration,
      benchmarkDuration: benchmarkDuration,
      runConfigurations: [
        for (final databaseProvider in databaseProviders)
          for (final benchmark in benchmarks)
            for (final arguments in allArguments)
              BenchmarkRunConfiguration(
                benchmark: benchmark,
                databaseProvider: databaseProvider,
                arguments: arguments,
              )
      ],
    );
  }
}

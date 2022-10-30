import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:benchmark/benchmark.dart';
import 'package:beto_client/beto_client.dart';
import 'package:beto_common/beto_common.dart' as beto;
import 'package:cbl_provider/cbl_provider.dart';
import 'package:drift_provider/drift_provider.dart';
import 'package:hive_provider/hive_provider.dart';
import 'package:isar_provider/isar_provider.dart';
import 'package:logging/logging.dart';
import 'package:objectbox_provider/objectbox_provider.dart';
import 'package:path/path.dart' as p;
import 'package:realm_provider/realm_provider.dart';

import 'git.dart';
import 'setup.dart';

const _allBenchmarksByName = {
  'create': CreateDocumentBenchmark(),
  'read': ReadDocumentBenchmark(),
  'update': UpdateDocumentBenchmark(),
  'delete': DeleteDocumentBenchmark(),
};

final _allDatabaseProvidersByName = <String, DatabaseProvider>{
  'cbl': CblProvider(),
  if (!Platform.isWindows) 'drift': DriftProvider(),
  'realm': RealmProvider(),
  'hive': HiveProvider(),
  'isar': IsarProvider(),
  'object-box': ObjectBoxProvider(),
};

final _allExecutionsByName = {for (final e in Execution.values) e.name: e};

class RunCommand extends Command<void> {
  RunCommand() {
    argParser
      ..addMultiOption(
        'benchmark',
        abbr: 'b',
        help: 'The benchmarks to run.',
        allowed: _allBenchmarksByName.keys,
        defaultsTo: _allBenchmarksByName.keys,
      )
      ..addMultiOption(
        'database',
        abbr: 'd',
        help: 'The databases to benchmark.',
        allowed: [..._allDatabaseProvidersByName.keys, 'all'],
        defaultsTo: _allDatabaseProvidersByName.keys
            // For isar and standalone Dart the binaries have to be installed
            // manually. This is why we don't include isar in the default list.
            .where((name) => name != 'isar'),
      )
      ..addMultiOption(
        'execution',
        abbr: 'e',
        help:
            'The types of execution to run benchmarks for. If a database does '
            'not support the given execution type, it will be skipped.',
        allowed: _allExecutionsByName.keys,
        defaultsTo: _allExecutionsByName.keys,
      )
      ..addMultiOption(
        'batch-size',
        abbr: 's',
        help: 'The number of documents to process in a batch.',
        defaultsTo: ['1', '10', '100', '1000'],
        callback: (values) {
          for (final value in values) {
            final number = int.tryParse(value);
            if (number == null) {
              usageException(
                'Invalid batch size: "$value". Could not be parsed as an '
                'integer.',
              );
            }
            if (number <= 0) {
              usageException(
                'Invalid batch size: "$value". Must be greater than zero.',
              );
            }
          }
        },
      )
      ..addFlag(
        'abort-on-exception',
        abbr: 'c',
        help: 'Abort if a benchmark throws an exception instead of continuing '
            'with the next benchmark.',
        defaultsTo: false,
      )
      ..addFlag(
        'local-cbl-libs',
        help: 'Use local cbl-dart libraries.',
        hide: true,
        defaultsTo: false,
      )
      ..addOption(
        'beto-server-url',
        help: 'The url of the Beto server to submit results to.',
      )
      ..addOption(
        'beto-api-secret',
        help: 'The API secret to use to authenticate with the Beto server.',
      )
      ..addOption(
        'beto-device',
        help: 'The device to use when submitting results to the Beto server.',
      );
  }

  @override
  String get name => 'run';

  @override
  String get description => 'Run database benchmarks.';

  List<Benchmark> get _benchmarks => (argResults!['benchmark'] as List<String>)
      .map((value) => _allBenchmarksByName[value]!)
      .toList();

  List<DatabaseProvider> get _databaseProviders {
    final databases = argResults!['database'] as List<String>;
    if (databases.contains('all')) {
      return _allDatabaseProvidersByName.values.toList();
    }
    return databases
        .map((value) => _allDatabaseProvidersByName[value]!)
        .toList();
  }

  List<Execution> get _executions => (argResults!['execution'] as List<String>)
      .map((value) => _allExecutionsByName[value]!)
      .toList();

  List<int> get _batchSizes =>
      (argResults!['batch-size'] as List<String>).map(int.parse).toList();

  bool get abortOnException => argResults!['abort-on-exception'] as bool;

  bool get localCblLibs => argResults!['local-cbl-libs'] as bool;

  String? get betoServerUrl => argResults!['beto-server-url'] as String?;

  String? get betoApiSecret => argResults!['beto-api-secret'] as String?;

  String? get betoDevice => argResults!['beto-device'] as String?;

  @override
  Future<void> run() async {
    if ((betoServerUrl != null) &&
        (betoApiSecret == null || betoDevice == null)) {
      usageException(
        'The beto-api-secret and beto-device options must be set if the '
        'beto-server-url option is set.',
      );
    }

    await setup(localCblLibs: localCblLibs);

    Logger.root
      ..onRecord.listen((LogRecord rec) {
        // ignore: avoid_print
        print(rec.message);
      })
      ..level = Level.INFO;

    final startTime = DateTime.now();
    final commit = currentCommit();

    final results = await runParameterMatrix(
      benchmarks: _benchmarks,
      databasesProviders: _databaseProviders,
      arguments: [
        ListParameterRange(execution, _executions),
        ListParameterRange(batchSize, _batchSizes)
      ].crossProduct().toList(),
      catchExceptions: !abortOnException,
    );

    Logger.root.info(results.toAsciiTable());

    await _writeCsvResultsTable(results);

    if (betoServerUrl != null) {
      Logger.root.info('Submitting results to Beto server...');
      await submitBenchmarkResultsToBetoServer(
        serverUrl: betoServerUrl!,
        credentials: ApiSecret(betoApiSecret!),
        commit: commit,
        startTime: startTime,
        environment: beto.Environment.current(device: betoDevice!),
        results: results,
      );
    }
  }

  Future<void> _writeCsvResultsTable(BenchmarkResults results) async {
    final now = DateTime.now();
    final resultsFileName =
        'benchmark_results_${now.millisecondsSinceEpoch}.csv';
    final resultsFile = File(p.join(Directory.current.path, resultsFileName));
    await resultsFile.writeAsString(results.toCsvTable());
  }
}

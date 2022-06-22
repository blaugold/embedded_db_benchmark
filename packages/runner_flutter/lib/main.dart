import 'dart:io';

import 'package:benchmark/benchmark.dart';
import 'package:cbl_provider/cbl_provider.dart';
import 'package:drift_provider/drift_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_provider/hive_provider.dart';
import 'package:isar_provider/isar_provider.dart';
import 'package:logging/logging.dart';
import 'package:objectbox_provider/objectbox_provider.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:realm_provider/realm_provider.dart';

import 'setup.dart';

Future<Map<String, String>> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  Logger.root
    ..onRecord.listen((LogRecord rec) {
      // ignore: avoid_print
      print(rec.message);
    })
    ..level = Level.INFO;

  final results = await runParameterMatrix(
    databasesProviders: <DatabaseProvider>[
      CblProvider(),
      DriftProvider(),
      RealmProvider(),
      HiveProvider(),
      IsarProvider(),
      ObjectBoxProvider(),
    ].where((provider) => provider.supportsCurrentPlatform).toList(),
  );

  results.toAsciiTable().split('\n').forEach(Logger.root.info);

  final documentsDir = await getApplicationDocumentsDirectory();
  final now = DateTime.now();
  final resultsFileName = 'benchmark_results_${now.millisecondsSinceEpoch}.csv';
  final resultsFile = File(p.join(documentsDir.path, resultsFileName));
  final resultsTable = results.toCsvTable();
  await resultsFile.writeAsString(resultsTable);

  return {
    'benchmark_results_filename': resultsFileName,
    'benchmark_results': resultsTable,
  };
}

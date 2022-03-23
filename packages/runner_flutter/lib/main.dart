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

  final runs = await runParameterMatrix(
    databasesProviders: [
      CblProvider(),
      if (!Platform.isLinux && !Platform.isWindows) DriftProvider(),
      // Realm is not supported on Linux.
      if (!Platform.isLinux) RealmProvider(),
      HiveProvider(),
      // Isar is broken on iOS currently.
      // https://github.com/isar/isar/issues/225
      if (!Platform.isIOS) IsarProvider(),
      // Requires Application Group in sandboxed apps, which macOS Flutter apps
      // are.
      if (!Platform.isMacOS) ObjectBoxProvider(),
    ],
  );

  runsToAsciiTable(runs).split('\n').forEach(Logger.root.info);

  final documentsDir = await getApplicationDocumentsDirectory();
  final now = DateTime.now();
  final resultsFileName = 'benchmark_results_${now.millisecondsSinceEpoch}.csv';
  final resultsFile = File(p.join(documentsDir.path, resultsFileName));
  final results = runsToCsv(runs);
  await resultsFile.writeAsString(results);

  return {
    'benchmark_results_filename': resultsFileName,
    'benchmark_results': results,
  };
}

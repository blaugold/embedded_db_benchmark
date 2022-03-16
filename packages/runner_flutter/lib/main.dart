import 'dart:io';

import 'package:benchmark/benchmark.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  Logger.root
    ..onRecord.listen((LogRecord rec) {
      // ignore: avoid_print
      print(rec.message);
    })
    ..level = Level.INFO;

  final runs = await runBenchmarks(
    benchmarks: [
      CreateDocumentBenchmark(),
      ReadDocumentBenchmark(),
      DeleteDocumentBenchmark(),
    ],
    databasesProviders: [
      CblProvider(),
      // Realm is not supported on Linux.
      if (!Platform.isLinux) RealmProvider(),
      HiveProvider(),
      // Isar is broken on iOS currently.
      // https://github.com/isar/isar/issues/187
      if (!Platform.isIOS) IsarProvider(),
      // Requires Application Group in sandboxed apps, which macOS Flutter apps
      // are.
      if (!Platform.isMacOS) ObjectBoxProvider(),
    ],
  );

  printRuns(runs).split('\n').forEach(Logger.root.info);
}

import 'package:benchmark/benchmark.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  Logger.root.onRecord.listen((LogRecord rec) {
    // ignore: avoid_print
    print(rec.message);
  });

  await runBenchmarks(
    benchmarks: [
      WriteDocumentBenchmark(),
      // ReadDocumentBenchmark(),
    ],
    databasesProviders: [
      CblProvider(),
      // Requires App-Group in sandboxed apps which applies to the current
      // Flutter setup.
      // RealmProvider(),
      HiveProvider(),
      IsarProvider(),
      ObjectBoxProvider(),
    ],
  );
}

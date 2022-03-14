import 'package:benchmark/benchmark.dart';
import 'package:logging/logging.dart';

import 'setup.dart';

Future<void> main() async {
  await setup();

  Logger.root.onRecord.listen((LogRecord rec) {
    // ignore: avoid_print
    print(rec.message);
  });

  final runs = await runBenchmarks(
    benchmarks: [
      CreateDocumentBenchmark(),
      ReadDocumentBenchmark(),
    ],
    databasesProviders: [
      CblProvider(),
      RealmProvider(),
      HiveProvider(),
      // Isar is currently not easy to use with standalone Dart.
      // IsarProvider(),
      ObjectBoxProvider(),
    ],
  );

  Logger.root.info(printRuns(runs));
}

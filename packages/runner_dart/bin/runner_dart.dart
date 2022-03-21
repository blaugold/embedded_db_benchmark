import 'dart:io';

import 'package:benchmark/benchmark.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'setup.dart';

Future<void> main() async {
  await setup();

  Logger.root
    ..onRecord.listen((LogRecord rec) {
      // ignore: avoid_print
      print(rec.message);
    })
    ..level = Level.INFO;

  final progressHandler = stdout.hasTerminal ? _consoleProgressHandler() : null;

  final runs = await runParameterMatrix(
    benchmarks: [
      CreateDocumentBenchmark(),
      ReadDocumentBenchmark(),
      UpdateDocumentBenchmark(),
      DeleteDocumentBenchmark(),
    ],
    databasesProviders: [
      CblProvider(),
      RealmProvider(),
      HiveProvider(),
      // Isar is currently not easy to use with standalone Dart.
      // IsarProvider(),
      ObjectBoxProvider(),
    ],
    onRunnerChange: progressHandler,
  );

  Logger.root.info(runsToAsciiTable(runs));

  final now = DateTime.now();
  final resultsFileName = 'benchmark_results_${now.millisecondsSinceEpoch}.csv';
  final resultsFile = File(p.join(Directory.current.path, resultsFileName));
  await resultsFile.writeAsString(runsToCsv(runs));
}

OnBenchmarkRunnerChange _consoleProgressHandler() {
  var progress = -1;
  BenchmarkRunner? currentRunner;
  return (runner) {
    if (currentRunner != runner) {
      currentRunner = runner;
      progress = -1;
    }

    if (runner.lifecycle != BenchmarkRunnerLifecycle.executeOperations) {
      return;
    }

    final newProgress = (runner.progress * 100).toInt();
    if (newProgress != progress) {
      progress = newProgress;
    } else {
      // Don't print the same progress multiple times.
      return;
    }

    if (progress != 0) {
      stdout.write('\u001B[A\u001B[K\r');
    }
    stdout.write('Progress ${(progress).toInt()}%\n');
  };
}

import 'package:beto_client/beto_client.dart';
import 'package:beto_common/beto_common.dart';
import 'package:beto_common/beto_common.dart' as beto;
import 'package:collection/collection.dart';
import 'package:stats/stats.dart';

import '../benchmark.dart';

Future<void> submitBenchmarkResultsToBetoServer({
  required String serverUrl,
  required Credentials credentials,
  required String commit,
  required DateTime startTime,
  required Environment environment,
  required BenchmarkResults results,
}) async {
  final client = BetoServiceHttpClient(
    serverUrl: Uri.parse(serverUrl),
    credentials: credentials,
  );

  final record = BenchmarkRecord(
    startTime: startTime,
    commit: commit,
    environment: environment,
  );
  results.addToBenchmarkRecord(record);

  try {
    await client
        .submitBenchmarkData(SubmitBenchmarkDataRequest(record: record));
  } finally {
    client.close();
  }
}

extension on BenchmarkResults {
  void addToBenchmarkRecord(BenchmarkRecord record) {
    final suite = Suite(name: 'embedded_db_benchmark');
    record.addSuite(suite);

    beto.Benchmark getBenchmark(String name) {
      final benchmark = suite.benchmarks.firstWhereOrNull(
        (benchmark) => benchmark.name == name,
      );
      if (benchmark != null) {
        return benchmark;
      }

      final newBenchmark = beto.Benchmark(name: name);
      suite.addBenchmark(newBenchmark);
      return newBenchmark;
    }

    beto.Metric getMetric(beto.Benchmark benchmark, String name) {
      final metric = benchmark.metrics.firstWhereOrNull(
        (metric) => metric.name == name,
      );
      if (metric != null) {
        return metric;
      }

      final newMetric = beto.Metric(name: name);
      benchmark.addMetric(newMetric);
      return newMetric;
    }

    for (final entry in successfulRuns.entries) {
      final configuration = entry.key;
      final result = entry.value;
      final parameters = {
        'database': configuration.databaseProvider.name,
        for (final parameter in plan.allParameters)
          parameter.name: parameter.describe(
            configuration.arguments.get<Object?>(parameter),
          ),
      };

      final benchmark = getBenchmark(configuration.benchmark.name);

      getMetric(benchmark, 'benchmarkRuntime').addValue(Value(
        statistic: Statistic.sum,
        value: result.benchmarkRunTime.inMicroseconds.toDouble(),
        parameters: parameters,
      ));
      getMetric(benchmark, 'operationsRuntime')
        ..addValue(Value(
          statistic: Statistic.sum,
          value: result.operationsRunTime.inMicroseconds.toDouble(),
          parameters: parameters,
        ))
        ..addValue(Value(
          statistic: Statistic.average,
          value: result.avgOperationRunTime.toDouble(),
          parameters: parameters,
        ));
      getMetric(benchmark, 'operations').addValue(Value(
        statistic: Statistic.count,
        value: result.operations.toDouble(),
        parameters: parameters,
      ));
      getMetric(benchmark, 'operationsPerSecond').addValue(Value(
        statistic: Statistic.average,
        value: result.avgOperationThroughput.toDouble(),
        parameters: parameters,
      ));

      final measurementOperationsStat = Stats.fromData(
        result.measurements.map((measurement) => measurement.operations),
      );
      getMetric(benchmark, 'measurementOperations')
        ..addValue(Value(
          statistic: Statistic.min,
          value: measurementOperationsStat.min.toDouble(),
          parameters: parameters,
        ))
        ..addValue(Value(
          statistic: Statistic.max,
          value: measurementOperationsStat.max.toDouble(),
          parameters: parameters,
        ))
        ..addValue(Value(
          statistic: Statistic.median,
          value: measurementOperationsStat.median.toDouble(),
          parameters: parameters,
        ))
        ..addValue(Value(
          statistic: Statistic.stdDev,
          value: measurementOperationsStat.standardDeviation.toDouble(),
          parameters: parameters,
        ))
        ..addValue(Value(
          statistic: Statistic.stdErr,
          value: measurementOperationsStat.standardError.toDouble(),
          parameters: parameters,
        ));

      final measurementRuntimeStat = Stats.fromData(
        result.measurements.map((measurement) => measurement.microseconds),
      );
      getMetric(benchmark, 'measurementRuntime')
        ..addValue(Value(
          statistic: Statistic.min,
          value: measurementRuntimeStat.min.toDouble(),
          parameters: parameters,
        ))
        ..addValue(Value(
          statistic: Statistic.max,
          value: measurementRuntimeStat.max.toDouble(),
          parameters: parameters,
        ))
        ..addValue(Value(
          statistic: Statistic.median,
          value: measurementRuntimeStat.median.toDouble(),
          parameters: parameters,
        ))
        ..addValue(Value(
          statistic: Statistic.stdDev,
          value: measurementRuntimeStat.standardDeviation.toDouble(),
          parameters: parameters,
        ))
        ..addValue(Value(
          statistic: Statistic.stdErr,
          value: measurementRuntimeStat.standardError.toDouble(),
          parameters: parameters,
        ));
    }
  }
}

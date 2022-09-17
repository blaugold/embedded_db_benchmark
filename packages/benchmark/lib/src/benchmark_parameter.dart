import 'package:logging/logging.dart';

import 'benchmark.dart';
import 'benchmark/all_benchmarks.dart';
import 'database_provider.dart';
import 'parameter.dart';

enum Execution {
  sync,
  async,
}

final execution = EnumParameter('execution', Execution.values);

final batchSize = NumericParameter<int>('batch-size', min: 1);

/// Runs every benchmark for every database and every combination of parameters.
Future<BenchmarkResults> runParameterMatrix({
  List<Benchmark> benchmarks = allBenchmarks,
  required List<DatabaseProvider> databasesProviders,
  Iterable<ParameterArguments>? arguments,
  bool catchExceptions = false,
  Logger? logger,
}) async {
  logger ??= Logger('BenchmarkRunner');
  const warmUpDuration = FixedTimedDuration(Duration(milliseconds: 100));
  const benchmarkDuration = FixedTimedDuration(Duration(seconds: 1));
  arguments ??= <ParameterRange<Object?>>[
    ParameterRange.all(execution),
    ListParameterRange(batchSize, [1, 10, 100, 1000]),
  ].crossProduct();

  [
    'Running the following benchmarks:',
    for (final benchmark in benchmarks) ' - ${benchmark.name}'
  ].forEach(logger.info);
  logger.info('');

  [
    'Benchmarking the following databases:',
    for (final databaseProvider in databasesProviders)
      ' - ${databaseProvider.name}'
  ].forEach(logger.info);
  logger.info('');

  final plan = BenchmarkPlan(
    warmUpDuration: warmUpDuration,
    benchmarkDuration: benchmarkDuration,
    runConfigurations: [
      for (final benchmark in benchmarks)
        for (final databaseProvider in databasesProviders)
          for (final arguments in arguments)
            BenchmarkRunConfiguration(
              benchmark: benchmark,
              databaseProvider: databaseProvider,
              arguments: arguments,
            ),
    ],
  );

  return BenchmarkPlanRunner(
    plan: plan,
    logger: logger,
    catchExceptions: catchExceptions,
    observer: LoggerBenchmarkPlanObserver(logger),
  ).runUntilDone();
}

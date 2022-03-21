import 'package:logging/logging.dart';

import 'benchmark.dart';
import 'database_provider/database_provider.dart';
import 'parameter.dart';

enum Execution {
  sync,
  async,
}

final execution = EnumParameter('execution', Execution.values);

final batchSize = NumericParameter<int>('batch-size', min: 1);

/// Runs every benchmark for every database and every combination of parameters.
Future<List<BenchmarkRun>> runParameterMatrix({
  required List<Benchmark> benchmarks,
  required List<DatabaseProvider> databasesProviders,
  bool catchExceptions = false,
  OnBenchmarkRunnerChange? onRunnerChange,
  Logger? logger,
}) async {
  logger ??= Logger('BenchmarkRunner');
  const warmUpDuration = FixedTimedDuration(Duration(milliseconds: 500));
  const runDuration = FixedTimedDuration(Duration(seconds: 2));
  final allArguments = <ParameterRange<Object?>>[
    ParameterRange.single(execution, Execution.sync),
    ListParameterRange(batchSize, [1, 10, 100, 1000, 10000]),
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

  final runs = <BenchmarkRun>[];

  for (final benchmark in benchmarks) {
    logger.info('=== Benchmark: ${benchmark.name} '.padRight(80, '='));
    logger.info('');

    for (final arguments in allArguments) {
      final benchmarkSupportsArguments =
          benchmark.supportsParameterArguments(arguments);
      logger.info(
        '*** Parameter arguments '
                '${benchmarkSupportsArguments ? '' : '[SKIPPED] '}'
            .padRight(80, '*'),
      );
      logger.info(arguments.toString());

      if (!benchmarkSupportsArguments) {
        logger.info('Parameter arguments not supported by benchmark');
        logger.info('');
        continue;
      } else {
        logger.info('');
      }

      for (final databaseProvider in databasesProviders) {
        final databaseSupportsArguments =
            databaseProvider.supportsParameterArguments(arguments);

        logger.info(
          '--- Database:  ${databaseProvider.name} '
                  '${databaseSupportsArguments ? '' : '[SKIPPED] '} '
              .padRight(80, '-'),
        );

        if (!databaseSupportsArguments) {
          logger.info('Parameter arguments not supported by database');
          logger.info('');
          continue;
        }

        try {
          final result = await runBenchmark(
            benchmark: benchmark,
            databaseProvider: databaseProvider,
            arguments: arguments,
            warmUpDuration: warmUpDuration,
            runDuration: runDuration,
            onRunnerChange: onRunnerChange,
            logger: logger,
          );

          logger.info('Results:');

          [
            'Ops:     ${result.operations}',
            'Ops/s:   ${result.operationsPerSecond.floor()}',
            'Time:    ${result.operationsRunTime.inMicroseconds / 10e5}s',
            'Time/Op: ${result.timePerOperationInMicroseconds.ceil()}us'
          ].forEach(logger.info);

          logger.info('');

          runs.add(BenchmarkRun(
            benchmark: benchmark.name,
            database: databaseProvider.name,
            arguments: arguments,
            result: result,
          ));
        } catch (e, s) {
          if (catchExceptions) {
            logger.severe('Error running benchmark: $e', e, s);
          } else {
            rethrow;
          }
        }
      }
    }
  }

  return runs;
}

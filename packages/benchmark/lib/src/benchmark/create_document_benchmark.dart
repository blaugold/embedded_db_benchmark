import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';

import '../benchmark.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class CreateDocumentBenchmark extends Benchmark {
  @override
  String get name => 'CreateDocument';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.all(execution),
        ParameterRange.all(batchSize),
      ]);

  @override
  BenchmarkRunner<T> createRunner<T extends BenchmarkDoc>(
    ParameterCombination parameterCombination,
  ) {
    final BenchmarkRunner<T> benchmark;
    final batchSizeValue = parameterCombination.get(batchSize)!;

    switch (parameterCombination.get(execution)!) {
      case Execution.sync:
        if (batchSizeValue == 1) {
          benchmark = _SyncCreateOneDocumentBenchmark();
        } else {
          benchmark = _SyncCreateManyDocumentBenchmark(batchSizeValue);
        }
        break;
      case Execution.async:
        if (batchSizeValue == 1) {
          benchmark = _AsyncCreateOneDocumentBenchmark();
        } else {
          benchmark = _AsyncCreateManyDocumentBenchmark(batchSizeValue);
        }
        break;
    }

    return benchmark;
  }
}

class _SyncCreateOneDocumentBenchmark<T extends BenchmarkDoc>
    extends BenchmarkRunner<T> with BenchmarkDocumentMixin {
  @override
  Future<void> executeOperations() async {
    await database.clear();
    final document = database.createBenchmarkDocImpl(createBenchmarkDoc());
    measureOperationsSync(() => database.createDocumentSync(document));
  }
}

class _AsyncCreateOneDocumentBenchmark<T extends BenchmarkDoc>
    extends BenchmarkRunner<T> with BenchmarkDocumentMixin {
  @override
  Future<void> executeOperations() async {
    await database.clear();
    final document = database.createBenchmarkDocImpl(createBenchmarkDoc());
    await measureOperationsAsync(() => database.createDocumentAsync(document));
  }
}

class _SyncCreateManyDocumentBenchmark<T extends BenchmarkDoc>
    extends BenchmarkRunner<T> with BenchmarkDocumentMixin {
  _SyncCreateManyDocumentBenchmark(this._batchSize);

  final int _batchSize;

  @override
  Future<void> executeOperations() async {
    await database.clear();
    final documents = createBenchmarkDocs(_batchSize)
        .map(database.createBenchmarkDocImpl)
        .toList(growable: false);
    measureOperationsSync(
      () => database.createDocumentsSync(documents),
      operations: _batchSize,
    );
  }
}

class _AsyncCreateManyDocumentBenchmark<T extends BenchmarkDoc>
    extends BenchmarkRunner<T> with BenchmarkDocumentMixin {
  _AsyncCreateManyDocumentBenchmark(this._batchSize);

  final int _batchSize;

  @override
  Future<void> executeOperations() async {
    await database.clear();
    final documents = createBenchmarkDocs(_batchSize)
        .map(database.createBenchmarkDocImpl)
        .toList(growable: false);
    await measureOperationsAsync(
      () => database.createDocumentsAsync(documents),
      operations: _batchSize,
    );
  }
}

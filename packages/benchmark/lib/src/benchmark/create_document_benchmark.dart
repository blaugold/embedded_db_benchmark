import 'dart:async';

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
        ParameterRange.all(dataModel),
        ParameterRange.all(batchSize),
      ]);

  @override
  BenchmarkRunner createRunner(ParameterCombination parameterCombination) {
    final BenchmarkRunner benchmark;
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

class _SyncCreateOneDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  @override
  void executeOperations() {
    final document = createBenchmarkDoc();
    measureOperationsSync(() => database.createDocumentSync(document));
  }
}

class _AsyncCreateOneDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  @override
  Future<void> executeOperations() async {
    final document = createBenchmarkDoc();
    await measureOperationsAsync(() => database.createDocumentAsync(document));
  }
}

class _SyncCreateManyDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  _SyncCreateManyDocumentBenchmark(this._batchSize);

  final int _batchSize;

  @override
  void executeOperations() {
    final documents = createBenchmarkDocs(_batchSize);
    measureOperationsSync(
      () => database.createDocumentsSync(documents),
      operations: _batchSize,
    );
  }
}

class _AsyncCreateManyDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  _AsyncCreateManyDocumentBenchmark(this._batchSize);

  final int _batchSize;

  @override
  Future<void> executeOperations() async {
    final documents = createBenchmarkDocs(_batchSize);
    await measureOperationsAsync(
      () => database.createDocumentsAsync(documents),
      operations: _batchSize,
    );
  }
}

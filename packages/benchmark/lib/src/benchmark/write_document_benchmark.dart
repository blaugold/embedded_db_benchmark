import 'dart:async';

import '../benchmark.dart';
import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class WriteDocumentBenchmark extends Benchmark {
  @override
  String get name => 'WriteDocument';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.all(execution),
        ParameterRange.all(dataModel),
        ParameterRange.all(writeBatching),
      ]);

  @override
  BenchmarkRunner createRunner(ParameterCombination parameterCombination) {
    final BenchmarkRunner benchmark;

    switch (parameterCombination.get(execution)!) {
      case Execution.sync:
        if (parameterCombination.get(writeBatching)!) {
          benchmark = _SyncWriteManyDocumentBenchmark();
        } else {
          benchmark = _SyncWriteOneDocumentBenchmark();
        }
        break;
      case Execution.async:
        if (parameterCombination.get(writeBatching)!) {
          benchmark = _AsyncWriteManyDocumentBenchmark();
        } else {
          benchmark = _AsyncWriteOneDocumentBenchmark();
        }
        break;
    }

    return benchmark;
  }
}

class _SyncWriteOneDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  @override
  void executeOperations() {
    final database = this.database as InsertOneDocumentSync;
    final document = createDocument();
    measureOperationsSync(() => database.insertOneDocumentSync(document));
  }
}

class _AsyncWriteOneDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  @override
  Future<void> executeOperations() async {
    final database = this.database as InsertOneDocumentAsync;
    final document = createDocument();
    await measureOperationsAsync(
      () => database.insertOneDocumentAsync(document),
    );
  }
}

const _batchSize = 50;

class _SyncWriteManyDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  @override
  void executeOperations() {
    final database = this.database as InsertManyDocumentsSync;
    final documents = createDocuments(_batchSize);
    measureOperationsSync(
      () => database.insertManyDocumentsSync(documents),
      operations: _batchSize,
    );
  }
}

class _AsyncWriteManyDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  @override
  Future<void> executeOperations() async {
    final database = this.database as InsertManyDocumentsAsync;
    final documents = createDocuments(_batchSize);
    await measureOperationsAsync(
      () => database.insertManyDocumentsAsync(documents),
      operations: _batchSize,
    );
  }
}
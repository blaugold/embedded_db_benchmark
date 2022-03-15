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
  BenchmarkRunner<ID, T>
      createRunner<ID extends Object, T extends BenchmarkDoc<ID>>(
    ParameterCombination parameterCombination,
  ) {
    final BenchmarkRunner<ID, T> benchmark;
    final batchSizeValue = parameterCombination.get(batchSize)!;

    switch (parameterCombination.get(execution)!) {
      case Execution.sync:
        benchmark = _SyncCreateManyDocumentBenchmark(batchSizeValue);
        break;
      case Execution.async:
        benchmark = _AsyncCreateManyDocumentBenchmark(batchSizeValue);
        break;
    }

    return benchmark;
  }
}

class _SyncCreateManyDocumentBenchmark<ID extends Object,
        T extends BenchmarkDoc<ID>> extends BenchmarkRunner<ID, T>
    with BenchmarkDocumentMixin {
  _SyncCreateManyDocumentBenchmark(this._batchSize);

  final int _batchSize;

  @override
  Future<void> executeOperations() async {
    await database.clear();
    final documents = createBenchmarkDocs(_batchSize)
        .map(database.createBenchmarkDocImpl)
        .toList(growable: false);

    if (_batchSize == 1) {
      final document = documents.first;
      measureOperationsSync(
        () => database.createDocumentSync(document),
        operations: _batchSize,
      );
    } else {
      measureOperationsSync(
        () => database.createDocumentsSync(documents),
        operations: _batchSize,
      );
    }
  }
}

class _AsyncCreateManyDocumentBenchmark<ID extends Object,
        T extends BenchmarkDoc<ID>> extends BenchmarkRunner<ID, T>
    with BenchmarkDocumentMixin {
  _AsyncCreateManyDocumentBenchmark(this._batchSize);

  final int _batchSize;

  @override
  Future<void> executeOperations() async {
    await database.clear();
    final documents = createBenchmarkDocs(_batchSize)
        .map(database.createBenchmarkDocImpl)
        .toList(growable: false);

    if (_batchSize == 1) {
      final document = documents.first;
      await measureOperationsAsync(
        () => database.createDocumentAsync(document),
        operations: _batchSize,
      );
    } else {
      await measureOperationsAsync(
        () => database.createDocumentsAsync(documents),
        operations: _batchSize,
      );
    }
  }
}

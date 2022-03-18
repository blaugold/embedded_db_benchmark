import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';

import '../benchmark.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class UpdateDocumentBenchmark extends Benchmark {
  @override
  String get name => 'UpdateDocument';

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
    return _UpdateDocumentBenchmark(
      parameterCombination.get(execution)!,
      parameterCombination.get(batchSize)!,
    );
  }
}

class _UpdateDocumentBenchmark<ID extends Object, T extends BenchmarkDoc<ID>>
    extends BenchmarkRunner<ID, T> with BenchmarkDocumentMixin {
  _UpdateDocumentBenchmark(this._execution, this._batchSize);

  final Execution _execution;
  final int _batchSize;
  int _nextValue = 0;

  late final List<T> _documents;

  @override
  Future<void> setup() async {
    await super.setup();

    final implDocuments = createBenchmarkDocsImp(_batchSize);
    _documents = await database.createDocuments(implDocuments, _execution);
  }

  @override
  FutureOr<void> validateDatabase() async {
    final document =
        await database.createDocument(createBenchmarkDocImp(), _execution);

    document.balance = 'validate';
    await database.updateDocument(document, _execution);

    final loadedDocument =
        await database.getDocumentById(document.id, _execution);
    if (loadedDocument.balance != document.balance) {
      throw Exception(
        'Database is not correctly persisting updated document. '
        'Expected: ${document.balance}, actual: ${loadedDocument.balance}',
      );
    }
  }

  @override
  Future<void> executeOperations() async {
    for (final document in _documents) {
      document.balance = '${_nextValue++}';
    }

    if (_batchSize == 1) {
      await _updateDocumentMeasured(_documents.single);
    } else {
      await _updateDocumentsMeasured(_documents);
    }
  }

  FutureOr<void> _updateDocumentMeasured(T document) async {
    switch (_execution) {
      case Execution.sync:
        measureOperationsSync(() => database.updateDocumentSync(document));
        break;
      case Execution.async:
        await measureOperationsAsync(
          () => database.updateDocumentAsync(document),
        );
        break;
    }
  }

  FutureOr<void> _updateDocumentsMeasured(List<T> documents) async {
    switch (_execution) {
      case Execution.sync:
        measureOperationsSync(
          () => database.updateDocumentsSync(documents),
          operations: _batchSize,
        );
        break;
      case Execution.async:
        await measureOperationsAsync(
          () => database.updateDocumentsAsync(documents),
          operations: _batchSize,
        );
        break;
    }
  }
}

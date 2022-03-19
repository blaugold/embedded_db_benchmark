import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';

import '../benchmark.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class DeleteDocumentBenchmark extends Benchmark {
  @override
  String get name => 'DeleteDocument';

  @override
  bool supportsParameterArguments(ParameterArguments arguments) =>
      andPredicates([
        anyArgument(execution),
        anyArgument(batchSize),
      ])(arguments);

  @override
  BenchmarkRunner<ID, T>
      createRunner<ID extends Object, T extends BenchmarkDoc<ID>>(
    ParameterArguments arguments,
  ) {
    return _DeleteDocumentBenchmark(
      arguments.get(execution)!,
      arguments.get(batchSize)!,
    );
  }
}

class _DeleteDocumentBenchmark<ID extends Object, T extends BenchmarkDoc<ID>>
    extends BenchmarkRunner<ID, T> with BenchmarkDocumentMixin {
  _DeleteDocumentBenchmark(this._execution, this._batchSize);

  final Execution _execution;
  final int _batchSize;

  /// Validates that the database is correctly executing the operations.
  @override
  Future<void> validateDatabase() async {
    // In this step we create documents in the database and ask the database
    // to delete them.
    await executeOperations();

    // Now check that there are not documents left in the database.
    final allDocuments = await database.getAllDocuments(_execution);
    if (allDocuments.isNotEmpty) {
      throw Exception('Database is not correctly deleting documents.');
    }
  }

  @override
  Future<void> executeOperations() async {
    final documents = await _createDocuments();
    if (_batchSize == 1) {
      await _deleteDocumentMeasured(documents.single);
    } else {
      await _deleteDocumentsMeasured(documents);
    }
  }

  Future<List<T>> _createDocuments() async {
    final documents = createBenchmarkDocs(_batchSize);
    final implDocuments =
        documents.map(database.createBenchmarkDocImpl).toList(growable: false);
    return database.createDocuments(implDocuments, _execution);
  }

  Future<void> _deleteDocumentMeasured(T document) async {
    switch (_execution) {
      case Execution.sync:
        measureOperationsSync(
          () => database.deleteDocumentSync(document),
          operations: _batchSize,
        );
        break;
      case Execution.async:
        await measureOperationsAsync(
          () => database.deleteDocumentAsync(document),
          operations: _batchSize,
        );
        break;
    }
  }

  Future<void> _deleteDocumentsMeasured(List<T> documents) async {
    switch (_execution) {
      case Execution.sync:
        measureOperationsSync(
          () => database.deleteDocumentsSync(documents),
          operations: _batchSize,
        );
        break;
      case Execution.async:
        await measureOperationsAsync(
          () => database.deleteDocumentsAsync(documents),
          operations: _batchSize,
        );
        break;
    }
  }
}

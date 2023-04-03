import 'dart:async';

import '../benchmark.dart';
import '../benchmark_document.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class DeleteDocumentBenchmark extends Benchmark {
  const DeleteDocumentBenchmark();

  @override
  String get name => 'delete_document';

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
    return _DeleteDocumentBenchmark(arguments.get(batchSize)!);
  }
}

class _DeleteDocumentBenchmark<ID extends Object, T extends BenchmarkDoc<ID>>
    extends BenchmarkRunner<ID, T> with BenchmarkDocumentMixin {
  _DeleteDocumentBenchmark(this._batchSize);

  final int _batchSize;

  /// Validates that the database is correctly executing the operations.
  @override
  Future<void> validateDatabase() async {
    // In this step we create documents in the database and ask the database
    // to delete them.
    await executeOperations();

    // Now check that there are not documents left in the database.
    final allDocuments = await database.getAllDocuments();
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
    return database.createDocuments(implDocuments);
  }

  Future<void> _deleteDocumentMeasured(T document) async {
    await measureOperations(
      () => database.deleteDocument(document),
      operations: _batchSize,
    );
  }

  Future<void> _deleteDocumentsMeasured(List<T> documents) async {
    await measureOperations(
      () => database.deleteDocuments(documents),
      operations: _batchSize,
    );
  }
}

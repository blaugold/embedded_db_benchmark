import 'dart:async';

import '../benchmark.dart';
import '../benchmark_document.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class CreateDocumentBenchmark extends Benchmark {
  const CreateDocumentBenchmark();

  @override
  String get name => 'create_document';

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
    return _CreateDocumentBenchmark(arguments.get(batchSize)!);
  }
}

class _CreateDocumentBenchmark<ID extends Object, T extends BenchmarkDoc<ID>>
    extends BenchmarkRunner<ID, T> with BenchmarkDocumentMixin {
  _CreateDocumentBenchmark(this._batchSize);

  final int _batchSize;

  @override
  FutureOr<void> validateDatabase() async {
    await executeOperations();

    // We only check that the number of persisted documents is correct.
    // The ReadDocument benchmark also checks that the content is persisted
    // correctly.
    final allDocuments = await database.getAllDocuments();
    if (allDocuments.length != _batchSize) {
      throw Exception(
        'Database did not persist correct number of documents: '
        'expected: $_batchSize, actual: ${allDocuments.length}',
      );
    }
  }

  @override
  FutureOr<void> executeOperations() async {
    await database.clear();
    final documents = _createDatabaseDocuments();

    if (_batchSize == 1) {
      await _createDocumentMeasured(documents.first);
    } else {
      await _createDocumentsMeasured(documents);
    }
  }

  List<T> _createDatabaseDocuments() {
    return createBenchmarkDocs(_batchSize)
        .map(database.createBenchmarkDocImpl)
        .toList(growable: false);
  }

  Future<void> _createDocumentMeasured(T document) async {
    await measureOperations(
      () => database.createDocument(document),
      operations: _batchSize,
    );
  }

  Future<void> _createDocumentsMeasured(List<T> documents) async {
    await measureOperations(
      () => database.createDocuments(documents),
      operations: _batchSize,
    );
  }
}

import 'dart:async';

import '../benchmark.dart';
import '../benchmark_document.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class UpdateDocumentBenchmark extends Benchmark {
  const UpdateDocumentBenchmark();

  @override
  String get name => 'Update Document';

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
    return _UpdateDocumentBenchmark(arguments.get(batchSize)!);
  }
}

class _UpdateDocumentBenchmark<ID extends Object, T extends BenchmarkDoc<ID>>
    extends BenchmarkRunner<ID, T> with BenchmarkDocumentMixin {
  _UpdateDocumentBenchmark(this._batchSize);

  final int _batchSize;
  int _nextValue = 0;

  late final List<T> _documents;

  @override
  Future<void> setup() async {
    await super.setup();

    final implDocuments = createBenchmarkDocsImp(_batchSize);
    _documents = await database.createDocuments(implDocuments);
  }

  @override
  FutureOr<void> validateDatabase() async {
    final document = await database.createDocument(createBenchmarkDocImp());

    document.balance = 'validate';
    await database.updateDocument(document);

    final loadedDocument = await database.getDocumentById(document.id);
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
    await measureOperations(
      () => database.updateDocument(document),
    );
  }

  FutureOr<void> _updateDocumentsMeasured(List<T> documents) async {
    await measureOperations(
      () => database.updateDocuments(documents),
      operations: _batchSize,
    );
  }
}

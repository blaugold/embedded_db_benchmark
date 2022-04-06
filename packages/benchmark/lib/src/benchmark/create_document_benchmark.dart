import 'dart:async';

import '../benchmark.dart';
import '../benchmark_document.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class CreateDocumentBenchmark extends Benchmark {
  const CreateDocumentBenchmark();

  @override
  String get name => 'Create Document';

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
    return _CreateDocumentBenchmark(
      arguments.get(execution)!,
      arguments.get(batchSize)!,
    );
  }
}

class _CreateDocumentBenchmark<ID extends Object, T extends BenchmarkDoc<ID>>
    extends BenchmarkRunner<ID, T> with BenchmarkDocumentMixin {
  _CreateDocumentBenchmark(this._execution, this._batchSize);

  final Execution _execution;
  final int _batchSize;

  @override
  FutureOr<void> validateDatabase() async {
    await executeOperations();

    // We only check that the number of persisted documents is correct.
    // The ReadDocument benchmark also checks that the content is persisted
    // correctly.
    final allDocuments = await database.getAllDocuments(_execution);
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
    switch (_execution) {
      case Execution.sync:
        measureOperationsSync(
          () => database.createDocumentSync(document),
          operations: _batchSize,
        );
        break;
      case Execution.async:
        await measureOperationsAsync(
          () => database.createDocumentAsync(document),
          operations: _batchSize,
        );
        break;
    }
  }

  Future<void> _createDocumentsMeasured(List<T> documents) async {
    switch (_execution) {
      case Execution.sync:
        measureOperationsSync(
          () => database.createDocumentsSync(documents),
          operations: _batchSize,
        );
        break;
      case Execution.async:
        await measureOperationsAsync(
          () => database.createDocumentsAsync(documents),
          operations: _batchSize,
        );
        break;
    }
  }
}

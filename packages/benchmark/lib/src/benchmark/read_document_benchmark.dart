import 'dart:async';
import 'dart:convert';

import 'package:test/expect.dart';

import '../benchmark.dart';
import '../benchmark_document.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

/// The number of documents that are in the database when the benchmark is run.
const _documentsInDatabase = 10000;

class ReadDocumentBenchmark extends Benchmark {
  const ReadDocumentBenchmark();

  @override
  String get name => 'Read Document';

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
    return _ReadDocumentBenchmark(
      arguments.get(execution)!,
      arguments.get(batchSize)!,
    );
  }
}

class _ReadDocumentBenchmark<ID extends Object, T extends BenchmarkDoc<ID>>
    extends BenchmarkRunner<ID, T> with BenchmarkDocumentMixin {
  _ReadDocumentBenchmark(this._execution, this._batchSize);

  final Execution _execution;
  final int _batchSize;

  List<T>? _documents;
  late final List<ID> _documentIds;

  List<ID> get _currentDocumentIds => List.generate(
        _batchSize,
        (i) => _documentIds[(executedOperations + i) % _documentIds.length],
      );

  @override
  Future<void> setup() async {
    await super.setup();

    List<BenchmarkDoc<ID>> documents =
        createBenchmarkDocs(_documentsInDatabase);
    if (_batchSize > documents.length) {
      throw Exception(
        'Batch size is larger than the number of documents inserted during '
        'setup. Increase the _documentsInDatabase constant or decrees the '
        'batch size.',
      );
    }

    // Insert documents.
    _documents = documents = await database.createDocuments(
      documents.map(database.createBenchmarkDocImpl).toList(growable: false),
      _execution,
    );
    _documentIds = documents.map((doc) => doc.id).toList();
  }

  @override
  FutureOr<void> validateDatabase() async {
    // Verify that document can be persisted and loaded correctly.
    for (final document in _documents!) {
      final loadedDocument =
          await database.getDocumentById(document.id, _execution);

      final documentJson = document.toJson();
      final loadedDocumentJson = loadedDocument.toJson();

      final matcher = equals(documentJson);
      final matchState = <Object?, Object?>{};

      if (!matcher.matches(loadedDocumentJson, matchState)) {
        Description mismatchDescription = StringDescription();
        mismatchDescription = matcher.describeMismatch(
          loadedDocumentJson,
          mismatchDescription,
          matchState,
          true,
        );

        const jsonEncoder = JsonEncoder.withIndent('  ');

        throw Exception(
          'The database did not persisted document correctly:\n'
          '$mismatchDescription\n'
          'Expected: ${jsonEncoder.convert(documentJson)}\n'
          'Actual: ${jsonEncoder.convert(loadedDocumentJson)}',
        );
      }
    }

    // Once we are done with validation the actual documents are not needed
    // anymore and we don't want to keep them in memory.
    _documents = null;
  }

  @override
  Future<void> executeOperations() async {
    final documentIds = _currentDocumentIds;
    if (_batchSize == 1) {
      await _getDocumentByIdMeasured(documentIds.single);
    } else {
      await _getDocumentsByIdMeasured(documentIds);
    }
  }

  FutureOr<void> _getDocumentByIdMeasured(ID id) async {
    switch (_execution) {
      case Execution.sync:
        measureOperationsSync(
          () => database.getDocumentByIdSync(id),
          operations: _batchSize,
        );
        break;
      case Execution.async:
        await measureOperationsAsync(
          () => database.getDocumentByIdAsync(id),
          operations: _batchSize,
        );
        break;
    }
  }

  FutureOr<void> _getDocumentsByIdMeasured(List<ID> ids) async {
    switch (_execution) {
      case Execution.sync:
        measureOperationsSync(
          () => database.getDocumentsByIdSync(ids),
          operations: _batchSize,
        );
        break;
      case Execution.async:
        await measureOperationsAsync(
          () => database.getDocumentsByIdAsync(ids),
          operations: _batchSize,
        );
        break;
    }
  }
}

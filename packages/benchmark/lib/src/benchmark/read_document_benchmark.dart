import 'dart:async';
import 'dart:convert';

import 'package:benchmark_document/benchmark_document.dart';
import 'package:test/expect.dart';

import '../benchmark.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class ReadDocumentBenchmark extends Benchmark {
  @override
  String get name => 'ReadDocument';

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
        benchmark = _SyncReadOneDocumentBenchmark(batchSizeValue);
        break;
      case Execution.async:
        benchmark = _AsyncReadOneDocumentBenchmark(batchSizeValue);
        break;
    }

    return benchmark;
  }
}

abstract class _ReadDocumentBase<ID extends Object, T extends BenchmarkDoc<ID>>
    extends BenchmarkRunner<ID, T> with BenchmarkDocumentMixin {
  _ReadDocumentBase(this._batchSize);

  final int _batchSize;

  late final List<ID> documentIds;

  List<ID> get currentDocumentIds => List.generate(
        _batchSize,
        (i) => documentIds[(executedOperations + i) % documentIds.length],
      );

  @override
  Future<void> setup() async {
    await super.setup();

    List<BenchmarkDoc<ID>> documents = createBenchmarkDocs(1000);
    assert(_batchSize <= documents.length);

    // Insert documents.
    documents = await database.createDocumentsAsync(
      documents.map(database.createBenchmarkDocImpl).toList(growable: false),
    );
    documentIds = documents.map((doc) => doc.id).toList();

    // Verify that document can be persisted and loaded correctly.
    for (final document in documents) {
      final loadedDocument = await database.getDocumentByIdAsync(document.id);

      var documentJson = document.toJson();
      var loadedDocumentJson = loadedDocument.toJson();

      var matcher = equals(documentJson);
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
  }
}

class _SyncReadOneDocumentBenchmark<ID extends Object,
    T extends BenchmarkDoc<ID>> extends _ReadDocumentBase<ID, T> {
  _SyncReadOneDocumentBenchmark(int batchSize) : super(batchSize);

  @override
  void executeOperations() {
    final documentIds = currentDocumentIds;
    if (documentIds.length == 1) {
      final documentId = documentIds.single;
      measureOperationsSync(
        () => database.getDocumentByIdSync(documentId),
        operations: _batchSize,
      );
    } else {
      measureOperationsSync(
        () => database.getDocumentsByIdSync(documentIds),
        operations: _batchSize,
      );
    }
  }
}

class _AsyncReadOneDocumentBenchmark<ID extends Object,
    T extends BenchmarkDoc<ID>> extends _ReadDocumentBase<ID, T> {
  _AsyncReadOneDocumentBenchmark(int batchSize) : super(batchSize);

  @override
  Future<void> executeOperations() async {
    final documentIds = currentDocumentIds;
    if (documentIds.length == 1) {
      final documentId = documentIds.single;
      await measureOperationsAsync(
        () => database.getDocumentByIdAsync(documentId),
        operations: _batchSize,
      );
    } else {
      await measureOperationsAsync(
        () => database.getDocumentsByIdAsync(documentIds),
        operations: _batchSize,
      );
    }
  }
}

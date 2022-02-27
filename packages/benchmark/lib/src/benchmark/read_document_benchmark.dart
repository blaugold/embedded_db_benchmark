import 'dart:async';
import 'dart:convert';

import 'package:test/expect.dart';

import '../benchmark.dart';
import '../benchmark_database.dart';
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
        ParameterRange.all(dataModel),
      ]);

  @override
  BenchmarkRunner createRunner(ParameterCombination parameterCombination) {
    final BenchmarkRunner benchmark;

    switch (parameterCombination.get(execution)!) {
      case Execution.sync:
        benchmark = _SyncReadOneDocumentBenchmark();
        break;
      case Execution.async:
        benchmark = _AsyncReadOneDocumentBenchmark();
        break;
    }

    return benchmark;
  }
}

abstract class _ReadDocumentBase extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  late final List<BenchmarkDoc> documents;

  BenchmarkDoc get currentDocument =>
      documents[executedOperations % documents.length];

  FutureOr<void> insertDocument(BenchmarkDoc document);

  FutureOr<BenchmarkDoc> loadDocument(String id);

  @override
  Future<void> setup() async {
    await super.setup();

    documents = createDocuments(100);

    // Insert documents.
    for (final document in documents) {
      await insertDocument(document);
    }

    // Verify that document can be persisted and loaded correctly.
    for (final document in documents) {
      final loadedDocument = await loadDocument(document.id);

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

class _SyncReadOneDocumentBenchmark extends _ReadDocumentBase {
  @override
  void insertDocument(BenchmarkDoc document) {
    final database = this.database as InsertOneDocumentSync;
    database.insertOneDocumentSync(document);
  }

  @override
  BenchmarkDoc loadDocument(String id) {
    final database = this.database as LoadDocumentSync;
    return database.loadDocumentSync(id);
  }

  @override
  void executeOperations() {
    final document = currentDocument;
    final database = this.database as LoadDocumentSync;
    measureOperationsSync(() => database.loadDocumentSync(document.id));
  }
}

class _AsyncReadOneDocumentBenchmark extends _ReadDocumentBase {
  @override
  Future<void> insertDocument(BenchmarkDoc document) async {
    final database = this.database as InsertOneDocumentAsync;
    await database.insertOneDocumentAsync(document);
  }

  @override
  Future<BenchmarkDoc> loadDocument(String id) {
    final database = this.database as LoadDocumentAsync;
    return database.loadDocumentAsync(id);
  }

  @override
  Future<void> executeOperations() async {
    final document = currentDocument;
    final database = this.database as LoadDocumentAsync;
    await measureOperationsAsync(() => database.loadDocumentAsync(document.id));
  }
}

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
      ]);

  @override
  BenchmarkRunner<T> createRunner<T extends BenchmarkDoc>(
    ParameterCombination parameterCombination,
  ) {
    final BenchmarkRunner<T> benchmark;

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

abstract class _ReadDocumentBase<T extends BenchmarkDoc>
    extends BenchmarkRunner<T> with BenchmarkDocumentMixin {
  late final List<BenchmarkDoc> documents;

  BenchmarkDoc get currentDocument =>
      documents[executedOperations % documents.length];

  FutureOr<void> createDocument(BenchmarkDoc document);

  FutureOr<BenchmarkDoc> getDocumentById(String id);

  @override
  Future<void> setup() async {
    await super.setup();

    documents = createBenchmarkDocs(100);

    // Insert documents.
    for (final document in documents) {
      await createDocument(document);
    }

    // Verify that document can be persisted and loaded correctly.
    for (final document in documents) {
      final loadedDocument = await getDocumentById(document.id);

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

class _SyncReadOneDocumentBenchmark<T extends BenchmarkDoc>
    extends _ReadDocumentBase<T> {
  @override
  void createDocument(BenchmarkDoc document) {
    database.createDocumentSync(database.createBenchmarkDocImpl(document));
  }

  @override
  BenchmarkDoc getDocumentById(String id) {
    return database.getDocumentByIdSync(id);
  }

  @override
  void executeOperations() {
    final document = currentDocument;
    measureOperationsSync(() => database.getDocumentByIdSync(document.id));
  }
}

class _AsyncReadOneDocumentBenchmark<T extends BenchmarkDoc>
    extends _ReadDocumentBase<T> {
  @override
  Future<void> createDocument(BenchmarkDoc document) async {
    await database
        .createDocumentAsync(database.createBenchmarkDocImpl(document));
  }

  @override
  Future<BenchmarkDoc> getDocumentById(String id) {
    return database.getDocumentByIdAsync(id);
  }

  @override
  Future<void> executeOperations() async {
    final document = currentDocument;
    await measureOperationsAsync(
      () => database.getDocumentByIdAsync(document.id),
    );
  }
}

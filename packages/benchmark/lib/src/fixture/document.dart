import 'dart:convert';

import 'package:benchmark_document/benchmark_document.dart';

import '../benchmark.dart';

late final Future<String> Function() loadDocumentsJson;

typedef DocumentMap = Map<String, Object?>;

Future<List<DocumentMap>>? _documents;

Future<List<DocumentMap>> loadDocuments() async {
  return _documents ??= Future(() async {
    final docs = jsonDecode(await loadDocumentsJson()) as List<Object?>;
    return docs.cast<DocumentMap>();
  });
}

var _documentNumber = 0;

final _documentNumbers = <Object?, int>{};

String createDocumentId(DocumentMap rawDocument) =>
    '${rawDocument['id']}_${_documentNumbers[rawDocument] = _documentNumber++}';

String getDocumentId(DocumentMap rawDocument) =>
    '${rawDocument['id']}_${_documentNumbers[rawDocument]!}';

mixin BenchmarkDocumentMixin<T extends BenchmarkDoc> on BenchmarkRunner<T> {
  late final List<DocumentMap> rawDocuments;

  @override
  Future<void> setup() async {
    rawDocuments = await loadDocuments();
    return super.setup();
  }

  BenchmarkDocData createBenchmarkDoc() => _createBenchmarkDoc();

  List<BenchmarkDocData> createBenchmarkDocs(int count) =>
      List.generate(count, _createBenchmarkDoc);

  BenchmarkDocData _createBenchmarkDoc([int index = 0]) {
    final rawDocument =
        rawDocuments[(executedOperations + index) % rawDocuments.length];
    return BenchmarkDocData.fromJson(
      rawDocument,
      id: createDocumentId(rawDocument),
    );
  }
}

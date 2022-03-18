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

var _nextDocumentNumber = 0;

final _documentNumbers = Expando<int>();

ID createDocumentId<ID extends Object>(DocumentMap rawDocument) {
  _documentNumbers[rawDocument] = _nextDocumentNumber++;
  return _getDocumentId(rawDocument);
}

ID _getDocumentId<ID>(DocumentMap rawDocument) {
  final documentNumber = _documentNumbers[rawDocument]!;
  if (ID == String) {
    return documentNumber.toString() as ID;
  } else /*if(ID == int)*/ {
    return documentNumber as ID;
  }
}

mixin BenchmarkDocumentMixin<ID extends Object, T extends BenchmarkDoc<ID>>
    on BenchmarkRunner<ID, T> {
  late final List<DocumentMap> rawDocuments;

  @override
  Future<void> setup() async {
    rawDocuments = await loadDocuments();
    return super.setup();
  }

  BenchmarkDocData<ID> createBenchmarkDoc() => _createBenchmarkDoc();

  List<BenchmarkDocData<ID>> createBenchmarkDocs(int count) =>
      List.generate(count, _createBenchmarkDoc);

  BenchmarkDocData<ID> _createBenchmarkDoc([int index = 0]) {
    final rawDocument =
        rawDocuments[(executedOperations + index) % rawDocuments.length];
    return BenchmarkDocData.fromJson(
      rawDocument,
      id: createDocumentId(rawDocument),
    );
  }

  T createBenchmarkDocImp() =>
      database.createBenchmarkDocImpl(createBenchmarkDoc());

  List<T> createBenchmarkDocsImp(int count) => createBenchmarkDocs(count)
      .map(database.createBenchmarkDocImpl)
      .toList(growable: false);
}

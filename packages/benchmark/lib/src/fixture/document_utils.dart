import 'dart:convert';

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

String createDocumentId(DocumentMap document) =>
    '${document['id']}_${_documentNumbers[document] = _documentNumber++}';

String getDocumentId(DocumentMap document) =>
    '${document['id']}_${_documentNumbers[document]!}';

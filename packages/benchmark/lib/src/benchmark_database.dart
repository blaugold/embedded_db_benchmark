import 'dart:async';

import 'fixture/document.dart';

abstract class BenchmarkDatabase {
  FutureOr<void> close() {}
}

abstract class InsertOneDocumentSync {
  void insertOneDocumentSync(BenchmarkDoc doc);
}

abstract class InsertOneDocumentAsync {
  Future<void> insertOneDocumentAsync(BenchmarkDoc doc);
}

abstract class InsertManyDocumentsSync {
  void insertManyDocumentsSync(List<BenchmarkDoc> docs);
}

abstract class InsertManyDocumentsAsync {
  Future<void> insertManyDocumentsAsync(List<BenchmarkDoc> docs);
}

abstract class LoadDocumentSync {
  BenchmarkDoc loadDocumentSync(String id);
}

abstract class LoadDocumentAsync {
  Future<BenchmarkDoc> loadDocumentAsync(String id);
}

import 'dart:async';

import 'fixture/document.dart';

abstract class BenchmarkDatabase {
  FutureOr<void> close() {}

  void createDocumentSync(BenchmarkDoc doc) {
    createDocumentsSync([doc]);
  }

  void createDocumentsSync(List<BenchmarkDoc> docs) {
    throw UnimplementedError();
  }

  Future<void> createDocumentAsync(BenchmarkDoc doc) {
    return createDocumentsAsync([doc]);
  }

  Future<void> createDocumentsAsync(List<BenchmarkDoc> docs) {
    throw UnimplementedError();
  }

  BenchmarkDoc getDocumentByIdSync(String id) {
    throw UnimplementedError();
  }

  Future<BenchmarkDoc> getDocumentByIdAsync(String id) {
    throw UnimplementedError();
  }
}

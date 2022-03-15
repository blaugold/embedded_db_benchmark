import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';

abstract class BenchmarkDatabase<T extends BenchmarkDoc> {
  T createBenchmarkDocImpl(BenchmarkDoc doc);

  FutureOr<void> close() {}

  FutureOr<void> clear();

  T createDocumentSync(T doc) {
    return createDocumentsSync([doc]).single;
  }

  List<T> createDocumentsSync(List<T> docs) {
    throw UnimplementedError();
  }

  Future<T> createDocumentAsync(T doc) {
    return createDocumentsAsync([doc]).then((docs) => docs.single);
  }

  Future<List<T>> createDocumentsAsync(List<T> docs) {
    throw UnimplementedError();
  }

  T getDocumentByIdSync(String id) {
    throw UnimplementedError();
  }

  Future<T> getDocumentByIdAsync(String id) {
    throw UnimplementedError();
  }
}

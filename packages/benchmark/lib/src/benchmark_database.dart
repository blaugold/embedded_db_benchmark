import 'dart:async';

import 'benchmark_document.dart';

abstract class BenchmarkDatabase<ID extends Object,
    T extends BenchmarkDoc<ID>> {
  T createBenchmarkDocImpl(BenchmarkDoc<ID> doc);

  FutureOr<void> close() {}

  FutureOr<void> clear();

  FutureOr<T> createDocument(T doc);

  FutureOr<List<T>> createDocuments(List<T> docs);

  FutureOr<T> getDocumentById(ID id);

  FutureOr<List<T>> getDocumentsById(List<ID> ids);

  FutureOr<List<T>> getAllDocuments();

  FutureOr<T> updateDocument(T doc);

  FutureOr<List<T>> updateDocuments(List<T> docs);

  FutureOr<void> deleteDocument(T doc);

  FutureOr<void> deleteDocuments(List<T> docs);
}

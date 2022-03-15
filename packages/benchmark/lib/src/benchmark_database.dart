import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';

abstract class BenchmarkDatabase<ID extends Object,
    T extends BenchmarkDoc<ID>> {
  T createBenchmarkDocImpl(BenchmarkDoc<ID> doc);

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

  Future<List<T>> createDocumentsAsync(List<T> docs) async {
    return createDocumentsSync(docs);
  }

  T getDocumentByIdSync(ID id) {
    throw UnimplementedError();
  }

  Future<T> getDocumentByIdAsync(ID id) async {
    return getDocumentByIdSync(id);
  }

  List<T> getDocumentsByIdSync(List<ID> ids) {
    return ids.map(getDocumentByIdSync).toList();
  }

  Future<List<T>> getDocumentsByIdAsync(List<ID> ids) async {
    return Future.wait(ids.map(getDocumentByIdAsync));
  }

  void deleteDocumentSync(T doc) {
    deleteDocumentsSync([doc]);
  }

  Future<void> deleteDocumentAsync(T doc) async {
    deleteDocumentSync(doc);
  }

  void deleteDocumentsSync(List<T> docs) {
    throw UnimplementedError();
  }

  Future<void> deleteDocumentsAsync(List<T> docs) async {
    deleteDocumentsSync(docs);
  }
}

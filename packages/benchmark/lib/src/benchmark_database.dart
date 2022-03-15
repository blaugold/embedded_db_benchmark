import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';

import 'benchmark_parameter.dart';

abstract class BenchmarkDatabase<ID extends Object,
    T extends BenchmarkDoc<ID>> {
  T createBenchmarkDocImpl(BenchmarkDoc<ID> doc);

  FutureOr<void> close() {}

  FutureOr<void> clear();

  // === Create Document =======================================================

  T createDocumentSync(T doc) {
    return createDocumentsSync([doc]).single;
  }

  Future<T> createDocumentAsync(T doc) async {
    return createDocumentsAsync([doc]).then((docs) => docs.single);
  }

  FutureOr<T> createDocument(T doc, Execution execution) {
    switch (execution) {
      case Execution.sync:
        return createDocumentSync(doc);
      case Execution.async:
        return createDocumentAsync(doc);
    }
  }

  List<T> createDocumentsSync(List<T> docs) {
    return [for (final doc in docs) createDocumentSync(doc)];
  }

  Future<List<T>> createDocumentsAsync(List<T> docs) async {
    return Future.wait(docs.map(createDocumentAsync));
  }

  FutureOr<List<T>> createDocuments(List<T> docs, Execution execution) {
    switch (execution) {
      case Execution.sync:
        return createDocumentsSync(docs);
      case Execution.async:
        return createDocumentsAsync(docs);
    }
  }

  // === Get Document By Id ====================================================

  T getDocumentByIdSync(ID id) {
    return getDocumentsByIdSync([id]).single;
  }

  Future<T> getDocumentByIdAsync(ID id) async {
    return getDocumentsByIdAsync([id]).then((docs) => docs.single);
  }

  FutureOr<T> getDocumentById(ID id, Execution execution) {
    switch (execution) {
      case Execution.sync:
        return getDocumentByIdSync(id);
      case Execution.async:
        return getDocumentByIdAsync(id);
    }
  }

  List<T> getDocumentsByIdSync(List<ID> ids) {
    return [for (final id in ids) getDocumentByIdSync(id)];
  }

  Future<List<T>> getDocumentsByIdAsync(List<ID> ids) async {
    return Future.wait(ids.map(getDocumentByIdAsync));
  }

  FutureOr<List<T>> getDocumentsById(List<ID> ids, Execution execution) {
    switch (execution) {
      case Execution.sync:
        return getDocumentsByIdSync(ids);
      case Execution.async:
        return getDocumentsByIdAsync(ids);
    }
  }

  // === Delete Document =======================================================

  void deleteDocumentSync(T doc) {
    deleteDocumentsSync([doc]);
  }

  Future<void> deleteDocumentAsync(T doc) async {
    await deleteDocumentsAsync([doc]);
  }

  FutureOr<void> deleteDocument(T doc, Execution execution) {
    switch (execution) {
      case Execution.sync:
        deleteDocumentSync(doc);
        break;
      case Execution.async:
        return deleteDocumentAsync(doc);
    }
  }

  void deleteDocumentsSync(List<T> docs) {
    for (final doc in docs) {
      deleteDocumentSync(doc);
    }
  }

  Future<void> deleteDocumentsAsync(List<T> docs) async {
    await Future.wait(docs.map(deleteDocumentAsync));
  }

  FutureOr<void> deleteDocuments(List<T> docs, Execution execution) {
    switch (execution) {
      case Execution.sync:
        deleteDocumentsSync(docs);
        break;
      case Execution.async:
        return deleteDocumentsAsync(docs);
    }
  }
}

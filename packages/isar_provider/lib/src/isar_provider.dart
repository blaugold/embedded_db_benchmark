import 'dart:async';

import 'package:benchmark/benchmark.dart';
import 'package:isar/isar.dart';

import 'constants.dart';
import 'isar_document.dart';

const bool _isWeb = identical(0, 0.0);

class IsarProvider extends DatabaseProvider<int, IsarDoc> {
  @override
  String get name => databaseName;

  @override
  bool get supportsCurrentPlatform => true;

  @override
  bool supportsParameterArguments(ParameterArguments arguments) =>
      andPredicates([
        anyArgumentOf(execution, [
          if (!_isWeb) Execution.sync,
          Execution.async,
        ]),
        anyArgument(batchSize),
      ])(arguments);

  @override
  FutureOr<BenchmarkDatabase<int, IsarDoc>> openDatabase(
    String directory,
    ParameterArguments arguments,
  ) async {
    final isar = await Isar.open(
      name: 'isar_benchmark',
      directory: directory,
      relaxedDurability: false,
      [
        IsarDocSchema,
      ],
    );

    switch (arguments.get(execution)!) {
      case Execution.sync:
        return _SyncIsarDatabase(isar);
      case Execution.async:
        return _AsyncIsarDatabase(isar);
    }
  }
}

class _SyncIsarDatabase extends BenchmarkDatabase<int, IsarDoc> {
  _SyncIsarDatabase(this.isar);

  final Isar isar;

  @override
  IsarDoc createBenchmarkDocImpl(BenchmarkDoc<int> doc) => doc.toIsarDoc();

  @override
  FutureOr<void> close() => isar.close();

  @override
  Future<void> clear() => isar.writeTxn(() => isar.clear());

  @override
  IsarDoc createDocument(IsarDoc doc) => isar.writeTxnSync(() {
        isar.isarDocs.putSync(doc);
        return doc;
      });

  @override
  List<IsarDoc> createDocuments(List<IsarDoc> docs) =>
      isar.writeTxnSync(() => docs.map((doc) {
            isar.isarDocs.putSync(doc);
            return doc;
          }).toList());

  @override
  IsarDoc getDocumentById(int id) {
    return getDocumentsById([id]).single;
  }

  @override
  List<IsarDoc> getDocumentsById(List<int> ids) =>
      // For some reason a write transaction is necessary here.
      isar.writeTxnSync(() => isar.isarDocs.getAllSync(ids).cast<IsarDoc>());

  @override
  List<IsarDoc> getAllDocuments() =>
      isar.isarDocs.where().build().findAllSync();

  @override
  IsarDoc updateDocument(IsarDoc doc) => isar.writeTxnSync(() {
        isar.isarDocs.putSync(doc);
        return doc;
      });

  @override
  List<IsarDoc> updateDocuments(List<IsarDoc> docs) =>
      isar.writeTxnSync(() => docs.map((doc) {
            isar.isarDocs.putSync(doc);
            return doc;
          }).toList());

  @override
  void deleteDocument(IsarDoc doc) {
    deleteDocuments([doc]);
  }

  @override
  void deleteDocuments(List<IsarDoc> docs) {
    isar.writeTxnSync(() {
      isar.isarDocs.deleteAllSync(docs.map((doc) => doc.id).toList());
    });
  }
}

class _AsyncIsarDatabase extends BenchmarkDatabase<int, IsarDoc> {
  _AsyncIsarDatabase(this.isar);

  final Isar isar;

  @override
  IsarDoc createBenchmarkDocImpl(BenchmarkDoc<int> doc) => doc.toIsarDoc();

  @override
  FutureOr<void> close() => isar.close(deleteFromDisk: _isWeb);

  @override
  Future<void> clear() => isar.writeTxn(() => isar.clear());

  @override
  Future<IsarDoc> createDocument(IsarDoc doc) => isar.writeTxn(() async {
        await isar.isarDocs.put(doc);
        return doc;
      });

  @override
  Future<List<IsarDoc>> createDocuments(List<IsarDoc> docs) =>
      isar.writeTxn(() => Future.wait(docs.map((doc) async {
            await isar.isarDocs.put(doc);
            return doc;
          })));

  @override
  Future<IsarDoc> getDocumentById(int id) {
    return getDocumentsById([id]).then((docs) => docs.single);
  }

  @override
  Future<List<IsarDoc>> getDocumentsById(List<int> ids) => isar.txn(() async {
        return isar.isarDocs.getAll(ids).then((docs) => docs.cast<IsarDoc>());
      });

  @override
  Future<List<IsarDoc>> getAllDocuments() =>
      isar.isarDocs.where().build().findAll();

  @override
  Future<IsarDoc> updateDocument(IsarDoc doc) => isar.writeTxn(() async {
        await isar.isarDocs.put(doc);
        return doc;
      });

  @override
  Future<List<IsarDoc>> updateDocuments(List<IsarDoc> docs) =>
      isar.writeTxn(() => Future.wait(docs.map((doc) async {
            await isar.isarDocs.put(doc);
            return doc;
          })));

  @override
  Future<void> deleteDocument(IsarDoc doc) {
    return deleteDocuments([doc]);
  }

  @override
  Future<void> deleteDocuments(List<IsarDoc> docs) => isar.writeTxn(() async {
        await isar.isarDocs.deleteAll(docs.map((doc) => doc.id).toList());
      });
}

extension on BenchmarkDoc<int> {
  IsarDoc toIsarDoc() {
    return IsarDoc()
      ..index = index
      ..guid = guid
      ..isActive = isActive
      ..balance = balance
      ..picture = picture
      ..age = age
      ..eyeColor = eyeColor
      ..name = name.toIsarName()
      ..company = company
      ..email = email
      ..phone = phone
      ..address = address
      ..about = about
      ..registered = registered
      ..latitude = latitude
      ..longitude = longitude
      ..tags = tags
      ..range = range
      ..friends = friends.map((friend) => friend.toIsarFriend()).toList()
      ..greeting = greeting
      ..favoriteFruit = favoriteFruit;
  }
}

extension on BenchmarkName {
  IsarName toIsarName() => IsarName()
    ..first = first
    ..last = last;
}

extension on BenchmarkFriend {
  IsarFriend toIsarFriend() => IsarFriend()
    ..id = id
    ..name = name;
}

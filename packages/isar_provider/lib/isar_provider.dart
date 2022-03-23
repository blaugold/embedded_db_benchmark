import 'dart:async';

import 'package:benchmark/benchmark.dart';
import 'package:isar/isar.dart';

import 'src/isar_document.dart';

class IsarProvider extends DatabaseProvider<int, IsarDoc> {
  @override
  String get name => 'Isar';

  @override
  bool supportsParameterArguments(ParameterArguments arguments) =>
      andPredicates([
        anyArgument(execution),
        anyArgument(batchSize),
      ])(arguments);

  @override
  FutureOr<BenchmarkDatabase<int, IsarDoc>> openDatabase(
    String directory,
    ParameterArguments arguments,
  ) async {
    final isar = await Isar.open(
      schemas: [
        IsarDocSchema,
        IsarNameSchema,
        IsarFriendSchema,
      ],
      directory: directory,
      relaxedDurability: false,
    );
    return _IsarDatabase(isar);
  }
}

class _IsarDatabase extends BenchmarkDatabase<int, IsarDoc> {
  _IsarDatabase(this.isar);

  final Isar isar;

  @override
  IsarDoc createBenchmarkDocImpl(BenchmarkDoc<int> doc) => doc.toIsarDoc();

  @override
  FutureOr<void> close() => isar.close();

  @override
  Future<void> clear() => isar.writeTxn((isar) => isar.clear());

  @override
  IsarDoc createDocumentSync(IsarDoc doc) => isar.writeTxnSync((isar) {
        isar.isarNames.putSync(doc.isarName.value!);
        isar.isarFriends.putAllSync(doc.friends.toList());
        isar.isarDocs.putSync(doc);
        doc.isarName.saveSync();
        doc.isarFriends.saveSync();
        return doc;
      });

  @override
  Future<IsarDoc> createDocumentAsync(IsarDoc doc) =>
      isar.writeTxn((isar) async {
        await Future.wait([
          isar.isarNames.put(doc.isarName.value!),
          isar.isarFriends.putAll(doc.friends.toList()),
        ]);
        await isar.isarDocs.put(doc);
        await Future.wait([
          doc.isarName.save(),
          doc.isarFriends.save(),
        ]);
        return doc;
      });

  @override
  List<IsarDoc> createDocumentsSync(List<IsarDoc> docs) =>
      isar.writeTxnSync((isar) => docs.map((doc) {
            isar.isarNames.putSync(doc.isarName.value!);
            isar.isarFriends.putAllSync(doc.friends.toList());
            isar.isarDocs.putSync(doc);
            doc.isarName.saveSync();
            doc.isarFriends.saveSync();
            return doc;
          }).toList());

  @override
  Future<List<IsarDoc>> createDocumentsAsync(List<IsarDoc> docs) =>
      isar.writeTxn((isar) => Future.wait(docs.map((doc) async {
            await Future.wait([
              isar.isarNames.put(doc.isarName.value!),
              isar.isarFriends.putAll(doc.friends.toList()),
            ]);
            await isar.isarDocs.put(doc);
            await Future.wait([
              doc.isarName.save(),
              doc.isarFriends.save(),
            ]);
            return doc;
          })));

  @override
  IsarDoc getDocumentByIdSync(int id) {
    return getDocumentsByIdSync([id]).single;
  }

  @override
  List<IsarDoc> getDocumentsByIdSync(List<int> ids) =>
      // For some reason a write transaction is necessary here.
      isar.writeTxnSync((isar) {
        final docs = isar.isarDocs.getAllSync(ids).cast<IsarDoc>();
        for (final doc in docs) {
          doc.isarName.loadSync();
          doc.isarFriends.loadSync();
        }
        return docs;
      });

  @override
  Future<IsarDoc> getDocumentByIdAsync(int id) {
    return getDocumentsByIdAsync([id]).then((docs) => docs.single);
  }

  @override
  Future<List<IsarDoc>> getDocumentsByIdAsync(List<int> ids) =>
      // For some reason a write transaction is necessary here.
      isar.writeTxn((isar) async {
        final docs = await isar.isarDocs
            .getAll(ids)
            .then((docs) => docs.cast<IsarDoc>());

        await Future.wait(docs.map(
          (doc) => Future.wait([doc.isarName.load(), doc.isarFriends.load()]),
        ));

        return docs;
      });

  @override
  List<IsarDoc> getAllDocumentsSync() =>
      isar.isarDocs.where().build().findAllSync();

  @override
  Future<List<IsarDoc>> getAllDocumentsAsync() =>
      isar.isarDocs.where().build().findAll();

  @override
  IsarDoc updateDocumentSync(IsarDoc doc) => isar.writeTxnSync((isar) {
        isar.isarNames.putSync(doc.isarName.value!);
        isar.isarFriends.putAllSync(doc.friends.toList());
        isar.isarDocs.putSync(doc);
        return doc;
      });

  @override
  Future<IsarDoc> updateDocumentAsync(IsarDoc doc) =>
      isar.writeTxn((isar) async {
        await Future.wait([
          isar.isarNames.put(doc.isarName.value!),
          isar.isarFriends.putAll(doc.friends.toList()),
          isar.isarDocs.put(doc)
        ]);
        return doc;
      });

  @override
  List<IsarDoc> updateDocumentsSync(List<IsarDoc> docs) =>
      isar.writeTxnSync((isar) => docs.map((doc) {
            isar.isarNames.putSync(doc.isarName.value!);
            isar.isarFriends.putAllSync(doc.friends.toList());
            isar.isarDocs.putSync(doc);
            return doc;
          }).toList());

  @override
  Future<List<IsarDoc>> updateDocumentsAsync(List<IsarDoc> docs) =>
      isar.writeTxn((isar) => Future.wait(docs.map((doc) async {
            await Future.wait([
              isar.isarNames.put(doc.isarName.value!),
              isar.isarFriends.putAll(doc.friends.toList()),
              isar.isarDocs.put(doc)
            ]);
            return doc;
          })));

  @override
  void deleteDocumentSync(IsarDoc doc) {
    deleteDocumentsSync([doc]);
  }

  @override
  Future<void> deleteDocumentAsync(IsarDoc doc) {
    return deleteDocumentsAsync([doc]);
  }

  @override
  void deleteDocumentsSync(List<IsarDoc> docs) {
    isar.writeTxnSync((isar) {
      isar.isarDocs.deleteAllSync([
        for (final doc in docs) ...[
          doc.id,
          doc.name.dbId,
          ...doc.friends.map((friend) => friend.dbId)
        ]
      ]);
    });
  }

  @override
  Future<void> deleteDocumentsAsync(List<IsarDoc> docs) =>
      isar.writeTxn((isar) async {
        await isar.isarDocs.deleteAll([
          for (final doc in docs) ...[
            doc.id,
            doc.name.dbId,
            ...doc.friends.map((friend) => friend.dbId)
          ]
        ]);
      });
}

extension on BenchmarkDoc<int> {
  IsarDoc toIsarDoc() => IsarDoc()
    ..index = index
    ..guid = guid
    ..isActive = isActive
    ..balance = balance
    ..picture = picture
    ..age = age
    ..eyeColor = eyeColor
    ..isarName.value = name.toIsarName()
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
    ..isarFriends
        .addAll(friends.map((friend) => friend.toIsarFriend()).toList())
    ..greeting = greeting
    ..favoriteFruit = favoriteFruit;
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

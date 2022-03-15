import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';
import 'package:isar/isar.dart';
import 'package:isar_document/isar_document.dart';

import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../parameter.dart';
import 'database_provider.dart';

class IsarProvider extends DatabaseProvider<IsarDoc> {
  @override
  String get name => 'Isar';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.all(execution),
        ParameterRange.all(batchSize),
      ]);

  @override
  FutureOr<BenchmarkDatabase<IsarDoc>> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
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

class _IsarDatabase extends BenchmarkDatabase<IsarDoc> {
  _IsarDatabase(this.isar);

  final Isar isar;

  @override
  IsarDoc createBenchmarkDocImpl(BenchmarkDoc doc) => doc.toIsarDoc();

  @override
  FutureOr<void> close() => isar.close();

  @override
  void clear() => isar.writeTxn((isar) => isar.clear());

  @override
  IsarDoc createDocumentSync(IsarDoc doc) => isar.writeTxnSync((isar) {
        final isarDoc = doc.toIsarDoc();
        isar.isarNames.putSync(isarDoc.isarName.value!);
        isar.isarFriends.putAllSync(isarDoc.friends.toList());
        isar.isarDocs.putSync(isarDoc);
        isarDoc.isarName.saveSync();
        isarDoc.isarFriends.saveSync();
        return isarDoc;
      });

  @override
  Future<IsarDoc> createDocumentAsync(IsarDoc doc) =>
      isar.writeTxn((isar) async {
        final isarDoc = doc.toIsarDoc();
        await isar.isarNames.put(isarDoc.isarName.value!);
        await isar.isarFriends.putAll(isarDoc.friends.toList());
        await isar.isarDocs.put(isarDoc);
        await isarDoc.isarName.save();
        await isarDoc.isarFriends.save();
        return isarDoc;
      });

  @override
  List<IsarDoc> createDocumentsSync(List<IsarDoc> docs) =>
      isar.writeTxnSync((isar) => docs.map((doc) {
            final isarDoc = doc.toIsarDoc();
            isar.isarNames.putSync(isarDoc.isarName.value!);
            isar.isarFriends.putAllSync(isarDoc.friends.toList());
            isar.isarDocs.putSync(isarDoc);
            isarDoc.isarName.saveSync();
            isarDoc.isarFriends.saveSync();
            return isarDoc;
          }).toList());

  @override
  Future<List<IsarDoc>> createDocumentsAsync(List<IsarDoc> docs) =>
      isar.writeTxn((isar) => Future.wait(docs.map((doc) async {
            final isarDoc = doc.toIsarDoc();
            await isar.isarNames.put(isarDoc.isarName.value!);
            await isar.isarFriends.putAll(isarDoc.friends.toList());
            await isar.isarDocs.put(isarDoc);
            await isarDoc.isarName.save();
            await isarDoc.isarFriends.save();
            return isarDoc;
          })));

  @override
  IsarDoc getDocumentByIdSync(String id) =>
      // For some reason a write transaction is necessary here.
      isar.writeTxnSync((isar) {
        final doc = isar.isarDocs.where().idEqualTo(id).findFirstSync();
        doc!.isarName.loadSync();
        doc.isarFriends.loadSync();
        return doc;
      });

  @override
  Future<IsarDoc> getDocumentByIdAsync(String id) =>
      // For some reason a write transaction is necessary here.
      isar.writeTxn((isar) async {
        final doc = await isar.isarDocs.where().idEqualTo(id).findFirst();
        await doc!.isarName.load();
        await doc.isarFriends.load();
        return doc;
      });
}

extension on BenchmarkDoc {
  IsarDoc toIsarDoc() => IsarDoc()
    ..id = id
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

import 'dart:async';

import 'package:isar/isar.dart';
import 'package:isar_document/isar_document.dart';

import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';
import 'database_provider.dart';

class IsarProvider extends DatabaseProvider {
  @override
  String get name => 'Isar';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.all(execution),
        ParameterRange.single(dataModel, DataModel.static),
        ParameterRange.all(batchSize),
      ]);

  @override
  FutureOr<BenchmarkDatabase> openDatabase(
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

class _IsarDatabase extends BenchmarkDatabase {
  _IsarDatabase(this.isar);

  final Isar isar;

  @override
  FutureOr<void> close() => isar.close();

  @override
  void createDocumentSync(BenchmarkDoc doc) => isar.writeTxnSync((isar) {
        final isarDoc = doc.toIsarDoc();
        isar.isarNames.putSync(isarDoc.name.value!);
        isar.isarFriends.putAllSync(isarDoc.friends.toList());
        isar.isarDocs.putSync(isarDoc);
        isarDoc.name.saveSync();
        isarDoc.friends.saveSync();
      });

  @override
  Future<void> createDocumentAsync(BenchmarkDoc doc) =>
      isar.writeTxn((isar) async {
        final isarDoc = doc.toIsarDoc();
        await isar.isarNames.put(isarDoc.name.value!);
        await isar.isarFriends.putAll(isarDoc.friends.toList());
        await isar.isarDocs.put(isarDoc);
        await isarDoc.name.save();
        await isarDoc.friends.save();
      });

  @override
  void createDocumentsSync(List<BenchmarkDoc> docs) =>
      isar.writeTxnSync((isar) {
        for (final doc in docs) {
          final isarDoc = doc.toIsarDoc();
          isar.isarNames.putSync(isarDoc.name.value!);
          isar.isarFriends.putAllSync(isarDoc.friends.toList());
          isar.isarDocs.putSync(isarDoc);
          isarDoc.name.saveSync();
          isarDoc.friends.saveSync();
        }
      });

  @override
  Future<void> createDocumentsAsync(List<BenchmarkDoc> docs) =>
      isar.writeTxn((isar) async {
        for (final doc in docs) {
          final isarDoc = doc.toIsarDoc();
          await isar.isarNames.put(isarDoc.name.value!);
          await isar.isarFriends.putAll(isarDoc.friends.toList());
          await isar.isarDocs.put(isarDoc);
          await isarDoc.name.save();
          await isarDoc.friends.save();
        }
      });

  @override
  BenchmarkDoc getDocumentByIdSync(String id) =>
      // For some reason a write transaction is necessary here.
      isar.writeTxnSync((isar) {
        final doc = isar.isarDocs.where().idEqualTo(id).findFirstSync();
        doc!.name.loadSync();
        doc.friends.loadSync();
        return doc.toBenchmarkDoc();
      });

  @override
  Future<BenchmarkDoc> getDocumentByIdAsync(String id) =>
      // For some reason a write transaction is necessary here.
      isar.writeTxn((isar) async {
        final doc = await isar.isarDocs.where().idEqualTo(id).findFirst();
        await doc!.name.load();
        await doc.friends.load();
        return doc.toBenchmarkDoc();
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
    ..name.value = name.toIsarName()
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
    ..friends.addAll(friends.map((friend) => friend.toIsarFriend()).toList())
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

extension on IsarDoc {
  BenchmarkDoc toBenchmarkDoc() => BenchmarkDoc(
        id: id,
        index: index,
        guid: guid,
        isActive: isActive,
        balance: balance,
        picture: picture,
        age: age,
        eyeColor: eyeColor,
        name: BenchmarkName(first: name.value!.first, last: name.value!.last),
        company: company,
        email: email,
        phone: phone,
        address: address,
        about: about,
        registered: registered,
        latitude: latitude,
        longitude: longitude,
        tags: tags,
        range: range,
        friends: friends
            .map((friend) => BenchmarkFriend(id: friend.id, name: friend.name))
            .toList()
          ..sort((a, b) => a.id - b.id),
        greeting: greeting,
        favoriteFruit: favoriteFruit,
      );
}

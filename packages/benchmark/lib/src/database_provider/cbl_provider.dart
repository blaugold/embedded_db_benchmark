import 'dart:async';

import 'package:cbl/cbl.dart' hide DatabaseConfiguration;
import 'package:cbl/cbl.dart' as cbl;

import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';
import 'database_provider.dart';

class CblProvider extends DatabaseProvider {
  @override
  String get name => 'Couchbase Lite';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.all(execution),
        ParameterRange.single(dataModel, DataModel.dynamic),
        ParameterRange.all(batchSize),
      ]);

  @override
  FutureOr<BenchmarkDatabase> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  ) async {
    late final cblConfig = cbl.DatabaseConfiguration(directory: directory);

    switch (parameterCombination.get(execution)!) {
      case Execution.sync:
        return _SyncCblDatabase(Database.openSync('db', cblConfig));
      case Execution.async:
        return _AsyncCblDatabase(await Database.openAsync('db', cblConfig));
    }
  }
}

class _SyncCblDatabase extends BenchmarkDatabase {
  _SyncCblDatabase(this.database);

  final SyncDatabase database;

  @override
  void createDocumentSync(BenchmarkDoc doc) {
    database.saveDocument(doc.toMutableDocument());
  }

  @override
  void createDocumentsSync(List<BenchmarkDoc> docs) {
    database.inBatchSync(() {
      for (final doc in docs) {
        database.saveDocument(doc.toMutableDocument());
      }
    });
  }

  @override
  BenchmarkDoc getDocumentByIdSync(String id) =>
      database.document(id)!.toBenchmarkDoc();

  @override
  FutureOr<void> close() => database.close();
}

class _AsyncCblDatabase extends BenchmarkDatabase {
  _AsyncCblDatabase(this.database);

  final AsyncDatabase database;

  @override
  Future<void> createDocumentAsync(BenchmarkDoc doc) {
    return database.saveDocument(doc.toMutableDocument());
  }

  @override
  Future<void> createDocumentsAsync(List<BenchmarkDoc> docs) =>
      database.inBatch(() async {
        await Future.wait(
          docs.map((doc) => database.saveDocument(doc.toMutableDocument())),
        );
      });

  @override
  Future<BenchmarkDoc> getDocumentByIdAsync(String id) =>
      database.document(id).then((doc) => doc!.toBenchmarkDoc());

  @override
  FutureOr<void> close() => database.close();
}

extension on BenchmarkDoc {
  MutableDocument toMutableDocument() => MutableDocument.withId(id)
    ..setValue(index, key: 'index')
    ..setValue(guid, key: 'guid')
    ..setValue(isActive, key: 'isActive')
    ..setValue(balance, key: 'balance')
    ..setValue(picture, key: 'picture')
    ..setValue(age, key: 'age')
    ..setValue(eyeColor, key: 'eyeColor')
    ..setValue(name.toMutableDictionary(), key: 'name')
    ..setValue(company, key: 'company')
    ..setValue(email, key: 'email')
    ..setValue(phone, key: 'phone')
    ..setValue(address, key: 'address')
    ..setValue(about, key: 'about')
    ..setValue(registered, key: 'registered')
    ..setValue(latitude, key: 'latitude')
    ..setValue(longitude, key: 'longitude')
    ..setValue(tags, key: 'tags')
    ..setValue(range, key: 'range')
    ..setValue(
      friends.map((friend) => friend.toMutableDictionary()),
      key: 'friends',
    )
    ..setValue(greeting, key: 'greeting')
    ..setValue(favoriteFruit, key: 'favoriteFruit');
}

extension on BenchmarkName {
  MutableDictionary toMutableDictionary() => MutableDictionary()
    ..setValue(first, key: 'first')
    ..setValue(last, key: 'last');
}

extension on BenchmarkFriend {
  MutableDictionary toMutableDictionary() => MutableDictionary()
    ..setValue(id, key: 'id')
    ..setValue(name, key: 'name');
}

extension on Document {
  BenchmarkDoc toBenchmarkDoc() => BenchmarkDoc(
        id: id,
        index: value('index')!,
        guid: value('guid')!,
        isActive: value('isActive')!,
        balance: value('balance')!,
        picture: value('picture')!,
        age: value('age')!,
        eyeColor: value('eyeColor')!,
        name: dictionary('name')!.toBenchmarkName(),
        company: value('company')!,
        email: value('email')!,
        phone: value('phone')!,
        address: value('address')!,
        about: value('about')!,
        registered: value('registered')!,
        latitude: value('latitude')!,
        longitude: value('longitude')!,
        tags: array('tags')!.cast<String>().toList(),
        range: array('range')!.cast<int>().toList(),
        friends: array('friends')!
            .cast<Dictionary>()
            .map((dict) => dict.toBenchmarkFriend())
            .toList(),
        greeting: value('greeting')!,
        favoriteFruit: value('favoriteFruit')!,
      );
}

extension on Dictionary {
  BenchmarkName toBenchmarkName() => BenchmarkName(
        first: value('first')!,
        last: value('last')!,
      );

  BenchmarkFriend toBenchmarkFriend() => BenchmarkFriend(
        id: value('id')!,
        name: value('name')!,
      );
}

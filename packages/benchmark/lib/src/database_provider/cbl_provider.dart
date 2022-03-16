import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';
import 'package:cbl/cbl.dart' hide DatabaseConfiguration;
import 'package:cbl/cbl.dart' as cbl;
import 'package:path/path.dart' as p;

import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../parameter.dart';
import 'database_provider.dart';

class CblProvider extends DatabaseProvider<String, CblDoc> {
  CblProvider({this.fileLogging = false});

  final bool fileLogging;

  @override
  String get name => 'Couchbase Lite';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.all(execution),
        ParameterRange.all(batchSize),
      ]);

  @override
  FutureOr<BenchmarkDatabase<String, CblDoc>> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  ) async {
    if (fileLogging) {
      final logFileConfig = LogFileConfiguration(
        directory: p.join(directory, 'logs'),
        usePlainText: false,
      );
      Database.log.file.config = logFileConfig;
      Database.log.file.level = LogLevel.verbose;
    }

    late final cblConfig = cbl.DatabaseConfiguration(directory: directory);

    switch (parameterCombination.get(execution)!) {
      case Execution.sync:
        return _SyncCblDatabase(Database.openSync('db', cblConfig));
      case Execution.async:
        return _AsyncCblDatabase(await Database.openAsync('db', cblConfig));
    }
  }
}

mixin _CblDatabaseHelper on BenchmarkDatabase<String, CblDoc> {
  Database get database;

  FutureOr<List<String>> allDocIds();

  @override
  Future<void> clear() async {
    final allDocIds = await this.allDocIds();
    if (allDocIds.isEmpty) {
      return;
    }

    await database.inBatch(() async {
      await Future.wait(
        allDocIds.map((id) async => database.purgeDocumentById(id)),
      );
    });
  }
}

class _SyncCblDatabase extends BenchmarkDatabase<String, CblDoc>
    with _CblDatabaseHelper {
  _SyncCblDatabase(this.database);

  @override
  final SyncDatabase database;

  late final _allIdsQuery =
      Query.fromN1qlSync(database, 'SELECT Meta().id FROM _');

  @override
  List<String> allDocIds() {
    if (database.count == 0) {
      return [];
    }

    return _allIdsQuery.execute().map((result) => result.string(0)!).toList();
  }

  @override
  CblDoc createBenchmarkDocImpl(BenchmarkDoc<String> doc) => doc.toCblDoc();

  @override
  FutureOr<void> close() => database.close();

  @override
  CblDoc createDocumentSync(CblDoc doc) {
    database.saveDocument(doc.mutableDoc);
    return doc;
  }

  @override
  List<CblDoc> createDocumentsSync(List<CblDoc> docs) {
    database.inBatchSync(() {
      for (final doc in docs) {
        database.saveDocument(doc.mutableDoc);
      }
    });
    return docs;
  }

  @override
  CblDoc getDocumentByIdSync(String id) =>
      CblDoc.fromDoc(database.document(id)!);

  @override
  List<CblDoc> getAllDocumentsSync() =>
      [for (final id in allDocIds()) getDocumentByIdSync(id)];

  @override
  void deleteDocumentSync(CblDoc doc) {
    database.deleteDocument(doc.doc);
  }

  @override
  void deleteDocumentsSync(List<CblDoc> docs) {
    database.inBatchSync(() {
      for (final doc in docs) {
        database.deleteDocument(doc.doc);
      }
    });
  }
}

class _AsyncCblDatabase extends BenchmarkDatabase<String, CblDoc>
    with _CblDatabaseHelper {
  _AsyncCblDatabase(this.database);

  @override
  final AsyncDatabase database;

  late final allIdsQuery =
      Future.value(Query.fromN1ql(database, 'SELECT Meta().id FROM _'));

  @override
  Future<List<String>> allDocIds() async {
    if ((await database.count) == 0) {
      return [];
    }

    final resultSet = await (await allIdsQuery).execute();
    return resultSet.asStream().map((result) => result.string(0)!).toList();
  }

  @override
  FutureOr<void> close() => database.close();

  @override
  CblDoc createBenchmarkDocImpl(BenchmarkDoc<String> doc) => doc.toCblDoc();

  @override
  Future<CblDoc> createDocumentAsync(CblDoc doc) async {
    await database.saveDocument(doc.mutableDoc);
    return doc;
  }

  @override
  Future<List<CblDoc>> createDocumentsAsync(List<CblDoc> docs) async {
    await database.inBatch(() async {
      await Future.wait(
        docs.map((doc) => database.saveDocument(doc.mutableDoc)),
      );
    });
    return docs;
  }

  @override
  Future<CblDoc> getDocumentByIdAsync(String id) async =>
      CblDoc.fromDoc((await database.document(id))!.toMutable());

  @override
  Future<List<CblDoc>> getAllDocumentsAsync() async {
    final allDocIds = await this.allDocIds();
    return Future.wait(allDocIds.map(getDocumentByIdAsync));
  }

  @override
  Future<void> deleteDocumentAsync(CblDoc doc) {
    return database.deleteDocument(doc.doc);
  }

  @override
  Future<void> deleteDocumentsAsync(List<CblDoc> docs) {
    return database.inBatch(() async {
      await Future.wait(docs.map((doc) => database.deleteDocument(doc.doc)));
    });
  }
}

extension on BenchmarkDoc<String> {
  CblDoc toCblDoc() => CblDoc(
        id: id,
        index: index,
        guid: guid,
        isActive: isActive,
        balance: balance,
        picture: picture,
        age: age,
        eyeColor: eyeColor,
        name: name,
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
        friends: friends,
        greeting: greeting,
        favoriteFruit: favoriteFruit,
      );
}

class CblDoc with BenchmarkDoc<String> {
  CblDoc({
    required String id,
    required int index,
    required String guid,
    required bool isActive,
    required String balance,
    required String picture,
    required int age,
    required String eyeColor,
    required BenchmarkName name,
    required String company,
    required String email,
    required String phone,
    required String address,
    required String about,
    required String registered,
    required String latitude,
    required String longitude,
    required List<String> tags,
    required List<int> range,
    required List<BenchmarkFriend> friends,
    required String greeting,
    required String favoriteFruit,
  }) : this.fromDoc(MutableDocument.withId(id, {
          'index': index,
          'guid': guid,
          'isActive': isActive,
          'balance': balance,
          'picture': picture,
          'age': age,
          'eyeColor': eyeColor,
          'name': {
            'first': name.first,
            'last': name.last,
          },
          'company': company,
          'email': email,
          'phone': phone,
          'address': address,
          'about': about,
          'registered': registered,
          'latitude': latitude,
          'longitude': longitude,
          'tags': tags,
          'range': range,
          'friends': friends
              .map((friend) => {'id': friend.id, 'name': friend.name})
              .toList(),
          'greeting': greeting,
          'favoriteFruit': favoriteFruit,
        }));

  CblDoc.fromDoc(this.doc);

  Document doc;

  MutableDocument get mutableDoc {
    final doc = this.doc;
    if (doc is! MutableDocument) {
      return this.doc = doc.toMutable();
    }
    return doc;
  }

  @override
  String get id => doc.id;

  @override
  int get index => doc.value('index')!;

  @override
  String get guid => doc.value('guid')!;

  @override
  bool get isActive => doc.value('isActive')!;

  @override
  String get balance => doc.value('balance')!;

  @override
  String get picture => doc.value('picture')!;

  @override
  int get age => doc.value('age')!;

  @override
  String get eyeColor => doc.value('eyeColor')!;

  @override
  BenchmarkName get name => CblName.fromDict(doc.dictionary('name')!);

  @override
  String get company => doc.value('company')!;

  @override
  String get email => doc.value('email')!;

  @override
  String get phone => doc.value('phone')!;

  @override
  String get address => doc.value('address')!;

  @override
  String get about => doc.value('about')!;

  @override
  String get registered => doc.value('registered')!;

  @override
  String get latitude => doc.value('latitude')!;

  @override
  String get longitude => doc.value('longitude')!;

  @override
  List<String> get tags => doc.array('tags')!.cast<String>().toList();

  @override
  List<int> get range => doc.array('range')!.cast<int>().toList();

  @override
  List<BenchmarkFriend> get friends => doc
      .array('friends')!
      .cast<Dictionary>()
      .map((dict) => CblFriend.fromDict(dict))
      .toList();

  @override
  String get greeting => doc.value('greeting')!;

  @override
  String get favoriteFruit => doc.value('favoriteFruit')!;
}

class CblName with BenchmarkName {
  CblName({
    required String first,
    required String last,
  }) : this.fromDict(MutableDictionary({
          'first': first,
          'last': last,
        }));

  CblName.fromDict(this.dict);

  final Dictionary dict;

  @override
  String get first => dict.value('first')!;

  @override
  String get last => dict.value('last')!;
}

class CblFriend with BenchmarkFriend {
  CblFriend({
    required String id,
    required String name,
  }) : this.fromDict(MutableDictionary({
          'id': id,
          'name': name,
        }));

  CblFriend.fromDict(this.dict);

  final Dictionary dict;

  @override
  int get id => dict.value('id')!;

  @override
  String get name => dict.value('name')!;
}

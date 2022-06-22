import 'dart:async';

import 'package:benchmark/benchmark.dart';
import 'package:hive/hive.dart';

import 'constants.dart';
import 'hive_document.dart';

const bool _isWeb = identical(0, 0.0);

var _hiveIsInitialized = false;

void _initializeHive() {
  if (_hiveIsInitialized) {
    return;
  }
  _hiveIsInitialized = true;
  Hive.init(null, backendPreference: HiveStorageBackendPreference.webWorker);
  Hive.registerAdapter(HiveDocAdapter());
  Hive.registerAdapter(HiveNameAdapter());
  Hive.registerAdapter(HiveFriendAdapter());
}

class HiveProvider extends DatabaseProvider<String, HiveDoc> {
  @override
  String get name => databaseName;

  @override
  bool get supportsCurrentPlatform => true;

  @override
  bool supportsParameterArguments(ParameterArguments arguments) =>
      andPredicates([
        anyArgumentOf(execution, [Execution.async]),
        anyArgument(batchSize),
      ])(arguments);

  @override
  FutureOr<BenchmarkDatabase<String, HiveDoc>> openDatabase(
    String directory,
    ParameterArguments arguments,
  ) async {
    _initializeHive();

    final box = await Hive.openLazyBox<HiveDoc>('hive_benchmark', path: directory);
    return _HiveDatabase(box);
  }
}

class _HiveDatabase extends BenchmarkDatabase<String, HiveDoc> {
  _HiveDatabase(this.box);

  final LazyBox<HiveDoc> box;

  @override
  HiveDoc createBenchmarkDocImpl(BenchmarkDoc<String> doc) => doc.toHiveDoc();

  @override
  FutureOr<void> close() async {
    if (_isWeb) {
      await box.clear();
    }
    return box.close();
  }

  @override
  FutureOr<void> clear() => box.clear();

  @override
  Future<HiveDoc> createDocument(HiveDoc doc) async {
    await box.put(doc.id, doc);
    return doc;
  }

  @override
  Future<List<HiveDoc>> createDocuments(List<HiveDoc> docs) async {
    await box.putAll(<String, HiveDoc>{for (final doc in docs) doc.id: doc});
    return docs;
  }

  @override
  Future<HiveDoc> getDocumentById(String id) async => (await box.get(id))!;

  @override
  Future<List<HiveDoc>> getDocumentsById(List<String> ids) =>
      Future.wait(ids.map(getDocumentById));

  @override
  Future<List<HiveDoc>> getAllDocuments() =>
      Future.wait(box.keys.cast<String>().map(getDocumentById));

  @override
  Future<HiveDoc> updateDocument(HiveDoc doc) async {
    await box.put(doc.id, doc);
    return doc;
  }

  @override
  Future<List<HiveDoc>> updateDocuments(List<HiveDoc> docs) async {
    await box.putAll(<String, HiveDoc>{for (final doc in docs) doc.id: doc});
    return docs;
  }

  @override
  Future<void> deleteDocument(HiveDoc doc) {
    return box.delete(doc.id);
  }

  @override
  Future<void> deleteDocuments(List<HiveDoc> docs) {
    return box.deleteAll(docs.map<String>((doc) => doc.id));
  }
}

extension on BenchmarkDoc<String> {
  HiveDoc toHiveDoc() => HiveDoc(
        id: id,
        index: index,
        guid: guid,
        isActive: isActive,
        balance: balance,
        picture: picture,
        age: age,
        eyeColor: eyeColor,
        name: name.toHiveName(),
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
        friends: friends.map((friend) => friend.toHiveFriend()).toList(),
        greeting: greeting,
        favoriteFruit: favoriteFruit,
      );
}

extension on BenchmarkName {
  HiveName toHiveName() => HiveName(first: first, last: last);
}

extension on BenchmarkFriend {
  HiveFriend toHiveFriend() => HiveFriend(id: id, name: name);
}

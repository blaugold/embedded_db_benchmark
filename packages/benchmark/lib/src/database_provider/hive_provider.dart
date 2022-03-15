import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';
import 'package:hive/hive.dart';
import 'package:hive_document/hive_document.dart';

import '../../benchmark.dart';
import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../parameter.dart';

// TODO: Introduce hooks to init and dispose DatabaseProviders

var _typeAdaptersRegistered = false;

void _registerTypeAdapters() {
  if (_typeAdaptersRegistered) {
    return;
  }
  _typeAdaptersRegistered = true;
  Hive.registerAdapter(HiveDocAdapter());
  Hive.registerAdapter(HiveNameAdapter());
  Hive.registerAdapter(HiveFriendAdapter());
}

class HiveProvider extends DatabaseProvider<HiveDoc> {
  @override
  String get name => 'Hive';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.single(execution, Execution.async),
        ParameterRange.all(batchSize),
      ]);

  @override
  FutureOr<BenchmarkDatabase<HiveDoc>> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  ) async {
    _registerTypeAdapters();

    final box = await Hive.openLazyBox<HiveDoc>('benchmark', path: directory);
    return _HiveDatabase(box);
  }
}

class _HiveDatabase extends BenchmarkDatabase<HiveDoc> {
  _HiveDatabase(this.box);

  final LazyBox<HiveDoc> box;

  @override
  HiveDoc createBenchmarkDocImpl(BenchmarkDoc doc) => doc.toHiveDoc();

  @override
  FutureOr<void> close() => box.close();

  @override
  FutureOr<void> clear() => box.clear();

  @override
  Future<HiveDoc> createDocumentAsync(HiveDoc doc) async {
    await box.put(doc.id, doc);
    return doc;
  }

  @override
  Future<List<HiveDoc>> createDocumentsAsync(List<HiveDoc> docs) async {
    await box.putAll(<String, HiveDoc>{for (final doc in docs) doc.id: doc});
    return docs;
  }

  @override
  Future<HiveDoc> getDocumentByIdAsync(String id) async => (await box.get(id))!;
}

extension on BenchmarkDoc {
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

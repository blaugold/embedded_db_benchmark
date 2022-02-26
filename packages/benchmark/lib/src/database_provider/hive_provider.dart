import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive_document/hive_document.dart';

import '../../benchmark.dart';
import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
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

class HiveProvider extends DatabaseProvider {
  @override
  String get name => 'Hive';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.single(execution, Execution.async),
        ParameterRange.single(dataModel, DataModel.static),
        ParameterRange.all(writeBatching),
      ]);

  @override
  FutureOr<BenchmarkDatabase> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  ) async {
    _registerTypeAdapters();

    final box = await Hive.openLazyBox<HiveDoc>('benchmark', path: directory);
    return _HiveDatabase(box);
  }
}

class _HiveDatabase extends BenchmarkDatabase
    implements
        InsertOneDocumentAsync,
        InsertManyDocumentsAsync,
        LoadDocumentAsync {
  _HiveDatabase(this.box);

  final LazyBox<HiveDoc> box;

  @override
  FutureOr<void> close() => box.close();

  @override
  Future<void> insertOneDocumentAsync(BenchmarkDoc doc) =>
      box.put(doc.id, doc.toHiveDoc());

  @override
  Future<void> insertManyDocumentsAsync(List<BenchmarkDoc> docs) =>
      box.putAll(<String, HiveDoc>{
        for (final doc in docs) doc.id: doc.toHiveDoc(),
      });

  @override
  Future<BenchmarkDoc> loadDocumentAsync(String id) =>
      box.get(id).then((doc) => doc!.toBenchmarkDoc());
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

extension on HiveDoc {
  BenchmarkDoc toBenchmarkDoc() => BenchmarkDoc(
        id: id,
        index: index,
        guid: guid,
        isActive: isActive,
        balance: balance,
        picture: picture,
        age: age,
        eyeColor: eyeColor,
        name: BenchmarkName(first: name.first, last: name.last),
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
            .toList(),
        greeting: greeting,
        favoriteFruit: favoriteFruit,
      );
}

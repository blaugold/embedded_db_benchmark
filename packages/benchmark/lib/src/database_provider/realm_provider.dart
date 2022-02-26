import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:realm_dart/realm.dart';
import 'package:realm_document/realm_document.dart';

import '../../benchmark.dart';
import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class RealmProvider extends DatabaseProvider {
  @override
  String get name => 'Realm';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.single(execution, Execution.sync),
        ParameterRange.single(dataModel, DataModel.static),
        ParameterRange.all(writeBatching),
      ]);

  @override
  FutureOr<BenchmarkDatabase> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  ) {
    final config = Configuration([
      RealmDoc.schema,
      RealmName.schema,
      RealmFriend.schema,
      SimpleRealmDoc.schema,
    ]);
    config.path = p.join(directory, 'db.realm');

    return _RealmDatabase(Realm(config));
  }
}

class _RealmDatabase extends BenchmarkDatabase
    implements
        InsertOneDocumentSync,
        InsertManyDocumentsSync,
        LoadDocumentSync {
  _RealmDatabase(this.realm);

  final Realm realm;

  @override
  void close() => realm.close();

  @override
  void insertOneDocumentSync(BenchmarkDoc doc) {
    realm.write(() {
      realm.add(doc.toRealmDoc());
    });
  }

  @override
  void insertManyDocumentsSync(List<BenchmarkDoc> docs) {
    realm.write(() {
      realm.addAll(docs.map((doc) => doc.toRealmDoc()));
    });
  }

  @override
  BenchmarkDoc loadDocumentSync(String id) =>
      realm.find<RealmDoc>(id)!.toBenchmarkDoc();
}

extension on BenchmarkDoc {
  RealmDoc toRealmDoc() => RealmDoc(
        id,
        index,
        guid,
        isActive,
        balance,
        picture,
        age,
        eyeColor,
        company,
        email,
        phone,
        address,
        about,
        registered,
        latitude,
        longitude,
        greeting,
        favoriteFruit,
        name: name.toRealmName(),
        range: range,
        friends: friends.map((friend) => friend.toRealmFriend()),
      );
}

extension on BenchmarkName {
  RealmName toRealmName() => RealmName(first, last);
}

extension on BenchmarkFriend {
  RealmFriend toRealmFriend() => RealmFriend(id, name);
}

extension on RealmDoc {
  BenchmarkDoc toBenchmarkDoc() => BenchmarkDoc(
        id: id,
        index: index,
        guid: guid,
        isActive: isActive,
        balance: balance,
        picture: picture,
        age: age,
        eyeColor: eyeColor,
        name: name!.toBenchmarkName(),
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
        friends: friends.map((friend) => friend.toBenchmarkFriend()).toList(),
        greeting: greeting,
        favoriteFruit: favoriteFruit,
      );
}

extension on RealmName {
  BenchmarkName toBenchmarkName() => BenchmarkName(first: first, last: last);
}

extension on RealmFriend {
  BenchmarkFriend toBenchmarkFriend() => BenchmarkFriend(id: id, name: name);
}

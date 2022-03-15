import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';
import 'package:path/path.dart' as p;
import 'package:realm_dart/realm.dart';
import 'package:realm_document/realm_document.dart';

import '../../benchmark.dart';
import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../parameter.dart';

class RealmProvider extends DatabaseProvider<String, RealmDoc> {
  @override
  String get name => 'Realm';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.single(execution, Execution.sync),
        ParameterRange.all(batchSize),
      ]);

  @override
  FutureOr<BenchmarkDatabase<String, RealmDoc>> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  ) {
    final config = Configuration([
      RealmDoc.schema,
      RealmName.schema,
      RealmFriend.schema,
    ]);
    config.path = p.join(directory, 'db.realm');

    return _RealmDatabase(Realm(config));
  }
}

class _RealmDatabase extends BenchmarkDatabase<String, RealmDoc> {
  _RealmDatabase(this.realm);

  final Realm realm;

  @override
  RealmDoc createBenchmarkDocImpl(BenchmarkDoc<String> doc) => doc.toRealmDoc();

  @override
  void close() => realm.close();

  @override
  void clear() => realm.write(() {
        realm.deleteMany(realm.all<RealmDoc>());
      });

  @override
  RealmDoc createDocumentSync(RealmDoc doc) {
    realm.write(() {
      realm.add(doc);
    });
    return doc;
  }

  @override
  List<RealmDoc> createDocumentsSync(List<RealmDoc> docs) {
    realm.write(() {
      realm.addAll(docs);
    });
    return docs;
  }

  @override
  RealmDoc getDocumentByIdSync(String id) => realm.find<RealmDoc>(id)!;

  @override
  void deleteDocumentSync(RealmDoc doc) {
    realm.write(() {
      realm.delete(doc);
    });
  }

  @override
  void deleteDocumentsSync(List<RealmDoc> docs) {
    realm.write(() {
      realm.deleteMany(docs);
    });
  }
}

extension on BenchmarkDoc<String> {
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
        nameRel: name.toRealmName(),
        tags: tags,
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

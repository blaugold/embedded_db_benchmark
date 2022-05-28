import 'dart:async';

import 'package:benchmark/benchmark.dart';
import 'package:path/path.dart' as p;
import 'package:realm_dart/realm.dart';

import 'src/realm_document.dart';

class RealmProvider extends DatabaseProvider<String, RealmDoc> {
  @override
  String get name => 'Realm';

  @override
  bool supportsParameterArguments(ParameterArguments arguments) =>
      andPredicates([
        anyArgumentOf(execution, [Execution.sync]),
        anyArgument(batchSize),
      ])(arguments);

  @override
  FutureOr<BenchmarkDatabase<String, RealmDoc>> openDatabase(
    String directory,
    ParameterArguments arguments,
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
  RealmDoc createDocument(RealmDoc doc) {
    realm.write(() {
      realm.add(doc);
    });
    return doc;
  }

  @override
  List<RealmDoc> createDocuments(List<RealmDoc> docs) {
    realm.write(() {
      realm.addAll(docs);
    });
    return docs;
  }

  @override
  RealmDoc getDocumentById(String id) => realm.find<RealmDoc>(id)!;

  @override
  List<RealmDoc> getDocumentsById(List<String> ids) =>
      ids.map(getDocumentById).toList();

  @override
  List<RealmDoc> getAllDocuments() => realm.all<RealmDoc>().toList();

  @override
  RealmDoc updateDocument(RealmDoc doc) {
    realm.write(() {
      doc.balance_ = doc.updatedBalance!;
    });
    return doc;
  }

  @override
  List<RealmDoc> updateDocuments(List<RealmDoc> docs) {
    realm.write(() {
      for (final doc in docs) {
        doc.balance_ = doc.updatedBalance!;
      }
    });
    return docs;
  }

  @override
  void deleteDocument(RealmDoc doc) {
    realm.write(() {
      realm.delete(doc);
    });
  }

  @override
  void deleteDocuments(List<RealmDoc> docs) {
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

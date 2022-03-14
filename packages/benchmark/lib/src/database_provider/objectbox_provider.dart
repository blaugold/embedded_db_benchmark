import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';
import 'package:objectbox_document/objectbox.g.dart';
import 'package:objectbox_document/objectbox_document.dart';

import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../parameter.dart';
import 'database_provider.dart';

class ObjectBoxProvider extends DatabaseProvider<ObjectboxDoc> {
  @override
  String get name => 'ObjectBox';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.single(execution, Execution.sync),
        ParameterRange.all(batchSize),
      ]);

  @override
  FutureOr<BenchmarkDatabase<ObjectboxDoc>> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  ) async {
    final store = openStore(directory: directory);
    final box = store.box<ObjectboxDoc>();
    final query = box.query(ObjectboxDoc_.id.equals('')).build();
    return _ObjectBoxDatabase(store, box, query);
  }
}

class _ObjectBoxDatabase extends BenchmarkDatabase<ObjectboxDoc> {
  _ObjectBoxDatabase(this.store, this.box, this.query);

  final Store store;
  final Box<ObjectboxDoc> box;
  final Query<ObjectboxDoc> query;

  @override
  ObjectboxDoc createBenchmarkDocImpl(BenchmarkDoc doc) => doc.toObjectBoxDoc();

  @override
  void close() => store.close();

  @override
  ObjectboxDoc createDocumentSync(ObjectboxDoc doc) {
    box.put(doc);
    return doc;
  }

  @override
  List<ObjectboxDoc> createDocumentsSync(List<ObjectboxDoc> docs) {
    box.putMany([for (final doc in docs) doc.toObjectBoxDoc()]);
    return docs;
  }

  @override
  ObjectboxDoc getDocumentByIdSync(String id) {
    query.param(ObjectboxDoc_.id).value = id;
    return query.findFirst()!;
  }
}

extension on BenchmarkDoc {
  ObjectboxDoc toObjectBoxDoc() => ObjectboxDoc(
        id: id,
        index: index,
        guid: guid,
        isActive: isActive,
        balance: balance,
        picture: picture,
        age: age,
        eyeColor: eyeColor,
        company: company,
        email: email,
        phone: phone,
        address: address,
        about: about,
        registered: registered,
        latitude: latitude,
        longitude: longitude,
        tags: tags,
        dbRange: range.map((value) => value.toString()).toList(),
        greeting: greeting,
        favoriteFruit: favoriteFruit,
      )
        ..obxName.target = name.toObjectBoxName()
        ..obxFriends.addAll(
          friends.map((friend) => friend.toObjectBoxFriend()).toList(),
        );
}

extension on BenchmarkName {
  ObjectboxName toObjectBoxName() => ObjectboxName(first: first, last: last);
}

extension on BenchmarkFriend {
  ObjectboxFriend toObjectBoxFriend() => ObjectboxFriend(id: id, name: name);
}

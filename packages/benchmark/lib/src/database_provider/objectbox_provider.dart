import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';
import 'package:objectbox_document/objectbox.g.dart';
import 'package:objectbox_document/objectbox_document.dart';

import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../parameter.dart';
import 'database_provider.dart';

class ObjectBoxProvider extends DatabaseProvider<int, ObjectboxDoc> {
  @override
  String get name => 'ObjectBox';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.single(execution, Execution.sync),
        ParameterRange.all(batchSize),
      ]);

  @override
  FutureOr<BenchmarkDatabase<int, ObjectboxDoc>> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  ) async {
    final store = openStore(directory: directory);
    final box = store.box<ObjectboxDoc>();
    return _ObjectBoxDatabase(store, box);
  }
}

class _ObjectBoxDatabase extends BenchmarkDatabase<int, ObjectboxDoc> {
  _ObjectBoxDatabase(this.store, this.box);

  final Store store;
  final Box<ObjectboxDoc> box;

  @override
  ObjectboxDoc createBenchmarkDocImpl(BenchmarkDoc<int> doc) =>
      doc.toObjectBoxDoc();

  @override
  void close() => store.close();

  @override
  FutureOr<void> clear() => box.removeAll();

  @override
  ObjectboxDoc createDocumentSync(ObjectboxDoc doc) {
    box.put(doc);
    return doc;
  }

  @override
  List<ObjectboxDoc> createDocumentsSync(List<ObjectboxDoc> docs) {
    box.putMany([for (final doc in docs) doc]);
    return docs;
  }

  @override
  ObjectboxDoc getDocumentByIdSync(int id) => box.get(id)!;

  @override
  List<ObjectboxDoc> getDocumentsByIdSync(List<int> ids) =>
      box.getMany(ids).cast();

  @override
  void deleteDocumentsSync(List<ObjectboxDoc> docs) {
    box.removeMany(docs.map((doc) => doc.id).toList());
  }
}

extension on BenchmarkDoc<int> {
  ObjectboxDoc toObjectBoxDoc() => ObjectboxDoc(
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

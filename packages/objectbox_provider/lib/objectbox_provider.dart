import 'dart:async';

import 'package:benchmark/benchmark.dart';

import 'objectbox.g.dart';
import 'src/objectbox_document.dart';

class ObjectBoxProvider extends DatabaseProvider<int, ObjectboxDoc> {
  @override
  String get name => 'ObjectBox';

  @override
  bool supportsParameterArguments(ParameterArguments arguments) =>
      andPredicates([
        anyArgumentOf(execution, [Execution.sync]),
        anyArgument(batchSize),
      ])(arguments);

  @override
  FutureOr<BenchmarkDatabase<int, ObjectboxDoc>> openDatabase(
    String directory,
    ParameterArguments arguments,
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
  ObjectboxDoc createDocument(ObjectboxDoc doc) {
    box.put(doc, mode: PutMode.insert);
    return doc;
  }

  @override
  List<ObjectboxDoc> createDocuments(List<ObjectboxDoc> docs) {
    box.putMany([for (final doc in docs) doc], mode: PutMode.insert);
    return docs;
  }

  @override
  ObjectboxDoc getDocumentById(int id) => box.get(id)!;

  @override
  List<ObjectboxDoc> getDocumentsById(List<int> ids) => box.getMany(ids).cast();

  @override
  List<ObjectboxDoc> getAllDocuments() => box.getAll();

  @override
  ObjectboxDoc updateDocument(ObjectboxDoc doc) {
    box.put(doc, mode: PutMode.update);
    return doc;
  }

  @override
  List<ObjectboxDoc> updateDocuments(List<ObjectboxDoc> docs) {
    box.putMany([for (final doc in docs) doc], mode: PutMode.update);
    return docs;
  }

  @override
  void deleteDocument(ObjectboxDoc doc) {
    box.remove(doc.id);
  }

  @override
  void deleteDocuments(List<ObjectboxDoc> docs) {
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

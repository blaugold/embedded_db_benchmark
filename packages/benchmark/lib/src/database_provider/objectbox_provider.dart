import 'dart:async';

import 'package:objectbox_document/objectbox.g.dart';
import 'package:objectbox_document/objectbox_document.dart';

import '../benchmark_database.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';
import 'database_provider.dart';

class ObjectBoxProvider extends DatabaseProvider {
  @override
  String get name => 'ObjectBox';

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
  ) async {
    final store = openStore(directory: directory);
    final box = store.box<ObjectboxDoc>();
    final query = box.query(ObjectboxDoc_.id.equals('')).build();
    return _ObjectBoxDatabase(store, box, query);
  }
}

class _ObjectBoxDatabase extends BenchmarkDatabase
    implements
        InsertOneDocumentSync,
        InsertManyDocumentsSync,
        LoadDocumentSync {
  _ObjectBoxDatabase(this.store, this.box, this.query);

  final Store store;
  final Box<ObjectboxDoc> box;
  final Query<ObjectboxDoc> query;

  @override
  void close() => store.close();

  @override
  void insertOneDocumentSync(BenchmarkDoc doc) => box.put(doc.toObjectBoxDoc());

  @override
  void insertManyDocumentsSync(List<BenchmarkDoc> docs) =>
      box.putMany([for (final doc in docs) doc.toObjectBoxDoc()]);

  @override
  BenchmarkDoc loadDocumentSync(String id) {
    query.param(ObjectboxDoc_.id).value = id;
    return query.findFirst()!.toBenchmarkDoc();
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
        ..name.target = name.toObjectBoxName()
        ..friends.addAll(
          friends.map((friend) => friend.toObjectBoxFriend()).toList(),
        );
}

extension on BenchmarkName {
  ObjectboxName toObjectBoxName() => ObjectboxName(first: first, last: last);
}

extension on BenchmarkFriend {
  ObjectboxFriend toObjectBoxFriend() => ObjectboxFriend(id: id, name: name);
}

extension on ObjectboxDoc {
  BenchmarkDoc toBenchmarkDoc() => BenchmarkDoc(
        id: id,
        index: index,
        guid: guid,
        isActive: isActive,
        balance: balance,
        picture: picture,
        age: age,
        eyeColor: eyeColor,
        name: BenchmarkName(
          first: name.target!.first,
          last: name.target!.last,
        ),
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
            .toList()
          ..sort((a, b) => a.id - b.id),
        greeting: greeting,
        favoriteFruit: favoriteFruit,
      );
}

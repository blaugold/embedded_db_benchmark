import 'dart:async';
import 'dart:collection';

import 'package:benchmark/benchmark.dart';
import 'package:drift/drift.dart';

import 'drift_document.dart';

class DriftDatabase extends BenchmarkDatabase<int, DriftDoc> {
  DriftDatabase(this.db, {this.onClose});

  final DriftBenchmarkDatabase db;
  final FutureOr<void> Function()? onClose;

  @override
  DriftDoc createBenchmarkDocImpl(BenchmarkDoc<int> doc) => doc.toDriftDoc();

  @override
  Future<void> close() async {
    await db.close();
    await onClose?.call();
  }

  @override
  FutureOr<void> clear() => db.transaction(() => Future.wait([
        db.delete(db.driftDocs).go(),
        db.delete(db.driftNames).go(),
        db.delete(db.driftFriends).go(),
      ]));

  @override
  Future<DriftDoc> createDocument(DriftDoc doc) async =>
      (await createDocuments([doc])).first;

  @override
  Future<List<DriftDoc>> createDocuments(List<DriftDoc> docs) async {
    Future<DriftDoc> _createDocument(DriftDoc doc) async {
      final docId = doc.id = await db.into(db.driftDocs).insert(doc);

      doc.driftName!.docId = docId;
      for (final friend in doc.driftFriends!) {
        friend.docId = docId;
      }

      await Future.wait([
        db.into(db.driftNames).insert(doc.driftName!),
        ...doc.driftFriends!
            .map((friend) => db.into(db.driftFriends).insert(friend)),
      ]);

      return doc;
    }

    return db.transaction(() => Future.wait(docs.map(_createDocument)));
  }

  @override
  Future<DriftDoc> getDocumentById(int id) async =>
      (await getDocumentsById([id])).first;

  @override
  Future<List<DriftDoc>> getDocumentsById(List<int> ids) =>
      _getDocuments((driftDocs) => driftDocs.id.isIn(ids));

  Future<List<DriftDoc>> _getDocuments([
    Expression<bool?> Function($DriftDocsTable)? filter,
  ]) async {
    final select = db.select(db.driftDocs);

    if (filter != null) {
      select.where(filter);
    }

    final join = select.join([
      leftOuterJoin(
        db.driftNames,
        db.driftNames.docId.equalsExp(db.driftDocs.id),
      ),
      leftOuterJoin(
        db.driftFriends,
        db.driftFriends.docId.equalsExp(db.driftDocs.id),
      ),
    ]);

    final docs = HashMap<int, DriftDoc>();

    await join.map((row) {
      final doc = docs.putIfAbsent(row.read(db.driftDocs.id)!, () {
        return row.readTable(db.driftDocs)
          ..driftName = row.readTable(db.driftNames)
          ..driftFriends = [];
      });
      doc.driftFriends!.add(row.readTable(db.driftFriends));
    }).get();

    return docs.values.toList();
  }

  @override
  Future<List<DriftDoc>> getAllDocuments() => _getDocuments();

  @override
  Future<DriftDoc> updateDocument(DriftDoc doc) async =>
      (await updateDocuments([doc])).first;

  @override
  Future<List<DriftDoc>> updateDocuments(List<DriftDoc> docs) async {
    Future<DriftDoc> _updateDocument(DriftDoc doc) async {
      await Future.wait<void>([
        (db.update(db.driftDocs)
              ..where((driftDocs) => driftDocs.id.equals(doc.id)))
            .write(doc),
        (db.update(db.driftNames)
              ..where((driftNames) => driftNames.docId.equals(doc.id)))
            .write(doc.driftName!),
        ...doc.driftFriends!.map((friend) => (db.update(db.driftFriends)
              ..where(
                (driftFriends) =>
                    driftFriends.docId.equals(doc.id) &
                    driftFriends.id.equals(friend.id),
              ))
            .write(friend)),
      ]);

      return doc;
    }

    return db.transaction(() => Future.wait(docs.map(_updateDocument)));
  }

  @override
  Future<void> deleteDocument(DriftDoc doc) async {
    await deleteDocuments([doc]);
  }

  @override
  Future<void> deleteDocuments(List<DriftDoc> docs) => db.transaction(() async {
        final docIds = docs.map((doc) => doc.id).toList(growable: false);
        final friendIds = docs
            .map((doc) => doc.driftFriends!)
            .expand((friends) => friends)
            .map((friend) => friend.id)
            .toList(growable: false);
        await Future.wait([
          (db.delete(db.driftDocs)
                ..where((driftDocs) => driftDocs.id.isIn(docIds)))
              .go(),
          (db.delete(db.driftNames)
                ..where((driftNames) => driftNames.docId.isIn(docIds)))
              .go(),
          (db.delete(db.driftFriends)
                ..where((driftFriends) => driftFriends.id.isIn(friendIds)))
              .go(),
        ]);
      });
}

extension on BenchmarkDoc<int> {
  DriftDoc toDriftDoc() => DriftDoc(
        index: index,
        guid: guid,
        isActive: isActive,
        balance: balance,
        picture: picture,
        age: age,
        eyeColor: eyeColor,
        driftName: name.toDriftName(),
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
        driftFriends: friends.map((friend) => friend.toDriftFriend()).toList(),
        greeting: greeting,
        favoriteFruit: favoriteFruit,
      );
}

extension on BenchmarkName {
  DriftName toDriftName() => DriftName(first: first, last: last);
}

extension on BenchmarkFriend {
  DriftFriend toDriftFriend() => DriftFriend(id: id, name: name);
}

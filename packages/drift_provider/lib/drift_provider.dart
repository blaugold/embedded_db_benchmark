import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:isolate';

import 'package:benchmark/benchmark.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'src/drift_document.dart';

class DriftProvider extends DatabaseProvider<int, DriftDoc> {
  @override
  String get name => 'Drift';

  @override
  bool supportsParameterArguments(ParameterArguments arguments) =>
      andPredicates([
        anyArgumentOf(execution, [Execution.async]),
        anyArgument(batchSize),
      ])(arguments);

  @override
  FutureOr<BenchmarkDatabase<int, DriftDoc>> openDatabase(
    String directory,
    ParameterArguments arguments,
  ) async {
    final dbFile = p.join(directory, 'db.sqlite');
    final driftIsolate = await _createDriftIsolate(dbFile);
    final connection = await driftIsolate.connect();
    final driftDb = DriftBenchmarkDatabase.connect(connection);
    return _DriftDatabase(driftDb, driftIsolate);
  }
}

Future<DriftIsolate> _createDriftIsolate(String path) async {
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, path),
  );

  return await receivePort.first as DriftIsolate;
}

void _startBackground(_IsolateStartRequest request) {
  final executor = NativeDatabase(File(request.targetPath));
  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );
  request.sendDriftIsolate.send(driftIsolate);
}

class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}

class _DriftDatabase extends BenchmarkDatabase<int, DriftDoc> {
  _DriftDatabase(this.db, this.isolate);

  final DriftBenchmarkDatabase db;
  final DriftIsolate isolate;

  @override
  DriftDoc createBenchmarkDocImpl(BenchmarkDoc<int> doc) => doc.toDriftDoc();

  @override
  FutureOr<void> close() async {
    await db.close();
    await isolate.shutdownAll();
  }

  @override
  FutureOr<void> clear() => db.transaction(() => Future.wait([
        db.delete(db.driftDocs).go(),
        db.delete(db.driftNames).go(),
        db.delete(db.driftFriends).go(),
      ]));

  @override
  Future<List<DriftDoc>> createDocumentsAsync(List<DriftDoc> docs) async {
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
  Future<List<DriftDoc>> getDocumentsByIdAsync(List<int> ids) =>
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
  Future<List<DriftDoc>> getAllDocumentsAsync() => _getDocuments();

  @override
  Future<List<DriftDoc>> updateDocumentsAsync(List<DriftDoc> docs) async {
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
  Future<void> deleteDocumentsAsync(List<DriftDoc> docs) =>
      db.transaction(() async {
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

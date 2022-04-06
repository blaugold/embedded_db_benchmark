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
    final path = p.join(directory, 'db.sqlite');
    return _createDB(path, backgroundIsolate: true);
  }
}

Future<_DriftDatabase> _createDB(
  String path, {
  required bool backgroundIsolate,
}) async {
  DriftBenchmarkDatabase db;
  Isolate? isolate;
  DriftIsolate? driftIsolate;

  if (backgroundIsolate) {
    final receivePort = ReceivePort();
    isolate = await Isolate.spawn(
      _startBackground,
      _IsolateStartRequest(receivePort.sendPort, path),
    );
    driftIsolate = await receivePort.first as DriftIsolate;
    db = DriftBenchmarkDatabase.connect(await driftIsolate.connect());
  } else {
    db = DriftBenchmarkDatabase(NativeDatabase(File(path)));
  }

  return _DriftDatabase(db, driftIsolate: driftIsolate, isolate: isolate);
}

void _startBackground(_IsolateStartRequest request) {
  final executor = NativeDatabase(File(request.targetPath));
  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
    killIsolateWhenDone: true,
  );
  request.sendDriftIsolate.send(driftIsolate);
}

class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}

class _DriftDatabase extends BenchmarkDatabase<int, DriftDoc> {
  _DriftDatabase(this.db, {this.driftIsolate, this.isolate});

  final DriftBenchmarkDatabase db;
  final DriftIsolate? driftIsolate;
  // TODO: Remove isolate field when `DriftIsolate.shutdownAll` is fixed.
  final Isolate? isolate;

  @override
  DriftDoc createBenchmarkDocImpl(BenchmarkDoc<int> doc) => doc.toDriftDoc();

  @override
  FutureOr<void> close() async {
    await db.close();
    // await driftIsolate?.shutdownAll();
    isolate?.kill();
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

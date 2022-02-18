import 'dart:io';

import 'package:cbl/cbl.dart';
import 'package:hive/hive.dart' as hive;
import 'package:isar/isar.dart';
import 'package:isar_document/isar_document.dart';
import 'package:objectbox/objectbox.dart' as objectbox;
import 'package:objectbox_document/objectbox.g.dart';
import 'package:objectbox_document/objectbox_document.dart';
import 'package:realm_dart/realm.dart';
import 'package:realm_document/realm_document.dart';

import '../async_benchmark_base.dart';
import '../fixture/document_utils.dart';

const batchSize = 100;

late final List<DocumentMap> documents;

String benchmarkName(String db) => '$db -> Read Document';

class CblReadDocument extends AsyncBenchmarkBase {
  CblReadDocument() : super(benchmarkName('CBL'));

  late final SyncDatabase db;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    db = Database.openSync(
      'db',
      DatabaseConfiguration(directory: tmpDir.path),
    );

    for (final document in documents) {
      db.saveDocument(
          MutableDocument.withId(createDocumentId(document), document));
    }
  }

  @override
  Future<void> run() async {
    for (final document in documents) {
      final doc = db.document(getDocumentId(document));
      doc!.toPlainMap();
    }
  }

  @override
  Future<void> teardown() async {
    await db.close();
  }
}

class CblReadDocumentAsync extends AsyncBenchmarkBase {
  CblReadDocumentAsync() : super(benchmarkName('CBL Async'));

  late final AsyncDatabase db;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    db = await Database.openAsync(
      'db',
      DatabaseConfiguration(directory: tmpDir.path),
    );

    for (final document in documents) {
      await db.saveDocument(
        MutableDocument.withId(createDocumentId(document), document),
      );
    }
  }

  @override
  Future<void> run() async {
    for (final document in documents) {
      final doc = await db.document(getDocumentId(document));
      doc!.toPlainMap();
    }
  }

  @override
  Future<void> teardown() async {
    await db.close();
  }
}

class HiveReadDocument extends AsyncBenchmarkBase {
  HiveReadDocument() : super(benchmarkName('Hive'));

  late final hive.Box<DocumentMap> box;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    box = await hive.Hive.openBox('db', path: tmpDir.path);

    for (final document in documents) {
      await box.put(createDocumentId(document), document);
    }
  }

  @override
  Future<void> run() async {
    for (final document in documents) {
      box.get(getDocumentId(document));
    }
  }

  @override
  Future<void> teardown() {
    return box.close();
  }
}

class RealmReadDocument extends AsyncBenchmarkBase {
  RealmReadDocument() : super(benchmarkName('Realm'));

  late final Realm realm;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    final config = Configuration([
      RealmDoc.schema,
      RealmName.schema,
      RealmFriend.schema,
      SimpleRealmDoc.schema,
    ]);
    config.path = '${tmpDir.path}${Platform.pathSeparator}db.realm';
    realm = Realm(config);

    realm.write(() {
      for (final document in documents) {
        realm.add(realmDocFromJson(createDocumentId(document), document));
      }
    });
  }

  @override
  Future<void> run() async {
    for (final document in documents) {
      final doc = realm.find<RealmDoc>(getDocumentId(document));
      doc!.toJson();
    }
  }

  @override
  Future<void> teardown() async {
    realm.close();
  }
}

class IsarReadDocument extends AsyncBenchmarkBase {
  IsarReadDocument() : super(benchmarkName('Isar'));

  late final Isar isar;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    isar = await Isar.open(
      schemas: [
        IsarDocSchema,
        IsarNameSchema,
        IsarFriendSchema,
      ],
      directory: tmpDir.path,
      relaxedDurability: false,
    );

    isar.writeTxnSync((isar) {
      for (final document in documents) {
        final doc = IsarDoc.fromJson(createDocumentId(document), document);
        isar.isarNames.putSync(doc.name.value!);
        isar.isarFriends.putAllSync(doc.friends.toList());
        isar.isarDocs.putSync(doc);
        doc.name.saveSync();
        doc.friends.saveSync();
      }
    });
  }

  @override
  Future<void> run() async {
    isar.writeTxnSync((isar) {
      for (final document in documents) {
        final doc = isar.isarDocs
            .where()
            .idEqualTo(getDocumentId(document))
            .findFirstSync();
        doc!.toJson();
      }
    });
  }

  @override
  Future<void> teardown() async {
    await isar.close();
  }
}

class ObjectboxReadDocument extends AsyncBenchmarkBase {
  ObjectboxReadDocument() : super(benchmarkName('Objectbox'));

  late final Store store;
  late final objectbox.Box<ObjectboxDoc> box;
  late final objectbox.Query<ObjectboxDoc> query;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    store = openStore(directory: tmpDir.path);
    box = store.box<ObjectboxDoc>();

    box.putMany(<ObjectboxDoc>[
      for (final document in documents)
        ObjectboxDoc.fromJson(createDocumentId(document), document)
    ]);

    query = box.query(ObjectboxDoc_.id.equals('')).build();
  }

  @override
  Future<void> run() async {
    for (final document in documents) {
      query.param(ObjectboxDoc_.id).value = getDocumentId(document);
      final doc = query.findFirst();
      doc!.toJson();
    }
  }

  @override
  Future<void> teardown() async {
    store.close();
  }
}

Future<void> runBenchmarks({
  bool withRealm = true,
  bool withIsar = true,
  bool withObjectBox = true,
}) async {
  documents = await loadDocuments()
      .then((documents) => documents.take(batchSize).toList());

  final benchmarks = [
    CblReadDocument(),
    CblReadDocumentAsync(),
    HiveReadDocument(),
    if (withRealm) RealmReadDocument(),
    if (withIsar) IsarReadDocument(),
    if (withObjectBox) ObjectboxReadDocument(),
  ];

  for (final benchmark in benchmarks) {
    await benchmark.report(repeatsPerRun: batchSize);
  }
}

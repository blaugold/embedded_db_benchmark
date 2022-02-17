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

String benchmarkName(String db, {required bool batched}) =>
    '$db -> Write Document${batched ? ' (batched)' : ''}';

class CblWriteDocument extends AsyncBenchmarkBase {
  CblWriteDocument({required this.inBatch})
      : super(benchmarkName('CBL', batched: inBatch));

  final bool inBatch;

  late final SyncDatabase db;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    db = Database.openSync(
      'db',
      DatabaseConfiguration(directory: tmpDir.path),
    );
  }

  @override
  Future<void> run() async {
    if (inBatch) {
      db.inBatchSync(() {
        for (final document in documents) {
          db.saveDocument(
            MutableDocument.withId(createDocumentId(document), document),
          );
        }
      });
    } else {
      for (final document in documents) {
        db.saveDocument(
          MutableDocument.withId(createDocumentId(document), document),
        );
      }
    }
  }

  @override
  Future<void> teardown() async {
    await db.close();
  }
}

class CblWriteDocumentAsync extends AsyncBenchmarkBase {
  CblWriteDocumentAsync({required this.inBatch})
      : super(benchmarkName('CBL Async', batched: inBatch));

  final bool inBatch;

  late final AsyncDatabase db;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    db = await Database.openAsync(
      'db',
      DatabaseConfiguration(directory: tmpDir.path),
    );
  }

  @override
  Future<void> run() async {
    if (inBatch) {
      await db.inBatch(() async {
        for (final document in documents) {
          await db.saveDocument(
            MutableDocument.withId(createDocumentId(document), document),
          );
        }
      });
    } else {
      for (final document in documents) {
        await db.saveDocument(
          MutableDocument.withId(createDocumentId(document), document),
        );
      }
    }
  }

  @override
  Future<void> teardown() async {
    await db.close();
  }
}

class HiveWriteDocument extends AsyncBenchmarkBase {
  HiveWriteDocument() : super(benchmarkName('Hive', batched: false));

  late final hive.Box<DocumentMap> box;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    box = await hive.Hive.openBox('db', path: tmpDir.path);
  }

  @override
  Future<void> run() async {
    for (final document in documents) {
      await box.put(createDocumentId(document), document);
    }
  }

  @override
  Future<void> teardown() {
    return box.close();
  }
}

class RealmWriteDocument extends AsyncBenchmarkBase {
  RealmWriteDocument() : super(benchmarkName('Realm', batched: true));

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
  }

  @override
  Future<void> run() async {
    realm.write(() {
      for (final document in documents) {
        realm.add(realmDocFromJson(createDocumentId(document), document));
      }
    });
  }

  @override
  Future<void> teardown() async {
    realm.close();
  }
}

class IsarWriteDocument extends AsyncBenchmarkBase {
  IsarWriteDocument() : super(benchmarkName('Isar', batched: true));

  late final Isar isar;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    isar = await Isar.open(
      schemas: [IsarDocSchema],
      directory: tmpDir.path,
      relaxedDurability: false,
    );
  }

  @override
  Future<void> run() async {
    isar.writeTxnSync((isar) {
      isar.isarDocs.putAllSync([
        for (final document in documents)
          isarDocFromJson(createDocumentId(document), document)
      ]);
    });
  }

  @override
  Future<void> teardown() async {
    await isar.close();
  }
}

class ObjectboxWriteDocument extends AsyncBenchmarkBase {
  ObjectboxWriteDocument() : super(benchmarkName('Objectbox', batched: true));

  late final Store store;
  late final objectbox.Box box;

  @override
  Future<void> setup() async {
    final tmpDir = Directory.systemTemp.createTempSync();
    store = openStore(directory: tmpDir.path);
    box = store.box<ObjectboxDoc>();
  }

  @override
  Future<void> run() async {
    box.putMany(<ObjectboxDoc>[
      for (final document in documents)
        ObjectboxDoc.fromJson(createDocumentId(document), document)
    ]);
  }

  @override
  Future<void> teardown() async {
    store.close();
  }
}

Future<void> runBenchmarks({bool withIsar = true}) async {
  documents = await loadDocuments()
      .then((documents) => documents.take(batchSize).toList());

  final benchmarks = [
    CblWriteDocument(inBatch: false),
    CblWriteDocument(inBatch: true),
    CblWriteDocumentAsync(inBatch: false),
    CblWriteDocumentAsync(inBatch: true),
    HiveWriteDocument(),
    RealmWriteDocument(),
    if (withIsar) IsarWriteDocument(),
    ObjectboxWriteDocument(),
  ];

  // debugger();
  for (final benchmark in benchmarks) {
    await benchmark.report(repeatsPerRun: batchSize);
  }
  // debugger();
}

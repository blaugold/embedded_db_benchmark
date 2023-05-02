import 'dart:convert';

import 'package:benchmark/benchmark.dart';
import 'package:drift/drift.dart';

part 'drift_document.g.dart';

class _JsonListConverter<T> implements TypeConverter<List<T>, String> {
  const _JsonListConverter();

  @override
  List<T> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List<Object?>).cast<T>();

  @override
  String toSql(List<T> value) => jsonEncode(value);
}

@UseRowClass(DriftDoc)
class DriftDocs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get index => integer()();
  TextColumn get guid => text()();
  BoolColumn get isActive => boolean()();
  TextColumn get balance => text()();
  TextColumn get picture => text()();
  IntColumn get age => integer()();
  TextColumn get eyeColor => text()();
  TextColumn get company => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get address => text()();
  TextColumn get about => text()();
  TextColumn get registered => text()();
  TextColumn get latitude => text()();
  TextColumn get longitude => text()();
  TextColumn get tags => text().map(const _JsonListConverter<String>())();
  TextColumn get range => text().map(const _JsonListConverter<int>())();
  TextColumn get greeting => text()();
  TextColumn get favoriteFruit => text()();
}

class DriftDoc with BenchmarkDoc<int> implements Insertable<DriftDoc> {
  DriftDoc({
    this.id = 0,
    required this.index,
    required this.guid,
    required this.isActive,
    required this.balance,
    required this.picture,
    required this.age,
    required this.eyeColor,
    this.driftName,
    required this.company,
    required this.email,
    required this.phone,
    required this.address,
    required this.about,
    required this.registered,
    required this.latitude,
    required this.longitude,
    required this.tags,
    required this.range,
    this.driftFriends,
    required this.greeting,
    required this.favoriteFruit,
  });

  @override
  int id;
  @override
  final int index;
  @override
  final String guid;
  @override
  final bool isActive;
  @override
  String balance;
  @override
  final String picture;
  @override
  final int age;
  @override
  final String eyeColor;
  @override
  BenchmarkName get name => driftName!;
  DriftName? driftName;
  @override
  final String company;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String address;
  @override
  final String about;
  @override
  final String registered;
  @override
  final String latitude;
  @override
  final String longitude;
  @override
  final List<String> tags;
  @override
  final List<int> range;
  @override
  List<BenchmarkFriend> get friends => driftFriends!;
  List<DriftFriend>? driftFriends;
  @override
  final String greeting;
  @override
  final String favoriteFruit;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return DriftDocsCompanion(
      id: id == 0 ? const Value.absent() : Value(id),
      index: Value(index),
      guid: Value(guid),
      isActive: Value(isActive),
      balance: Value(balance),
      picture: Value(picture),
      age: Value(age),
      eyeColor: Value(eyeColor),
      company: Value(company),
      email: Value(email),
      phone: Value(phone),
      address: Value(address),
      about: Value(about),
      registered: Value(registered),
      latitude: Value(latitude),
      longitude: Value(longitude),
      tags: Value(tags),
      range: Value(range),
      greeting: Value(greeting),
      favoriteFruit: Value(favoriteFruit),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(DriftName)
class DriftNames extends Table {
  @override
  Set<Column> get primaryKey => {docId};

  IntColumn get docId => integer()();
  TextColumn get first => text()();
  TextColumn get last => text()();
}

class DriftName with BenchmarkName implements Insertable<DriftName> {
  DriftName({this.docId, required this.first, required this.last});

  int? docId;

  @override
  final String first;

  @override
  final String last;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return DriftNamesCompanion(
      docId: docId == null ? const Value.absent() : Value(docId!),
      first: Value(first),
      last: Value(last),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(DriftFriend)
class DriftFriends extends Table {
  @override
  Set<Column> get primaryKey => {docId, id};

  IntColumn get docId => integer()();
  IntColumn get id => integer()();
  TextColumn get name => text()();
}

class DriftFriend with BenchmarkFriend implements Insertable<DriftFriend> {
  DriftFriend({this.docId, required this.id, required this.name});

  int? docId;

  @override
  final int id;

  @override
  final String name;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return DriftFriendsCompanion(
      docId: docId == null ? const Value.absent() : Value(docId!),
      id: Value(id),
      name: Value(name),
    ).toColumns(nullToAbsent);
  }
}

@DriftDatabase(tables: [DriftDocs, DriftNames, DriftFriends])
class DriftBenchmarkDatabase extends _$DriftBenchmarkDatabase {
  DriftBenchmarkDatabase(QueryExecutor queryExecutor) : super(queryExecutor);

  DriftBenchmarkDatabase.connect(DatabaseConnection connection)
      : super(connection);

  @override
  int get schemaVersion => 1;
}

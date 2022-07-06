// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_document.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RealmDoc extends _RealmDoc with RealmEntity, RealmObject {
  RealmDoc(
    String id,
    int index,
    String guid,
    bool isActive,
    String balance_,
    String picture,
    int age,
    String eyeColor,
    String company,
    String email,
    String phone,
    String address,
    String about,
    String registered,
    String latitude,
    String longitude,
    String greeting,
    String favoriteFruit, {
    RealmName? nameRel,
    Iterable<String> tags = const [],
    Iterable<int> range = const [],
    Iterable<RealmFriend> friends = const [],
  }) {
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'index', index);
    RealmObject.set(this, 'guid', guid);
    RealmObject.set(this, 'isActive', isActive);
    RealmObject.set(this, 'balance_', balance_);
    RealmObject.set(this, 'picture', picture);
    RealmObject.set(this, 'age', age);
    RealmObject.set(this, 'eyeColor', eyeColor);
    RealmObject.set(this, 'nameRel', nameRel);
    RealmObject.set(this, 'company', company);
    RealmObject.set(this, 'email', email);
    RealmObject.set(this, 'phone', phone);
    RealmObject.set(this, 'address', address);
    RealmObject.set(this, 'about', about);
    RealmObject.set(this, 'registered', registered);
    RealmObject.set(this, 'latitude', latitude);
    RealmObject.set(this, 'longitude', longitude);
    RealmObject.set(this, 'greeting', greeting);
    RealmObject.set(this, 'favoriteFruit', favoriteFruit);
    RealmObject.set<RealmList<String>>(this, 'tags', RealmList<String>(tags));
    RealmObject.set<RealmList<int>>(this, 'range', RealmList<int>(range));
    RealmObject.set<RealmList<RealmFriend>>(
        this, 'friends', RealmList<RealmFriend>(friends));
  }

  RealmDoc._();

  @override
  String get id => RealmObject.get<String>(this, 'id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  int get index => RealmObject.get<int>(this, 'index') as int;
  @override
  set index(int value) => throw RealmUnsupportedSetError();

  @override
  String get guid => RealmObject.get<String>(this, 'guid') as String;
  @override
  set guid(String value) => throw RealmUnsupportedSetError();

  @override
  bool get isActive => RealmObject.get<bool>(this, 'isActive') as bool;
  @override
  set isActive(bool value) => throw RealmUnsupportedSetError();

  @override
  String get balance_ => RealmObject.get<String>(this, 'balance_') as String;
  @override
  set balance_(String value) => RealmObject.set(this, 'balance_', value);

  @override
  String get picture => RealmObject.get<String>(this, 'picture') as String;
  @override
  set picture(String value) => throw RealmUnsupportedSetError();

  @override
  int get age => RealmObject.get<int>(this, 'age') as int;
  @override
  set age(int value) => throw RealmUnsupportedSetError();

  @override
  String get eyeColor => RealmObject.get<String>(this, 'eyeColor') as String;
  @override
  set eyeColor(String value) => throw RealmUnsupportedSetError();

  @override
  RealmName? get nameRel =>
      RealmObject.get<RealmName>(this, 'nameRel') as RealmName?;
  @override
  set nameRel(covariant RealmName? value) => throw RealmUnsupportedSetError();

  @override
  String get company => RealmObject.get<String>(this, 'company') as String;
  @override
  set company(String value) => throw RealmUnsupportedSetError();

  @override
  String get email => RealmObject.get<String>(this, 'email') as String;
  @override
  set email(String value) => throw RealmUnsupportedSetError();

  @override
  String get phone => RealmObject.get<String>(this, 'phone') as String;
  @override
  set phone(String value) => throw RealmUnsupportedSetError();

  @override
  String get address => RealmObject.get<String>(this, 'address') as String;
  @override
  set address(String value) => throw RealmUnsupportedSetError();

  @override
  String get about => RealmObject.get<String>(this, 'about') as String;
  @override
  set about(String value) => throw RealmUnsupportedSetError();

  @override
  String get registered =>
      RealmObject.get<String>(this, 'registered') as String;
  @override
  set registered(String value) => throw RealmUnsupportedSetError();

  @override
  String get latitude => RealmObject.get<String>(this, 'latitude') as String;
  @override
  set latitude(String value) => throw RealmUnsupportedSetError();

  @override
  String get longitude => RealmObject.get<String>(this, 'longitude') as String;
  @override
  set longitude(String value) => throw RealmUnsupportedSetError();

  @override
  RealmList<String> get tags =>
      RealmObject.get<String>(this, 'tags') as RealmList<String>;
  @override
  set tags(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<int> get range =>
      RealmObject.get<int>(this, 'range') as RealmList<int>;
  @override
  set range(covariant RealmList<int> value) => throw RealmUnsupportedSetError();

  @override
  RealmList<RealmFriend> get friends =>
      RealmObject.get<RealmFriend>(this, 'friends') as RealmList<RealmFriend>;
  @override
  set friends(covariant RealmList<RealmFriend> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get greeting => RealmObject.get<String>(this, 'greeting') as String;
  @override
  set greeting(String value) => throw RealmUnsupportedSetError();

  @override
  String get favoriteFruit =>
      RealmObject.get<String>(this, 'favoriteFruit') as String;
  @override
  set favoriteFruit(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RealmDoc>> get changes =>
      RealmObject.getChanges<RealmDoc>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(RealmDoc._);
    return const SchemaObject(RealmDoc, 'RealmDoc', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('index', RealmPropertyType.int),
      SchemaProperty('guid', RealmPropertyType.string),
      SchemaProperty('isActive', RealmPropertyType.bool),
      SchemaProperty('balance_', RealmPropertyType.string),
      SchemaProperty('picture', RealmPropertyType.string),
      SchemaProperty('age', RealmPropertyType.int),
      SchemaProperty('eyeColor', RealmPropertyType.string),
      SchemaProperty('nameRel', RealmPropertyType.object,
          optional: true, linkTarget: 'RealmName'),
      SchemaProperty('company', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('phone', RealmPropertyType.string),
      SchemaProperty('address', RealmPropertyType.string),
      SchemaProperty('about', RealmPropertyType.string),
      SchemaProperty('registered', RealmPropertyType.string),
      SchemaProperty('latitude', RealmPropertyType.string),
      SchemaProperty('longitude', RealmPropertyType.string),
      SchemaProperty('tags', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('range', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
      SchemaProperty('friends', RealmPropertyType.object,
          linkTarget: 'RealmFriend', collectionType: RealmCollectionType.list),
      SchemaProperty('greeting', RealmPropertyType.string),
      SchemaProperty('favoriteFruit', RealmPropertyType.string),
    ]);
  }
}

class RealmName extends _RealmName with RealmEntity, RealmObject {
  RealmName(
    String first,
    String last,
  ) {
    RealmObject.set(this, 'first', first);
    RealmObject.set(this, 'last', last);
  }

  RealmName._();

  @override
  String get first => RealmObject.get<String>(this, 'first') as String;
  @override
  set first(String value) => throw RealmUnsupportedSetError();

  @override
  String get last => RealmObject.get<String>(this, 'last') as String;
  @override
  set last(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RealmName>> get changes =>
      RealmObject.getChanges<RealmName>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(RealmName._);
    return const SchemaObject(RealmName, 'RealmName', [
      SchemaProperty('first', RealmPropertyType.string),
      SchemaProperty('last', RealmPropertyType.string),
    ]);
  }
}

class RealmFriend extends _RealmFriend with RealmEntity, RealmObject {
  RealmFriend(
    int id,
    String name,
  ) {
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'name', name);
  }

  RealmFriend._();

  @override
  int get id => RealmObject.get<int>(this, 'id') as int;
  @override
  set id(int value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RealmFriend>> get changes =>
      RealmObject.getChanges<RealmFriend>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(RealmFriend._);
    return const SchemaObject(RealmFriend, 'RealmFriend', [
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

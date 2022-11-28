// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_document.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RealmDoc extends _RealmDoc
    with RealmEntity, RealmObjectBase, RealmObject {
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
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'index', index);
    RealmObjectBase.set(this, 'guid', guid);
    RealmObjectBase.set(this, 'isActive', isActive);
    RealmObjectBase.set(this, 'balance_', balance_);
    RealmObjectBase.set(this, 'picture', picture);
    RealmObjectBase.set(this, 'age', age);
    RealmObjectBase.set(this, 'eyeColor', eyeColor);
    RealmObjectBase.set(this, 'nameRel', nameRel);
    RealmObjectBase.set(this, 'company', company);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'phone', phone);
    RealmObjectBase.set(this, 'address', address);
    RealmObjectBase.set(this, 'about', about);
    RealmObjectBase.set(this, 'registered', registered);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
    RealmObjectBase.set(this, 'greeting', greeting);
    RealmObjectBase.set(this, 'favoriteFruit', favoriteFruit);
    RealmObjectBase.set<RealmList<String>>(
        this, 'tags', RealmList<String>(tags));
    RealmObjectBase.set<RealmList<int>>(this, 'range', RealmList<int>(range));
    RealmObjectBase.set<RealmList<RealmFriend>>(
        this, 'friends', RealmList<RealmFriend>(friends));
  }

  RealmDoc._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  int get index => RealmObjectBase.get<int>(this, 'index') as int;
  @override
  set index(int value) => throw RealmUnsupportedSetError();

  @override
  String get guid => RealmObjectBase.get<String>(this, 'guid') as String;
  @override
  set guid(String value) => throw RealmUnsupportedSetError();

  @override
  bool get isActive => RealmObjectBase.get<bool>(this, 'isActive') as bool;
  @override
  set isActive(bool value) => throw RealmUnsupportedSetError();

  @override
  String get balance_ =>
      RealmObjectBase.get<String>(this, 'balance_') as String;
  @override
  set balance_(String value) => RealmObjectBase.set(this, 'balance_', value);

  @override
  String get picture => RealmObjectBase.get<String>(this, 'picture') as String;
  @override
  set picture(String value) => throw RealmUnsupportedSetError();

  @override
  int get age => RealmObjectBase.get<int>(this, 'age') as int;
  @override
  set age(int value) => throw RealmUnsupportedSetError();

  @override
  String get eyeColor =>
      RealmObjectBase.get<String>(this, 'eyeColor') as String;
  @override
  set eyeColor(String value) => throw RealmUnsupportedSetError();

  @override
  RealmName? get nameRel =>
      RealmObjectBase.get<RealmName>(this, 'nameRel') as RealmName?;
  @override
  set nameRel(covariant RealmName? value) => throw RealmUnsupportedSetError();

  @override
  String get company => RealmObjectBase.get<String>(this, 'company') as String;
  @override
  set company(String value) => throw RealmUnsupportedSetError();

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => throw RealmUnsupportedSetError();

  @override
  String get phone => RealmObjectBase.get<String>(this, 'phone') as String;
  @override
  set phone(String value) => throw RealmUnsupportedSetError();

  @override
  String get address => RealmObjectBase.get<String>(this, 'address') as String;
  @override
  set address(String value) => throw RealmUnsupportedSetError();

  @override
  String get about => RealmObjectBase.get<String>(this, 'about') as String;
  @override
  set about(String value) => throw RealmUnsupportedSetError();

  @override
  String get registered =>
      RealmObjectBase.get<String>(this, 'registered') as String;
  @override
  set registered(String value) => throw RealmUnsupportedSetError();

  @override
  String get latitude =>
      RealmObjectBase.get<String>(this, 'latitude') as String;
  @override
  set latitude(String value) => throw RealmUnsupportedSetError();

  @override
  String get longitude =>
      RealmObjectBase.get<String>(this, 'longitude') as String;
  @override
  set longitude(String value) => throw RealmUnsupportedSetError();

  @override
  RealmList<String> get tags =>
      RealmObjectBase.get<String>(this, 'tags') as RealmList<String>;
  @override
  set tags(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<int> get range =>
      RealmObjectBase.get<int>(this, 'range') as RealmList<int>;
  @override
  set range(covariant RealmList<int> value) => throw RealmUnsupportedSetError();

  @override
  RealmList<RealmFriend> get friends =>
      RealmObjectBase.get<RealmFriend>(this, 'friends')
          as RealmList<RealmFriend>;
  @override
  set friends(covariant RealmList<RealmFriend> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get greeting =>
      RealmObjectBase.get<String>(this, 'greeting') as String;
  @override
  set greeting(String value) => throw RealmUnsupportedSetError();

  @override
  String get favoriteFruit =>
      RealmObjectBase.get<String>(this, 'favoriteFruit') as String;
  @override
  set favoriteFruit(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RealmDoc>> get changes =>
      RealmObjectBase.getChanges<RealmDoc>(this);

  @override
  RealmDoc freeze() => RealmObjectBase.freezeObject<RealmDoc>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmDoc._);
    return const SchemaObject(ObjectType.realmObject, RealmDoc, 'RealmDoc', [
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

class RealmName extends _RealmName
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmName(
    String first,
    String last,
  ) {
    RealmObjectBase.set(this, 'first', first);
    RealmObjectBase.set(this, 'last', last);
  }

  RealmName._();

  @override
  String get first => RealmObjectBase.get<String>(this, 'first') as String;
  @override
  set first(String value) => throw RealmUnsupportedSetError();

  @override
  String get last => RealmObjectBase.get<String>(this, 'last') as String;
  @override
  set last(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RealmName>> get changes =>
      RealmObjectBase.getChanges<RealmName>(this);

  @override
  RealmName freeze() => RealmObjectBase.freezeObject<RealmName>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmName._);
    return const SchemaObject(ObjectType.realmObject, RealmName, 'RealmName', [
      SchemaProperty('first', RealmPropertyType.string),
      SchemaProperty('last', RealmPropertyType.string),
    ]);
  }
}

class RealmFriend extends _RealmFriend
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmFriend(
    int id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  RealmFriend._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<RealmFriend>> get changes =>
      RealmObjectBase.getChanges<RealmFriend>(this);

  @override
  RealmFriend freeze() => RealmObjectBase.freezeObject<RealmFriend>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmFriend._);
    return const SchemaObject(
        ObjectType.realmObject, RealmFriend, 'RealmFriend', [
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

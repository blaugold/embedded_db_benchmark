// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_document.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetIsarDocCollection on Isar {
  IsarCollection<IsarDoc> get isarDocs {
    return getCollection('IsarDoc');
  }
}

final IsarDocSchema = CollectionSchema(
  name: 'IsarDoc',
  schema:
      '{"name":"IsarDoc","idName":"dbId","properties":[{"name":"about","type":"String"},{"name":"address","type":"String"},{"name":"age","type":"Long"},{"name":"balance","type":"String"},{"name":"company","type":"String"},{"name":"email","type":"String"},{"name":"eyeColor","type":"String"},{"name":"favoriteFruit","type":"String"},{"name":"greeting","type":"String"},{"name":"guid","type":"String"},{"name":"id","type":"String"},{"name":"index","type":"Long"},{"name":"isActive","type":"Bool"},{"name":"latitude","type":"String"},{"name":"longitude","type":"String"},{"name":"phone","type":"String"},{"name":"picture","type":"String"},{"name":"range","type":"LongList"},{"name":"registered","type":"String"},{"name":"tags","type":"StringList"}],"indexes":[{"name":"id","unique":false,"properties":[{"name":"id","type":"Hash","caseSensitive":true}]}],"links":[{"name":"friends","target":"IsarFriend"},{"name":"name","target":"IsarName"}]}',
  nativeAdapter: const _IsarDocNativeAdapter(),
  webAdapter: const _IsarDocWebAdapter(),
  idName: 'dbId',
  propertyIds: {
    'about': 0,
    'address': 1,
    'age': 2,
    'balance': 3,
    'company': 4,
    'email': 5,
    'eyeColor': 6,
    'favoriteFruit': 7,
    'greeting': 8,
    'guid': 9,
    'id': 10,
    'index': 11,
    'isActive': 12,
    'latitude': 13,
    'longitude': 14,
    'phone': 15,
    'picture': 16,
    'range': 17,
    'registered': 18,
    'tags': 19
  },
  listProperties: {'range', 'tags'},
  indexIds: {'id': 0},
  indexTypes: {
    'id': [
      NativeIndexType.stringHash,
    ]
  },
  linkIds: {'friends': 0, 'name': 1},
  backlinkIds: {},
  linkedCollections: ['IsarFriend', 'IsarName'],
  getId: (obj) {
    if (obj.dbId == Isar.autoIncrement) {
      return null;
    } else {
      return obj.dbId;
    }
  },
  setId: (obj, id) => obj.dbId = id,
  getLinks: (obj) => [obj.friends, obj.name],
  version: 2,
);

class _IsarDocWebAdapter extends IsarWebTypeAdapter<IsarDoc> {
  const _IsarDocWebAdapter();

  @override
  Object serialize(IsarCollection<IsarDoc> collection, IsarDoc object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'about', object.about);
    IsarNative.jsObjectSet(jsObj, 'address', object.address);
    IsarNative.jsObjectSet(jsObj, 'age', object.age);
    IsarNative.jsObjectSet(jsObj, 'balance', object.balance);
    IsarNative.jsObjectSet(jsObj, 'company', object.company);
    IsarNative.jsObjectSet(jsObj, 'dbId', object.dbId);
    IsarNative.jsObjectSet(jsObj, 'email', object.email);
    IsarNative.jsObjectSet(jsObj, 'eyeColor', object.eyeColor);
    IsarNative.jsObjectSet(jsObj, 'favoriteFruit', object.favoriteFruit);
    IsarNative.jsObjectSet(jsObj, 'greeting', object.greeting);
    IsarNative.jsObjectSet(jsObj, 'guid', object.guid);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'index', object.index);
    IsarNative.jsObjectSet(jsObj, 'isActive', object.isActive);
    IsarNative.jsObjectSet(jsObj, 'latitude', object.latitude);
    IsarNative.jsObjectSet(jsObj, 'longitude', object.longitude);
    IsarNative.jsObjectSet(jsObj, 'phone', object.phone);
    IsarNative.jsObjectSet(jsObj, 'picture', object.picture);
    IsarNative.jsObjectSet(jsObj, 'range', object.range);
    IsarNative.jsObjectSet(jsObj, 'registered', object.registered);
    IsarNative.jsObjectSet(jsObj, 'tags', object.tags);
    return jsObj;
  }

  @override
  IsarDoc deserialize(IsarCollection<IsarDoc> collection, dynamic jsObj) {
    final object = IsarDoc();
    object.about = IsarNative.jsObjectGet(jsObj, 'about') ?? '';
    object.address = IsarNative.jsObjectGet(jsObj, 'address') ?? '';
    object.age =
        IsarNative.jsObjectGet(jsObj, 'age') ?? double.negativeInfinity;
    object.balance = IsarNative.jsObjectGet(jsObj, 'balance') ?? '';
    object.company = IsarNative.jsObjectGet(jsObj, 'company') ?? '';
    object.dbId =
        IsarNative.jsObjectGet(jsObj, 'dbId') ?? double.negativeInfinity;
    object.email = IsarNative.jsObjectGet(jsObj, 'email') ?? '';
    object.eyeColor = IsarNative.jsObjectGet(jsObj, 'eyeColor') ?? '';
    object.favoriteFruit = IsarNative.jsObjectGet(jsObj, 'favoriteFruit') ?? '';
    object.greeting = IsarNative.jsObjectGet(jsObj, 'greeting') ?? '';
    object.guid = IsarNative.jsObjectGet(jsObj, 'guid') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? '';
    object.index =
        IsarNative.jsObjectGet(jsObj, 'index') ?? double.negativeInfinity;
    object.isActive = IsarNative.jsObjectGet(jsObj, 'isActive') ?? false;
    object.latitude = IsarNative.jsObjectGet(jsObj, 'latitude') ?? '';
    object.longitude = IsarNative.jsObjectGet(jsObj, 'longitude') ?? '';
    object.phone = IsarNative.jsObjectGet(jsObj, 'phone') ?? '';
    object.picture = IsarNative.jsObjectGet(jsObj, 'picture') ?? '';
    object.range = (IsarNative.jsObjectGet(jsObj, 'range') as List?)
            ?.map((e) => e ?? double.negativeInfinity)
            .toList()
            .cast<int>() ??
        [];
    object.registered = IsarNative.jsObjectGet(jsObj, 'registered') ?? '';
    object.tags = (IsarNative.jsObjectGet(jsObj, 'tags') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>() ??
        [];
    attachLinks(
        collection.isar,
        IsarNative.jsObjectGet(jsObj, 'dbId') ?? double.negativeInfinity,
        object);
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'about':
        return (IsarNative.jsObjectGet(jsObj, 'about') ?? '') as P;
      case 'address':
        return (IsarNative.jsObjectGet(jsObj, 'address') ?? '') as P;
      case 'age':
        return (IsarNative.jsObjectGet(jsObj, 'age') ?? double.negativeInfinity)
            as P;
      case 'balance':
        return (IsarNative.jsObjectGet(jsObj, 'balance') ?? '') as P;
      case 'company':
        return (IsarNative.jsObjectGet(jsObj, 'company') ?? '') as P;
      case 'dbId':
        return (IsarNative.jsObjectGet(jsObj, 'dbId') ??
            double.negativeInfinity) as P;
      case 'email':
        return (IsarNative.jsObjectGet(jsObj, 'email') ?? '') as P;
      case 'eyeColor':
        return (IsarNative.jsObjectGet(jsObj, 'eyeColor') ?? '') as P;
      case 'favoriteFruit':
        return (IsarNative.jsObjectGet(jsObj, 'favoriteFruit') ?? '') as P;
      case 'greeting':
        return (IsarNative.jsObjectGet(jsObj, 'greeting') ?? '') as P;
      case 'guid':
        return (IsarNative.jsObjectGet(jsObj, 'guid') ?? '') as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? '') as P;
      case 'index':
        return (IsarNative.jsObjectGet(jsObj, 'index') ??
            double.negativeInfinity) as P;
      case 'isActive':
        return (IsarNative.jsObjectGet(jsObj, 'isActive') ?? false) as P;
      case 'latitude':
        return (IsarNative.jsObjectGet(jsObj, 'latitude') ?? '') as P;
      case 'longitude':
        return (IsarNative.jsObjectGet(jsObj, 'longitude') ?? '') as P;
      case 'phone':
        return (IsarNative.jsObjectGet(jsObj, 'phone') ?? '') as P;
      case 'picture':
        return (IsarNative.jsObjectGet(jsObj, 'picture') ?? '') as P;
      case 'range':
        return ((IsarNative.jsObjectGet(jsObj, 'range') as List?)
                ?.map((e) => e ?? double.negativeInfinity)
                .toList()
                .cast<int>() ??
            []) as P;
      case 'registered':
        return (IsarNative.jsObjectGet(jsObj, 'registered') ?? '') as P;
      case 'tags':
        return ((IsarNative.jsObjectGet(jsObj, 'tags') as List?)
                ?.map((e) => e ?? '')
                .toList()
                .cast<String>() ??
            []) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, IsarDoc object) {
    object.friends.attach(
      id,
      isar.isarDocs,
      isar.getCollection<IsarFriend>('IsarFriend'),
      'friends',
      false,
    );
    object.name.attach(
      id,
      isar.isarDocs,
      isar.getCollection<IsarName>('IsarName'),
      'name',
      false,
    );
  }
}

class _IsarDocNativeAdapter extends IsarNativeTypeAdapter<IsarDoc> {
  const _IsarDocNativeAdapter();

  @override
  void serialize(IsarCollection<IsarDoc> collection, IsarRawObject rawObj,
      IsarDoc object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.about;
    final _about = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_about.length) as int;
    final value1 = object.address;
    final _address = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_address.length) as int;
    final value2 = object.age;
    final _age = value2;
    final value3 = object.balance;
    final _balance = IsarBinaryWriter.utf8Encoder.convert(value3);
    dynamicSize += (_balance.length) as int;
    final value4 = object.company;
    final _company = IsarBinaryWriter.utf8Encoder.convert(value4);
    dynamicSize += (_company.length) as int;
    final value5 = object.email;
    final _email = IsarBinaryWriter.utf8Encoder.convert(value5);
    dynamicSize += (_email.length) as int;
    final value6 = object.eyeColor;
    final _eyeColor = IsarBinaryWriter.utf8Encoder.convert(value6);
    dynamicSize += (_eyeColor.length) as int;
    final value7 = object.favoriteFruit;
    final _favoriteFruit = IsarBinaryWriter.utf8Encoder.convert(value7);
    dynamicSize += (_favoriteFruit.length) as int;
    final value8 = object.greeting;
    final _greeting = IsarBinaryWriter.utf8Encoder.convert(value8);
    dynamicSize += (_greeting.length) as int;
    final value9 = object.guid;
    final _guid = IsarBinaryWriter.utf8Encoder.convert(value9);
    dynamicSize += (_guid.length) as int;
    final value10 = object.id;
    final _id = IsarBinaryWriter.utf8Encoder.convert(value10);
    dynamicSize += (_id.length) as int;
    final value11 = object.index;
    final _index = value11;
    final value12 = object.isActive;
    final _isActive = value12;
    final value13 = object.latitude;
    final _latitude = IsarBinaryWriter.utf8Encoder.convert(value13);
    dynamicSize += (_latitude.length) as int;
    final value14 = object.longitude;
    final _longitude = IsarBinaryWriter.utf8Encoder.convert(value14);
    dynamicSize += (_longitude.length) as int;
    final value15 = object.phone;
    final _phone = IsarBinaryWriter.utf8Encoder.convert(value15);
    dynamicSize += (_phone.length) as int;
    final value16 = object.picture;
    final _picture = IsarBinaryWriter.utf8Encoder.convert(value16);
    dynamicSize += (_picture.length) as int;
    final value17 = object.range;
    dynamicSize += (value17.length) * 8;
    final _range = value17;
    final value18 = object.registered;
    final _registered = IsarBinaryWriter.utf8Encoder.convert(value18);
    dynamicSize += (_registered.length) as int;
    final value19 = object.tags;
    dynamicSize += (value19.length) * 8;
    final bytesList19 = <IsarUint8List>[];
    for (var str in value19) {
      final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
      bytesList19.add(bytes);
      dynamicSize += bytes.length as int;
    }
    final _tags = bytesList19;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _about);
    writer.writeBytes(offsets[1], _address);
    writer.writeLong(offsets[2], _age);
    writer.writeBytes(offsets[3], _balance);
    writer.writeBytes(offsets[4], _company);
    writer.writeBytes(offsets[5], _email);
    writer.writeBytes(offsets[6], _eyeColor);
    writer.writeBytes(offsets[7], _favoriteFruit);
    writer.writeBytes(offsets[8], _greeting);
    writer.writeBytes(offsets[9], _guid);
    writer.writeBytes(offsets[10], _id);
    writer.writeLong(offsets[11], _index);
    writer.writeBool(offsets[12], _isActive);
    writer.writeBytes(offsets[13], _latitude);
    writer.writeBytes(offsets[14], _longitude);
    writer.writeBytes(offsets[15], _phone);
    writer.writeBytes(offsets[16], _picture);
    writer.writeLongList(offsets[17], _range);
    writer.writeBytes(offsets[18], _registered);
    writer.writeStringList(offsets[19], _tags);
  }

  @override
  IsarDoc deserialize(IsarCollection<IsarDoc> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = IsarDoc();
    object.about = reader.readString(offsets[0]);
    object.address = reader.readString(offsets[1]);
    object.age = reader.readLong(offsets[2]);
    object.balance = reader.readString(offsets[3]);
    object.company = reader.readString(offsets[4]);
    object.dbId = id;
    object.email = reader.readString(offsets[5]);
    object.eyeColor = reader.readString(offsets[6]);
    object.favoriteFruit = reader.readString(offsets[7]);
    object.greeting = reader.readString(offsets[8]);
    object.guid = reader.readString(offsets[9]);
    object.id = reader.readString(offsets[10]);
    object.index = reader.readLong(offsets[11]);
    object.isActive = reader.readBool(offsets[12]);
    object.latitude = reader.readString(offsets[13]);
    object.longitude = reader.readString(offsets[14]);
    object.phone = reader.readString(offsets[15]);
    object.picture = reader.readString(offsets[16]);
    object.range = reader.readLongList(offsets[17]) ?? [];
    object.registered = reader.readString(offsets[18]);
    object.tags = reader.readStringList(offsets[19]) ?? [];
    attachLinks(collection.isar, id, object);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readString(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      case 2:
        return (reader.readLong(offset)) as P;
      case 3:
        return (reader.readString(offset)) as P;
      case 4:
        return (reader.readString(offset)) as P;
      case 5:
        return (reader.readString(offset)) as P;
      case 6:
        return (reader.readString(offset)) as P;
      case 7:
        return (reader.readString(offset)) as P;
      case 8:
        return (reader.readString(offset)) as P;
      case 9:
        return (reader.readString(offset)) as P;
      case 10:
        return (reader.readString(offset)) as P;
      case 11:
        return (reader.readLong(offset)) as P;
      case 12:
        return (reader.readBool(offset)) as P;
      case 13:
        return (reader.readString(offset)) as P;
      case 14:
        return (reader.readString(offset)) as P;
      case 15:
        return (reader.readString(offset)) as P;
      case 16:
        return (reader.readString(offset)) as P;
      case 17:
        return (reader.readLongList(offset) ?? []) as P;
      case 18:
        return (reader.readString(offset)) as P;
      case 19:
        return (reader.readStringList(offset) ?? []) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, IsarDoc object) {
    object.friends.attach(
      id,
      isar.isarDocs,
      isar.getCollection<IsarFriend>('IsarFriend'),
      'friends',
      false,
    );
    object.name.attach(
      id,
      isar.isarDocs,
      isar.getCollection<IsarName>('IsarName'),
      'name',
      false,
    );
  }
}

extension IsarDocQueryWhereSort on QueryBuilder<IsarDoc, IsarDoc, QWhere> {
  QueryBuilder<IsarDoc, IsarDoc, QAfterWhere> anyDbId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: 'id'));
  }
}

extension IsarDocQueryWhere on QueryBuilder<IsarDoc, IsarDoc, QWhereClause> {
  QueryBuilder<IsarDoc, IsarDoc, QAfterWhereClause> dbIdEqualTo(int dbId) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [dbId],
      includeLower: true,
      upper: [dbId],
      includeUpper: true,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterWhereClause> dbIdNotEqualTo(int dbId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [dbId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [dbId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [dbId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [dbId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterWhereClause> dbIdGreaterThan(
    int dbId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [dbId],
      includeLower: include,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterWhereClause> dbIdLessThan(
    int dbId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [dbId],
      includeUpper: include,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterWhereClause> dbIdBetween(
    int lowerDbId,
    int upperDbId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerDbId],
      includeLower: includeLower,
      upper: [upperDbId],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterWhereClause> idEqualTo(String id) {
    return addWhereClauseInternal(WhereClause(
      indexName: 'id',
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterWhereClause> idNotEqualTo(String id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: 'id',
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: 'id',
        upper: [id],
        includeUpper: false,
      ));
    }
  }
}

extension IsarDocQueryFilter
    on QueryBuilder<IsarDoc, IsarDoc, QFilterCondition> {
  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> aboutEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'about',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> aboutGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'about',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> aboutLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'about',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> aboutBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'about',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> aboutStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'about',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> aboutEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'about',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> aboutContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'about',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> aboutMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'about',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> addressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> addressGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> addressLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> addressBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'address',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> addressContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'address',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> addressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'address',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> ageEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'age',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> ageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'age',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> ageLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'age',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> ageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'age',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> balanceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'balance',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> balanceGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'balance',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> balanceLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'balance',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> balanceBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'balance',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> balanceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'balance',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> balanceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'balance',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> balanceContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'balance',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> balanceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'balance',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> companyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'company',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> companyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'company',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> companyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'company',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> companyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'company',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> companyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'company',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> companyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'company',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> companyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'company',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> companyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'company',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> dbIdEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'dbId',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> dbIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'dbId',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> dbIdLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'dbId',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> dbIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'dbId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> emailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> emailGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> emailLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> emailBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'email',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'email',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'email',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> eyeColorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'eyeColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> eyeColorGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'eyeColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> eyeColorLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'eyeColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> eyeColorBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'eyeColor',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> eyeColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'eyeColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> eyeColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'eyeColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> eyeColorContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'eyeColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> eyeColorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'eyeColor',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> favoriteFruitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'favoriteFruit',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition>
      favoriteFruitGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'favoriteFruit',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> favoriteFruitLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'favoriteFruit',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> favoriteFruitBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'favoriteFruit',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> favoriteFruitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'favoriteFruit',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> favoriteFruitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'favoriteFruit',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> favoriteFruitContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'favoriteFruit',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> favoriteFruitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'favoriteFruit',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> greetingEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'greeting',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> greetingGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'greeting',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> greetingLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'greeting',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> greetingBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'greeting',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> greetingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'greeting',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> greetingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'greeting',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> greetingContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'greeting',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> greetingMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'greeting',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> guidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'guid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> guidGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'guid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> guidLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'guid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> guidBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'guid',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> guidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'guid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> guidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'guid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> guidContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'guid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> guidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'guid',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> idLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'id',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'id',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> indexEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'index',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> indexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'index',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> indexLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'index',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> indexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'index',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> isActiveEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isActive',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> latitudeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'latitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> latitudeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'latitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> latitudeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'latitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> latitudeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'latitude',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> latitudeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'latitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> latitudeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'latitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> latitudeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'latitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> latitudeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'latitude',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> longitudeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'longitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> longitudeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'longitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> longitudeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'longitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> longitudeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'longitude',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> longitudeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'longitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> longitudeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'longitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> longitudeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'longitude',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> longitudeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'longitude',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> phoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'phone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> phoneGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'phone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> phoneLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'phone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> phoneBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'phone',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> phoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'phone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> phoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'phone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> phoneContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'phone',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> phoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'phone',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> pictureEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'picture',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> pictureGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'picture',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> pictureLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'picture',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> pictureBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'picture',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> pictureStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'picture',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> pictureEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'picture',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> pictureContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'picture',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> pictureMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'picture',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> rangeAnyEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'range',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> rangeAnyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'range',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> rangeAnyLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'range',
      value: value,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> rangeAnyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'range',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> registeredEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'registered',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> registeredGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'registered',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> registeredLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'registered',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> registeredBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'registered',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> registeredStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'registered',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> registeredEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'registered',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> registeredContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'registered',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> registeredMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'registered',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> tagsAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> tagsAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> tagsAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> tagsAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'tags',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> tagsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> tagsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> tagsAnyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'tags',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterFilterCondition> tagsAnyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'tags',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension IsarDocQueryWhereSortBy on QueryBuilder<IsarDoc, IsarDoc, QSortBy> {
  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByAbout() {
    return addSortByInternal('about', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByAboutDesc() {
    return addSortByInternal('about', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByAddress() {
    return addSortByInternal('address', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByAddressDesc() {
    return addSortByInternal('address', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByAge() {
    return addSortByInternal('age', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByAgeDesc() {
    return addSortByInternal('age', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByBalance() {
    return addSortByInternal('balance', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByBalanceDesc() {
    return addSortByInternal('balance', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByCompany() {
    return addSortByInternal('company', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByCompanyDesc() {
    return addSortByInternal('company', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByDbId() {
    return addSortByInternal('dbId', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByDbIdDesc() {
    return addSortByInternal('dbId', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByEmail() {
    return addSortByInternal('email', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByEmailDesc() {
    return addSortByInternal('email', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByEyeColor() {
    return addSortByInternal('eyeColor', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByEyeColorDesc() {
    return addSortByInternal('eyeColor', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByFavoriteFruit() {
    return addSortByInternal('favoriteFruit', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByFavoriteFruitDesc() {
    return addSortByInternal('favoriteFruit', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByGreeting() {
    return addSortByInternal('greeting', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByGreetingDesc() {
    return addSortByInternal('greeting', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByGuid() {
    return addSortByInternal('guid', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByGuidDesc() {
    return addSortByInternal('guid', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByIndex() {
    return addSortByInternal('index', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByIndexDesc() {
    return addSortByInternal('index', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByIsActive() {
    return addSortByInternal('isActive', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByIsActiveDesc() {
    return addSortByInternal('isActive', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByLatitude() {
    return addSortByInternal('latitude', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByLatitudeDesc() {
    return addSortByInternal('latitude', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByLongitude() {
    return addSortByInternal('longitude', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByLongitudeDesc() {
    return addSortByInternal('longitude', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByPhone() {
    return addSortByInternal('phone', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByPhoneDesc() {
    return addSortByInternal('phone', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByPicture() {
    return addSortByInternal('picture', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByPictureDesc() {
    return addSortByInternal('picture', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByRegistered() {
    return addSortByInternal('registered', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> sortByRegisteredDesc() {
    return addSortByInternal('registered', Sort.desc);
  }
}

extension IsarDocQueryWhereSortThenBy
    on QueryBuilder<IsarDoc, IsarDoc, QSortThenBy> {
  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByAbout() {
    return addSortByInternal('about', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByAboutDesc() {
    return addSortByInternal('about', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByAddress() {
    return addSortByInternal('address', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByAddressDesc() {
    return addSortByInternal('address', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByAge() {
    return addSortByInternal('age', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByAgeDesc() {
    return addSortByInternal('age', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByBalance() {
    return addSortByInternal('balance', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByBalanceDesc() {
    return addSortByInternal('balance', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByCompany() {
    return addSortByInternal('company', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByCompanyDesc() {
    return addSortByInternal('company', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByDbId() {
    return addSortByInternal('dbId', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByDbIdDesc() {
    return addSortByInternal('dbId', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByEmail() {
    return addSortByInternal('email', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByEmailDesc() {
    return addSortByInternal('email', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByEyeColor() {
    return addSortByInternal('eyeColor', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByEyeColorDesc() {
    return addSortByInternal('eyeColor', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByFavoriteFruit() {
    return addSortByInternal('favoriteFruit', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByFavoriteFruitDesc() {
    return addSortByInternal('favoriteFruit', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByGreeting() {
    return addSortByInternal('greeting', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByGreetingDesc() {
    return addSortByInternal('greeting', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByGuid() {
    return addSortByInternal('guid', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByGuidDesc() {
    return addSortByInternal('guid', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByIndex() {
    return addSortByInternal('index', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByIndexDesc() {
    return addSortByInternal('index', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByIsActive() {
    return addSortByInternal('isActive', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByIsActiveDesc() {
    return addSortByInternal('isActive', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByLatitude() {
    return addSortByInternal('latitude', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByLatitudeDesc() {
    return addSortByInternal('latitude', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByLongitude() {
    return addSortByInternal('longitude', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByLongitudeDesc() {
    return addSortByInternal('longitude', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByPhone() {
    return addSortByInternal('phone', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByPhoneDesc() {
    return addSortByInternal('phone', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByPicture() {
    return addSortByInternal('picture', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByPictureDesc() {
    return addSortByInternal('picture', Sort.desc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByRegistered() {
    return addSortByInternal('registered', Sort.asc);
  }

  QueryBuilder<IsarDoc, IsarDoc, QAfterSortBy> thenByRegisteredDesc() {
    return addSortByInternal('registered', Sort.desc);
  }
}

extension IsarDocQueryWhereDistinct
    on QueryBuilder<IsarDoc, IsarDoc, QDistinct> {
  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByAbout(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('about', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('address', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByAge() {
    return addDistinctByInternal('age');
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByBalance(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('balance', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByCompany(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('company', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByDbId() {
    return addDistinctByInternal('dbId');
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('email', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByEyeColor(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('eyeColor', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByFavoriteFruit(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('favoriteFruit', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByGreeting(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('greeting', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByGuid(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('guid', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('id', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByIndex() {
    return addDistinctByInternal('index');
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByIsActive() {
    return addDistinctByInternal('isActive');
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByLatitude(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('latitude', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByLongitude(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('longitude', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByPhone(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('phone', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByPicture(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('picture', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarDoc, IsarDoc, QDistinct> distinctByRegistered(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('registered', caseSensitive: caseSensitive);
  }
}

extension IsarDocQueryProperty
    on QueryBuilder<IsarDoc, IsarDoc, QQueryProperty> {
  QueryBuilder<IsarDoc, String, QQueryOperations> aboutProperty() {
    return addPropertyNameInternal('about');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> addressProperty() {
    return addPropertyNameInternal('address');
  }

  QueryBuilder<IsarDoc, int, QQueryOperations> ageProperty() {
    return addPropertyNameInternal('age');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> balanceProperty() {
    return addPropertyNameInternal('balance');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> companyProperty() {
    return addPropertyNameInternal('company');
  }

  QueryBuilder<IsarDoc, int, QQueryOperations> dbIdProperty() {
    return addPropertyNameInternal('dbId');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> emailProperty() {
    return addPropertyNameInternal('email');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> eyeColorProperty() {
    return addPropertyNameInternal('eyeColor');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> favoriteFruitProperty() {
    return addPropertyNameInternal('favoriteFruit');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> greetingProperty() {
    return addPropertyNameInternal('greeting');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> guidProperty() {
    return addPropertyNameInternal('guid');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<IsarDoc, int, QQueryOperations> indexProperty() {
    return addPropertyNameInternal('index');
  }

  QueryBuilder<IsarDoc, bool, QQueryOperations> isActiveProperty() {
    return addPropertyNameInternal('isActive');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> latitudeProperty() {
    return addPropertyNameInternal('latitude');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> longitudeProperty() {
    return addPropertyNameInternal('longitude');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> phoneProperty() {
    return addPropertyNameInternal('phone');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> pictureProperty() {
    return addPropertyNameInternal('picture');
  }

  QueryBuilder<IsarDoc, List<int>, QQueryOperations> rangeProperty() {
    return addPropertyNameInternal('range');
  }

  QueryBuilder<IsarDoc, String, QQueryOperations> registeredProperty() {
    return addPropertyNameInternal('registered');
  }

  QueryBuilder<IsarDoc, List<String>, QQueryOperations> tagsProperty() {
    return addPropertyNameInternal('tags');
  }
}

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetIsarNameCollection on Isar {
  IsarCollection<IsarName> get isarNames {
    return getCollection('IsarName');
  }
}

final IsarNameSchema = CollectionSchema(
  name: 'IsarName',
  schema:
      '{"name":"IsarName","idName":"dbId","properties":[{"name":"first","type":"String"},{"name":"last","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _IsarNameNativeAdapter(),
  webAdapter: const _IsarNameWebAdapter(),
  idName: 'dbId',
  propertyIds: {'first': 0, 'last': 1},
  listProperties: {},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.dbId == Isar.autoIncrement) {
      return null;
    } else {
      return obj.dbId;
    }
  },
  setId: (obj, id) => obj.dbId = id,
  getLinks: (obj) => [],
  version: 2,
);

class _IsarNameWebAdapter extends IsarWebTypeAdapter<IsarName> {
  const _IsarNameWebAdapter();

  @override
  Object serialize(IsarCollection<IsarName> collection, IsarName object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'dbId', object.dbId);
    IsarNative.jsObjectSet(jsObj, 'first', object.first);
    IsarNative.jsObjectSet(jsObj, 'last', object.last);
    return jsObj;
  }

  @override
  IsarName deserialize(IsarCollection<IsarName> collection, dynamic jsObj) {
    final object = IsarName();
    object.dbId =
        IsarNative.jsObjectGet(jsObj, 'dbId') ?? double.negativeInfinity;
    object.first = IsarNative.jsObjectGet(jsObj, 'first') ?? '';
    object.last = IsarNative.jsObjectGet(jsObj, 'last') ?? '';
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'dbId':
        return (IsarNative.jsObjectGet(jsObj, 'dbId') ??
            double.negativeInfinity) as P;
      case 'first':
        return (IsarNative.jsObjectGet(jsObj, 'first') ?? '') as P;
      case 'last':
        return (IsarNative.jsObjectGet(jsObj, 'last') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, IsarName object) {}
}

class _IsarNameNativeAdapter extends IsarNativeTypeAdapter<IsarName> {
  const _IsarNameNativeAdapter();

  @override
  void serialize(IsarCollection<IsarName> collection, IsarRawObject rawObj,
      IsarName object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.first;
    final _first = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_first.length) as int;
    final value1 = object.last;
    final _last = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_last.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _first);
    writer.writeBytes(offsets[1], _last);
  }

  @override
  IsarName deserialize(IsarCollection<IsarName> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = IsarName();
    object.dbId = id;
    object.first = reader.readString(offsets[0]);
    object.last = reader.readString(offsets[1]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readString(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, IsarName object) {}
}

extension IsarNameQueryWhereSort on QueryBuilder<IsarName, IsarName, QWhere> {
  QueryBuilder<IsarName, IsarName, QAfterWhere> anyDbId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension IsarNameQueryWhere on QueryBuilder<IsarName, IsarName, QWhereClause> {
  QueryBuilder<IsarName, IsarName, QAfterWhereClause> dbIdEqualTo(int dbId) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [dbId],
      includeLower: true,
      upper: [dbId],
      includeUpper: true,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterWhereClause> dbIdNotEqualTo(int dbId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [dbId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [dbId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [dbId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [dbId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<IsarName, IsarName, QAfterWhereClause> dbIdGreaterThan(
    int dbId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [dbId],
      includeLower: include,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterWhereClause> dbIdLessThan(
    int dbId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [dbId],
      includeUpper: include,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterWhereClause> dbIdBetween(
    int lowerDbId,
    int upperDbId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerDbId],
      includeLower: includeLower,
      upper: [upperDbId],
      includeUpper: includeUpper,
    ));
  }
}

extension IsarNameQueryFilter
    on QueryBuilder<IsarName, IsarName, QFilterCondition> {
  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> dbIdEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'dbId',
      value: value,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> dbIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'dbId',
      value: value,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> dbIdLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'dbId',
      value: value,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> dbIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'dbId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> firstEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'first',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> firstGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'first',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> firstLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'first',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> firstBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'first',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> firstStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'first',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> firstEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'first',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> firstContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'first',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> firstMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'first',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> lastEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'last',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> lastGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'last',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> lastLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'last',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> lastBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'last',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> lastStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'last',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> lastEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'last',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> lastContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'last',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarName, IsarName, QAfterFilterCondition> lastMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'last',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension IsarNameQueryWhereSortBy
    on QueryBuilder<IsarName, IsarName, QSortBy> {
  QueryBuilder<IsarName, IsarName, QAfterSortBy> sortByDbId() {
    return addSortByInternal('dbId', Sort.asc);
  }

  QueryBuilder<IsarName, IsarName, QAfterSortBy> sortByDbIdDesc() {
    return addSortByInternal('dbId', Sort.desc);
  }

  QueryBuilder<IsarName, IsarName, QAfterSortBy> sortByFirst() {
    return addSortByInternal('first', Sort.asc);
  }

  QueryBuilder<IsarName, IsarName, QAfterSortBy> sortByFirstDesc() {
    return addSortByInternal('first', Sort.desc);
  }

  QueryBuilder<IsarName, IsarName, QAfterSortBy> sortByLast() {
    return addSortByInternal('last', Sort.asc);
  }

  QueryBuilder<IsarName, IsarName, QAfterSortBy> sortByLastDesc() {
    return addSortByInternal('last', Sort.desc);
  }
}

extension IsarNameQueryWhereSortThenBy
    on QueryBuilder<IsarName, IsarName, QSortThenBy> {
  QueryBuilder<IsarName, IsarName, QAfterSortBy> thenByDbId() {
    return addSortByInternal('dbId', Sort.asc);
  }

  QueryBuilder<IsarName, IsarName, QAfterSortBy> thenByDbIdDesc() {
    return addSortByInternal('dbId', Sort.desc);
  }

  QueryBuilder<IsarName, IsarName, QAfterSortBy> thenByFirst() {
    return addSortByInternal('first', Sort.asc);
  }

  QueryBuilder<IsarName, IsarName, QAfterSortBy> thenByFirstDesc() {
    return addSortByInternal('first', Sort.desc);
  }

  QueryBuilder<IsarName, IsarName, QAfterSortBy> thenByLast() {
    return addSortByInternal('last', Sort.asc);
  }

  QueryBuilder<IsarName, IsarName, QAfterSortBy> thenByLastDesc() {
    return addSortByInternal('last', Sort.desc);
  }
}

extension IsarNameQueryWhereDistinct
    on QueryBuilder<IsarName, IsarName, QDistinct> {
  QueryBuilder<IsarName, IsarName, QDistinct> distinctByDbId() {
    return addDistinctByInternal('dbId');
  }

  QueryBuilder<IsarName, IsarName, QDistinct> distinctByFirst(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('first', caseSensitive: caseSensitive);
  }

  QueryBuilder<IsarName, IsarName, QDistinct> distinctByLast(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('last', caseSensitive: caseSensitive);
  }
}

extension IsarNameQueryProperty
    on QueryBuilder<IsarName, IsarName, QQueryProperty> {
  QueryBuilder<IsarName, int, QQueryOperations> dbIdProperty() {
    return addPropertyNameInternal('dbId');
  }

  QueryBuilder<IsarName, String, QQueryOperations> firstProperty() {
    return addPropertyNameInternal('first');
  }

  QueryBuilder<IsarName, String, QQueryOperations> lastProperty() {
    return addPropertyNameInternal('last');
  }
}

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetIsarFriendCollection on Isar {
  IsarCollection<IsarFriend> get isarFriends {
    return getCollection('IsarFriend');
  }
}

final IsarFriendSchema = CollectionSchema(
  name: 'IsarFriend',
  schema:
      '{"name":"IsarFriend","idName":"dbId","properties":[{"name":"id","type":"Long"},{"name":"name","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _IsarFriendNativeAdapter(),
  webAdapter: const _IsarFriendWebAdapter(),
  idName: 'dbId',
  propertyIds: {'id': 0, 'name': 1},
  listProperties: {},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.dbId == Isar.autoIncrement) {
      return null;
    } else {
      return obj.dbId;
    }
  },
  setId: (obj, id) => obj.dbId = id,
  getLinks: (obj) => [],
  version: 2,
);

class _IsarFriendWebAdapter extends IsarWebTypeAdapter<IsarFriend> {
  const _IsarFriendWebAdapter();

  @override
  Object serialize(IsarCollection<IsarFriend> collection, IsarFriend object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'dbId', object.dbId);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'name', object.name);
    return jsObj;
  }

  @override
  IsarFriend deserialize(IsarCollection<IsarFriend> collection, dynamic jsObj) {
    final object = IsarFriend();
    object.dbId =
        IsarNative.jsObjectGet(jsObj, 'dbId') ?? double.negativeInfinity;
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.name = IsarNative.jsObjectGet(jsObj, 'name') ?? '';
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'dbId':
        return (IsarNative.jsObjectGet(jsObj, 'dbId') ??
            double.negativeInfinity) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'name':
        return (IsarNative.jsObjectGet(jsObj, 'name') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, IsarFriend object) {}
}

class _IsarFriendNativeAdapter extends IsarNativeTypeAdapter<IsarFriend> {
  const _IsarFriendNativeAdapter();

  @override
  void serialize(
      IsarCollection<IsarFriend> collection,
      IsarRawObject rawObj,
      IsarFriend object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.id;
    final _id = value0;
    final value1 = object.name;
    final _name = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_name.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeLong(offsets[0], _id);
    writer.writeBytes(offsets[1], _name);
  }

  @override
  IsarFriend deserialize(IsarCollection<IsarFriend> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = IsarFriend();
    object.dbId = id;
    object.id = reader.readLong(offsets[0]);
    object.name = reader.readString(offsets[1]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readLong(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, IsarFriend object) {}
}

extension IsarFriendQueryWhereSort
    on QueryBuilder<IsarFriend, IsarFriend, QWhere> {
  QueryBuilder<IsarFriend, IsarFriend, QAfterWhere> anyDbId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension IsarFriendQueryWhere
    on QueryBuilder<IsarFriend, IsarFriend, QWhereClause> {
  QueryBuilder<IsarFriend, IsarFriend, QAfterWhereClause> dbIdEqualTo(
      int dbId) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [dbId],
      includeLower: true,
      upper: [dbId],
      includeUpper: true,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterWhereClause> dbIdNotEqualTo(
      int dbId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [dbId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [dbId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [dbId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [dbId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterWhereClause> dbIdGreaterThan(
    int dbId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [dbId],
      includeLower: include,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterWhereClause> dbIdLessThan(
    int dbId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [dbId],
      includeUpper: include,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterWhereClause> dbIdBetween(
    int lowerDbId,
    int upperDbId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerDbId],
      includeLower: includeLower,
      upper: [upperDbId],
      includeUpper: includeUpper,
    ));
  }
}

extension IsarFriendQueryFilter
    on QueryBuilder<IsarFriend, IsarFriend, QFilterCondition> {
  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> dbIdEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'dbId',
      value: value,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> dbIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'dbId',
      value: value,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> dbIdLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'dbId',
      value: value,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> dbIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'dbId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> nameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension IsarFriendQueryWhereSortBy
    on QueryBuilder<IsarFriend, IsarFriend, QSortBy> {
  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> sortByDbId() {
    return addSortByInternal('dbId', Sort.asc);
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> sortByDbIdDesc() {
    return addSortByInternal('dbId', Sort.desc);
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }
}

extension IsarFriendQueryWhereSortThenBy
    on QueryBuilder<IsarFriend, IsarFriend, QSortThenBy> {
  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> thenByDbId() {
    return addSortByInternal('dbId', Sort.asc);
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> thenByDbIdDesc() {
    return addSortByInternal('dbId', Sort.desc);
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<IsarFriend, IsarFriend, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }
}

extension IsarFriendQueryWhereDistinct
    on QueryBuilder<IsarFriend, IsarFriend, QDistinct> {
  QueryBuilder<IsarFriend, IsarFriend, QDistinct> distinctByDbId() {
    return addDistinctByInternal('dbId');
  }

  QueryBuilder<IsarFriend, IsarFriend, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<IsarFriend, IsarFriend, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }
}

extension IsarFriendQueryProperty
    on QueryBuilder<IsarFriend, IsarFriend, QQueryProperty> {
  QueryBuilder<IsarFriend, int, QQueryOperations> dbIdProperty() {
    return addPropertyNameInternal('dbId');
  }

  QueryBuilder<IsarFriend, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<IsarFriend, String, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }
}

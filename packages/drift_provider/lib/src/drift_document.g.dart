// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_document.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DriftDocsCompanion extends UpdateCompanion<DriftDoc> {
  final Value<int> id;
  final Value<int> index;
  final Value<String> guid;
  final Value<bool> isActive;
  final Value<String> balance;
  final Value<String> picture;
  final Value<int> age;
  final Value<String> eyeColor;
  final Value<String> company;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> address;
  final Value<String> about;
  final Value<String> registered;
  final Value<String> latitude;
  final Value<String> longitude;
  final Value<List<String>> tags;
  final Value<List<int>> range;
  final Value<String> greeting;
  final Value<String> favoriteFruit;
  const DriftDocsCompanion({
    this.id = const Value.absent(),
    this.index = const Value.absent(),
    this.guid = const Value.absent(),
    this.isActive = const Value.absent(),
    this.balance = const Value.absent(),
    this.picture = const Value.absent(),
    this.age = const Value.absent(),
    this.eyeColor = const Value.absent(),
    this.company = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.about = const Value.absent(),
    this.registered = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.tags = const Value.absent(),
    this.range = const Value.absent(),
    this.greeting = const Value.absent(),
    this.favoriteFruit = const Value.absent(),
  });
  DriftDocsCompanion.insert({
    this.id = const Value.absent(),
    required int index,
    required String guid,
    required bool isActive,
    required String balance,
    required String picture,
    required int age,
    required String eyeColor,
    required String company,
    required String email,
    required String phone,
    required String address,
    required String about,
    required String registered,
    required String latitude,
    required String longitude,
    required List<String> tags,
    required List<int> range,
    required String greeting,
    required String favoriteFruit,
  })  : index = Value(index),
        guid = Value(guid),
        isActive = Value(isActive),
        balance = Value(balance),
        picture = Value(picture),
        age = Value(age),
        eyeColor = Value(eyeColor),
        company = Value(company),
        email = Value(email),
        phone = Value(phone),
        address = Value(address),
        about = Value(about),
        registered = Value(registered),
        latitude = Value(latitude),
        longitude = Value(longitude),
        tags = Value(tags),
        range = Value(range),
        greeting = Value(greeting),
        favoriteFruit = Value(favoriteFruit);
  static Insertable<DriftDoc> custom({
    Expression<int>? id,
    Expression<int>? index,
    Expression<String>? guid,
    Expression<bool>? isActive,
    Expression<String>? balance,
    Expression<String>? picture,
    Expression<int>? age,
    Expression<String>? eyeColor,
    Expression<String>? company,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? about,
    Expression<String>? registered,
    Expression<String>? latitude,
    Expression<String>? longitude,
    Expression<List<String>>? tags,
    Expression<List<int>>? range,
    Expression<String>? greeting,
    Expression<String>? favoriteFruit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (index != null) 'index': index,
      if (guid != null) 'guid': guid,
      if (isActive != null) 'is_active': isActive,
      if (balance != null) 'balance': balance,
      if (picture != null) 'picture': picture,
      if (age != null) 'age': age,
      if (eyeColor != null) 'eye_color': eyeColor,
      if (company != null) 'company': company,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (about != null) 'about': about,
      if (registered != null) 'registered': registered,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (tags != null) 'tags': tags,
      if (range != null) 'range': range,
      if (greeting != null) 'greeting': greeting,
      if (favoriteFruit != null) 'favorite_fruit': favoriteFruit,
    });
  }

  DriftDocsCompanion copyWith(
      {Value<int>? id,
      Value<int>? index,
      Value<String>? guid,
      Value<bool>? isActive,
      Value<String>? balance,
      Value<String>? picture,
      Value<int>? age,
      Value<String>? eyeColor,
      Value<String>? company,
      Value<String>? email,
      Value<String>? phone,
      Value<String>? address,
      Value<String>? about,
      Value<String>? registered,
      Value<String>? latitude,
      Value<String>? longitude,
      Value<List<String>>? tags,
      Value<List<int>>? range,
      Value<String>? greeting,
      Value<String>? favoriteFruit}) {
    return DriftDocsCompanion(
      id: id ?? this.id,
      index: index ?? this.index,
      guid: guid ?? this.guid,
      isActive: isActive ?? this.isActive,
      balance: balance ?? this.balance,
      picture: picture ?? this.picture,
      age: age ?? this.age,
      eyeColor: eyeColor ?? this.eyeColor,
      company: company ?? this.company,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      about: about ?? this.about,
      registered: registered ?? this.registered,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      tags: tags ?? this.tags,
      range: range ?? this.range,
      greeting: greeting ?? this.greeting,
      favoriteFruit: favoriteFruit ?? this.favoriteFruit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (guid.present) {
      map['guid'] = Variable<String>(guid.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (balance.present) {
      map['balance'] = Variable<String>(balance.value);
    }
    if (picture.present) {
      map['picture'] = Variable<String>(picture.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (eyeColor.present) {
      map['eye_color'] = Variable<String>(eyeColor.value);
    }
    if (company.present) {
      map['company'] = Variable<String>(company.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (about.present) {
      map['about'] = Variable<String>(about.value);
    }
    if (registered.present) {
      map['registered'] = Variable<String>(registered.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<String>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<String>(longitude.value);
    }
    if (tags.present) {
      final converter = $DriftDocsTable.$converter0;
      map['tags'] = Variable<String>(converter.mapToSql(tags.value)!);
    }
    if (range.present) {
      final converter = $DriftDocsTable.$converter1;
      map['range'] = Variable<String>(converter.mapToSql(range.value)!);
    }
    if (greeting.present) {
      map['greeting'] = Variable<String>(greeting.value);
    }
    if (favoriteFruit.present) {
      map['favorite_fruit'] = Variable<String>(favoriteFruit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftDocsCompanion(')
          ..write('id: $id, ')
          ..write('index: $index, ')
          ..write('guid: $guid, ')
          ..write('isActive: $isActive, ')
          ..write('balance: $balance, ')
          ..write('picture: $picture, ')
          ..write('age: $age, ')
          ..write('eyeColor: $eyeColor, ')
          ..write('company: $company, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('about: $about, ')
          ..write('registered: $registered, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('tags: $tags, ')
          ..write('range: $range, ')
          ..write('greeting: $greeting, ')
          ..write('favoriteFruit: $favoriteFruit')
          ..write(')'))
        .toString();
  }
}

class $DriftDocsTable extends DriftDocs
    with TableInfo<$DriftDocsTable, DriftDoc> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftDocsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int?> index = GeneratedColumn<int?>(
      'index', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _guidMeta = const VerificationMeta('guid');
  @override
  late final GeneratedColumn<String?> guid = GeneratedColumn<String?>(
      'guid', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isActiveMeta = const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool?> isActive = GeneratedColumn<bool?>(
      'is_active', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_active IN (0, 1))');
  final VerificationMeta _balanceMeta = const VerificationMeta('balance');
  @override
  late final GeneratedColumn<String?> balance = GeneratedColumn<String?>(
      'balance', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _pictureMeta = const VerificationMeta('picture');
  @override
  late final GeneratedColumn<String?> picture = GeneratedColumn<String?>(
      'picture', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int?> age = GeneratedColumn<int?>(
      'age', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _eyeColorMeta = const VerificationMeta('eyeColor');
  @override
  late final GeneratedColumn<String?> eyeColor = GeneratedColumn<String?>(
      'eye_color', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _companyMeta = const VerificationMeta('company');
  @override
  late final GeneratedColumn<String?> company = GeneratedColumn<String?>(
      'company', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String?> phone = GeneratedColumn<String?>(
      'phone', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _addressMeta = const VerificationMeta('address');
  @override
  late final GeneratedColumn<String?> address = GeneratedColumn<String?>(
      'address', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _aboutMeta = const VerificationMeta('about');
  @override
  late final GeneratedColumn<String?> about = GeneratedColumn<String?>(
      'about', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _registeredMeta = const VerificationMeta('registered');
  @override
  late final GeneratedColumn<String?> registered = GeneratedColumn<String?>(
      'registered', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<String?> latitude = GeneratedColumn<String?>(
      'latitude', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<String?> longitude = GeneratedColumn<String?>(
      'longitude', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String?> tags =
      GeneratedColumn<String?>('tags', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<List<String>>($DriftDocsTable.$converter0);
  final VerificationMeta _rangeMeta = const VerificationMeta('range');
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String?> range =
      GeneratedColumn<String?>('range', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<List<int>>($DriftDocsTable.$converter1);
  final VerificationMeta _greetingMeta = const VerificationMeta('greeting');
  @override
  late final GeneratedColumn<String?> greeting = GeneratedColumn<String?>(
      'greeting', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _favoriteFruitMeta =
      const VerificationMeta('favoriteFruit');
  @override
  late final GeneratedColumn<String?> favoriteFruit = GeneratedColumn<String?>(
      'favorite_fruit', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        index,
        guid,
        isActive,
        balance,
        picture,
        age,
        eyeColor,
        company,
        email,
        phone,
        address,
        about,
        registered,
        latitude,
        longitude,
        tags,
        range,
        greeting,
        favoriteFruit
      ];
  @override
  String get aliasedName => _alias ?? 'drift_docs';
  @override
  String get actualTableName => 'drift_docs';
  @override
  VerificationContext validateIntegrity(Insertable<DriftDoc> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    } else if (isInserting) {
      context.missing(_indexMeta);
    }
    if (data.containsKey('guid')) {
      context.handle(
          _guidMeta, guid.isAcceptableOrUnknown(data['guid']!, _guidMeta));
    } else if (isInserting) {
      context.missing(_guidMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('picture')) {
      context.handle(_pictureMeta,
          picture.isAcceptableOrUnknown(data['picture']!, _pictureMeta));
    } else if (isInserting) {
      context.missing(_pictureMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('eye_color')) {
      context.handle(_eyeColorMeta,
          eyeColor.isAcceptableOrUnknown(data['eye_color']!, _eyeColorMeta));
    } else if (isInserting) {
      context.missing(_eyeColorMeta);
    }
    if (data.containsKey('company')) {
      context.handle(_companyMeta,
          company.isAcceptableOrUnknown(data['company']!, _companyMeta));
    } else if (isInserting) {
      context.missing(_companyMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('about')) {
      context.handle(
          _aboutMeta, about.isAcceptableOrUnknown(data['about']!, _aboutMeta));
    } else if (isInserting) {
      context.missing(_aboutMeta);
    }
    if (data.containsKey('registered')) {
      context.handle(
          _registeredMeta,
          registered.isAcceptableOrUnknown(
              data['registered']!, _registeredMeta));
    } else if (isInserting) {
      context.missing(_registeredMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    context.handle(_tagsMeta, const VerificationResult.success());
    context.handle(_rangeMeta, const VerificationResult.success());
    if (data.containsKey('greeting')) {
      context.handle(_greetingMeta,
          greeting.isAcceptableOrUnknown(data['greeting']!, _greetingMeta));
    } else if (isInserting) {
      context.missing(_greetingMeta);
    }
    if (data.containsKey('favorite_fruit')) {
      context.handle(
          _favoriteFruitMeta,
          favoriteFruit.isAcceptableOrUnknown(
              data['favorite_fruit']!, _favoriteFruitMeta));
    } else if (isInserting) {
      context.missing(_favoriteFruitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftDoc map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftDoc(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      index: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}index'])!,
      guid: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}guid'])!,
      isActive: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_active'])!,
      balance: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}balance'])!,
      picture: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}picture'])!,
      age: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}age'])!,
      eyeColor: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}eye_color'])!,
      company: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}company'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      phone: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone'])!,
      address: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}address'])!,
      about: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}about'])!,
      registered: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}registered'])!,
      latitude: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude'])!,
      longitude: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude'])!,
      tags: $DriftDocsTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tags']))!,
      range: $DriftDocsTable.$converter1.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}range']))!,
      greeting: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}greeting'])!,
      favoriteFruit: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}favorite_fruit'])!,
    );
  }

  @override
  $DriftDocsTable createAlias(String alias) {
    return $DriftDocsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converter0 =
      const _JsonListConverter<String>();
  static TypeConverter<List<int>, String> $converter1 =
      const _JsonListConverter<int>();
}

class DriftNamesCompanion extends UpdateCompanion<DriftName> {
  final Value<int> docId;
  final Value<String> first;
  final Value<String> last;
  const DriftNamesCompanion({
    this.docId = const Value.absent(),
    this.first = const Value.absent(),
    this.last = const Value.absent(),
  });
  DriftNamesCompanion.insert({
    this.docId = const Value.absent(),
    required String first,
    required String last,
  })  : first = Value(first),
        last = Value(last);
  static Insertable<DriftName> custom({
    Expression<int>? docId,
    Expression<String>? first,
    Expression<String>? last,
  }) {
    return RawValuesInsertable({
      if (docId != null) 'doc_id': docId,
      if (first != null) 'first': first,
      if (last != null) 'last': last,
    });
  }

  DriftNamesCompanion copyWith(
      {Value<int>? docId, Value<String>? first, Value<String>? last}) {
    return DriftNamesCompanion(
      docId: docId ?? this.docId,
      first: first ?? this.first,
      last: last ?? this.last,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (docId.present) {
      map['doc_id'] = Variable<int>(docId.value);
    }
    if (first.present) {
      map['first'] = Variable<String>(first.value);
    }
    if (last.present) {
      map['last'] = Variable<String>(last.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftNamesCompanion(')
          ..write('docId: $docId, ')
          ..write('first: $first, ')
          ..write('last: $last')
          ..write(')'))
        .toString();
  }
}

class $DriftNamesTable extends DriftNames
    with TableInfo<$DriftNamesTable, DriftName> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftNamesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _docIdMeta = const VerificationMeta('docId');
  @override
  late final GeneratedColumn<int?> docId = GeneratedColumn<int?>(
      'doc_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _firstMeta = const VerificationMeta('first');
  @override
  late final GeneratedColumn<String?> first = GeneratedColumn<String?>(
      'first', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _lastMeta = const VerificationMeta('last');
  @override
  late final GeneratedColumn<String?> last = GeneratedColumn<String?>(
      'last', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [docId, first, last];
  @override
  String get aliasedName => _alias ?? 'drift_names';
  @override
  String get actualTableName => 'drift_names';
  @override
  VerificationContext validateIntegrity(Insertable<DriftName> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('doc_id')) {
      context.handle(
          _docIdMeta, docId.isAcceptableOrUnknown(data['doc_id']!, _docIdMeta));
    }
    if (data.containsKey('first')) {
      context.handle(
          _firstMeta, first.isAcceptableOrUnknown(data['first']!, _firstMeta));
    } else if (isInserting) {
      context.missing(_firstMeta);
    }
    if (data.containsKey('last')) {
      context.handle(
          _lastMeta, last.isAcceptableOrUnknown(data['last']!, _lastMeta));
    } else if (isInserting) {
      context.missing(_lastMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {docId};
  @override
  DriftName map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftName(
      docId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_id'])!,
      first: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first'])!,
      last: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last'])!,
    );
  }

  @override
  $DriftNamesTable createAlias(String alias) {
    return $DriftNamesTable(attachedDatabase, alias);
  }
}

class DriftFriendsCompanion extends UpdateCompanion<DriftFriend> {
  final Value<int> docId;
  final Value<int> id;
  final Value<String> name;
  const DriftFriendsCompanion({
    this.docId = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  DriftFriendsCompanion.insert({
    required int docId,
    required int id,
    required String name,
  })  : docId = Value(docId),
        id = Value(id),
        name = Value(name);
  static Insertable<DriftFriend> custom({
    Expression<int>? docId,
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (docId != null) 'doc_id': docId,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  DriftFriendsCompanion copyWith(
      {Value<int>? docId, Value<int>? id, Value<String>? name}) {
    return DriftFriendsCompanion(
      docId: docId ?? this.docId,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (docId.present) {
      map['doc_id'] = Variable<int>(docId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftFriendsCompanion(')
          ..write('docId: $docId, ')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $DriftFriendsTable extends DriftFriends
    with TableInfo<$DriftFriendsTable, DriftFriend> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftFriendsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _docIdMeta = const VerificationMeta('docId');
  @override
  late final GeneratedColumn<int?> docId = GeneratedColumn<int?>(
      'doc_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [docId, id, name];
  @override
  String get aliasedName => _alias ?? 'drift_friends';
  @override
  String get actualTableName => 'drift_friends';
  @override
  VerificationContext validateIntegrity(Insertable<DriftFriend> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('doc_id')) {
      context.handle(
          _docIdMeta, docId.isAcceptableOrUnknown(data['doc_id']!, _docIdMeta));
    } else if (isInserting) {
      context.missing(_docIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {docId, id};
  @override
  DriftFriend map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftFriend(
      docId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}doc_id'])!,
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }

  @override
  $DriftFriendsTable createAlias(String alias) {
    return $DriftFriendsTable(attachedDatabase, alias);
  }
}

abstract class _$DriftBenchmarkDatabase extends GeneratedDatabase {
  _$DriftBenchmarkDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  _$DriftBenchmarkDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $DriftDocsTable driftDocs = $DriftDocsTable(this);
  late final $DriftNamesTable driftNames = $DriftNamesTable(this);
  late final $DriftFriendsTable driftFriends = $DriftFriendsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [driftDocs, driftNames, driftFriends];
}

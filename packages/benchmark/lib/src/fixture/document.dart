import 'dart:convert';

import 'package:collection/collection.dart';

import '../benchmark.dart';

class BenchmarkDoc {
  final String id;
  final int index;
  final String guid;
  final bool isActive;
  final String balance;
  final String picture;
  final int age;
  final String eyeColor;
  final BenchmarkName name;
  final String company;
  final String email;
  final String phone;
  final String address;
  final String about;
  final String registered;
  final String latitude;
  final String longitude;
  final List<String> tags;
  final List<int> range;
  final List<BenchmarkFriend> friends;
  final String greeting;
  final String favoriteFruit;

  BenchmarkDoc({
    required this.id,
    required this.index,
    required this.guid,
    required this.isActive,
    required this.balance,
    required this.picture,
    required this.age,
    required this.eyeColor,
    required this.name,
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
    required this.friends,
    required this.greeting,
    required this.favoriteFruit,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkDoc &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          index == other.index &&
          guid == other.guid &&
          isActive == other.isActive &&
          balance == other.balance &&
          picture == other.picture &&
          age == other.age &&
          eyeColor == other.eyeColor &&
          name == other.name &&
          company == other.company &&
          email == other.email &&
          phone == other.phone &&
          address == other.address &&
          about == other.about &&
          registered == other.registered &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          const DeepCollectionEquality().equals(tags, other.tags) &&
          const DeepCollectionEquality().equals(range, other.range) &&
          const DeepCollectionEquality().equals(friends, other.friends) &&
          greeting == other.greeting &&
          favoriteFruit == other.favoriteFruit;

  @override
  int get hashCode =>
      id.hashCode ^
      index.hashCode ^
      guid.hashCode ^
      isActive.hashCode ^
      balance.hashCode ^
      picture.hashCode ^
      age.hashCode ^
      eyeColor.hashCode ^
      name.hashCode ^
      company.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      about.hashCode ^
      registered.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(range) ^
      const DeepCollectionEquality().hash(friends) ^
      greeting.hashCode ^
      favoriteFruit.hashCode;

  @override
  String toString() => 'BenchmarkDoc('
      'id: $id,'
      'index: $index,'
      'guid: $guid,'
      'isActive: $isActive,'
      'balance: $balance,'
      'picture: $picture,'
      'age: $age,'
      'eyeColor: $eyeColor,'
      'name: $name,'
      'company: $company,'
      'email: $email,'
      'phone: $phone,'
      'address: $address,'
      'about: $about,'
      'registered: $registered,'
      'latitude: $latitude,'
      'longitude: $longitude,'
      'tags: $tags,'
      'range: $range,'
      'friends: $friends,'
      'greeting: $greeting,'
      'favoriteFruit: $favoriteFruit'
      ')';

  Map<String, Object?>? toJson() => {
        'id': id,
        'index': index,
        'guid': guid,
        'isActive': isActive,
        'balance': balance,
        'picture': picture,
        'age': age,
        'eyeColor': eyeColor,
        'name': name.toJson(),
        'company': company,
        'email': email,
        'phone': phone,
        'address': address,
        'about': about,
        'registered': registered,
        'latitude': latitude,
        'longitude': longitude,
        'tags': tags,
        'range': range,
        'friends': friends.map((friend) => friend.toJson()).toList(),
        'greeting': greeting,
        'favoriteFruit': favoriteFruit,
      };

  static BenchmarkDoc fromJson(Map<String, Object?> json, {String? id}) =>
      BenchmarkDoc(
        id: id ?? json['id'] as String,
        index: json['index'] as int,
        guid: json['guid'] as String,
        isActive: json['isActive'] as bool,
        balance: json['balance'] as String,
        picture: json['picture'] as String,
        age: json['age'] as int,
        eyeColor: json['eyeColor'] as String,
        name: BenchmarkName.fromJson(json['name'] as Map<String, Object?>),
        company: json['company'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        about: json['about'] as String,
        registered: json['registered'] as String,
        latitude: json['latitude'] as String,
        longitude: json['longitude'] as String,
        tags: (json['tags'] as List).cast<String>().toList(),
        range: (json['range'] as List).cast<int>().toList(),
        friends: (json['friends'] as List)
            .cast<Map<String, Object?>>()
            .map(BenchmarkFriend.fromJson)
            .toList(),
        greeting: json['greeting'] as String,
        favoriteFruit: json['favoriteFruit'] as String,
      );
}

class BenchmarkName {
  BenchmarkName({required this.first, required this.last});

  final String first;
  final String last;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkName &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          last == other.last;

  @override
  int get hashCode => first.hashCode ^ last.hashCode;

  @override
  String toString() => 'BenchmarkName(first: $first, last: $last)';

  Map<String, Object?>? toJson() => {
        'first': first,
        'last': last,
      };

  factory BenchmarkName.fromJson(Map<String, Object?> json) => BenchmarkName(
        first: json['first']! as String,
        last: json['last']! as String,
      );
}

class BenchmarkFriend {
  BenchmarkFriend({required this.id, required this.name});

  final int id;
  final String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkFriend &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'BenchmarkFriend(id: $id, name: $name)';

  Map<String, Object?>? toJson() => {
        'id': id,
        'name': name,
      };

  factory BenchmarkFriend.fromJson(Map<String, Object?> json) =>
      BenchmarkFriend(
        id: json['id']! as int,
        name: json['name']! as String,
      );
}

late final Future<String> Function() loadDocumentsJson;

typedef DocumentMap = Map<String, Object?>;

Future<List<DocumentMap>>? _documents;

Future<List<DocumentMap>> loadDocuments() async {
  return _documents ??= Future(() async {
    final docs = jsonDecode(await loadDocumentsJson()) as List<Object?>;
    return docs.cast<DocumentMap>();
  });
}

var _documentNumber = 0;

final _documentNumbers = <Object?, int>{};

String createDocumentId(DocumentMap document) =>
    '${document['id']}_${_documentNumbers[document] = _documentNumber++}';

String getDocumentId(DocumentMap document) =>
    '${document['id']}_${_documentNumbers[document]!}';

mixin BenchmarkDocumentMixin on BenchmarkRunner {
  late final List<DocumentMap> documents;

  @override
  Future<void> setup() async {
    documents = await loadDocuments();
    return super.setup();
  }

  BenchmarkDoc createDocument() => _createDocument();

  List<BenchmarkDoc> createDocuments(int count) =>
      List.generate(count, _createDocument);

  BenchmarkDoc _createDocument([int index = 0]) {
    final documentMap =
        documents[(executedOperations + index) % documents.length];
    return BenchmarkDoc.fromJson(
      documentMap,
      id: createDocumentId(documentMap),
    );
  }
}

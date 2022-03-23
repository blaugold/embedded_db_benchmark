import 'package:collection/collection.dart';

mixin BenchmarkDoc<ID extends Object> {
  ID get id;
  int get index;
  String get guid;
  bool get isActive;
  String get balance;
  set balance(String value);
  String get picture;
  int get age;
  String get eyeColor;
  BenchmarkName get name;
  String get company;
  String get email;
  String get phone;
  String get address;
  String get about;
  String get registered;
  String get latitude;
  String get longitude;
  List<String> get tags;
  List<int> get range;
  List<BenchmarkFriend> get friends;
  String get greeting;
  String get favoriteFruit;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkDoc &&
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
}

mixin BenchmarkName {
  String get first;
  String get last;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkName && first == other.first && last == other.last;

  @override
  String toString() => 'BenchmarkName(first: $first, last: $last)';

  Map<String, Object?>? toJson() => {
        'first': first,
        'last': last,
      };
}

mixin BenchmarkFriend {
  int get id;
  String get name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BenchmarkFriend && id == other.id && name == other.name;

  @override
  String toString() => 'BenchmarkFriend(id: $id, name: $name)';

  Map<String, Object?>? toJson() => {
        'id': id,
        'name': name,
      };
}

class BenchmarkDocData<ID extends Object> with BenchmarkDoc<ID> {
  @override
  final ID id;
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
  final BenchmarkNameData name;
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
  final List<BenchmarkFriendData> friends;
  @override
  final String greeting;
  @override
  final String favoriteFruit;

  BenchmarkDocData({
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

  static BenchmarkDocData<ID> fromJson<ID extends Object>(
    Map<String, Object?> json, {
    ID? id,
  }) =>
      BenchmarkDocData<ID>(
        id: id ?? json['id'] as ID,
        index: json['index'] as int,
        guid: json['guid'] as String,
        isActive: json['isActive'] as bool,
        balance: json['balance'] as String,
        picture: json['picture'] as String,
        age: json['age'] as int,
        eyeColor: json['eyeColor'] as String,
        name: BenchmarkNameData.fromJson(json['name'] as Map<String, Object?>),
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
            .map(BenchmarkFriendData.fromJson)
            .toList(),
        greeting: json['greeting'] as String,
        favoriteFruit: json['favoriteFruit'] as String,
      );
}

class BenchmarkNameData with BenchmarkName {
  BenchmarkNameData({required this.first, required this.last});

  @override
  final String first;
  @override
  final String last;

  factory BenchmarkNameData.fromJson(Map<String, Object?> json) =>
      BenchmarkNameData(
        first: json['first']! as String,
        last: json['last']! as String,
      );
}

class BenchmarkFriendData with BenchmarkFriend {
  BenchmarkFriendData({required this.id, required this.name});

  @override
  final int id;
  @override
  final String name;

  factory BenchmarkFriendData.fromJson(Map<String, Object?> json) =>
      BenchmarkFriendData(
        id: json['id']! as int,
        name: json['name']! as String,
      );
}

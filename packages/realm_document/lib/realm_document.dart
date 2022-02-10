import 'package:realm_dart/realm.dart';

part 'realm_document.g.dart';

@RealmModel()
class _SimpleRealmDoc {
  late final String name;
}

@RealmModel()
class _RealmDoc {
  @PrimaryKey()
  late final String id;
  late final int index;
  late final String guid;
  late final bool isActive;
  late final String balance;
  late final String picture;
  late final int age;
  late final String eyeColor;
  late final _RealmName? name;
  late final String company;
  late final String email;
  late final String phone;
  late final String address;
  late final String about;
  late final String registered;
  late final String latitude;
  late final String longitude;
  late final List<String> tags;
  late final List<int> range;
  late final List<_RealmFriend> friends;
  late final String greeting;
  late final String favoriteFruit;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'index': index,
      'guid': guid,
      'isActive': isActive,
      'balance': balance,
      'picture': picture,
      'age': age,
      'eyeColor': eyeColor,
      'name': name?.toJson(),
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
}

@RealmModel()
class _RealmName {
  late final String first;
  late final String last;

  Map<String, Object?> toJson() => {
        'first': first,
        'last': last,
      };
}

@RealmModel()
class _RealmFriend {
  late final int id;
  late final String name;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
      };
}

RealmDoc realmDocFromJson(String id, Map<String, Object?> json) => RealmDoc(
      id,
      json['index'] as int,
      json['guid'] as String,
      json['isActive'] as bool,
      json['balance'] as String,
      json['picture'] as String,
      json['age'] as int,
      json['eyeColor'] as String,
      json['company'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['address'] as String,
      json['about'] as String,
      json['registered'] as String,
      json['latitude'] as String,
      json['longitude'] as String,
      json['greeting'] as String,
      json['favoriteFruit'] as String,
      name: realmNameFromJson(json['name'] as Map<String, Object?>),
      tags: (json['tags'] as List<Object?>).cast(),
      range: (json['range'] as List<Object?>).cast(),
      friends: (json['friends'] as List<Object?>)
          .map((e) => realmFriendFromJson(e as Map<String, Object?>))
          .toList(),
    );

RealmName realmNameFromJson(Map<String, Object?> json) => RealmName(
      json['first'] as String,
      json['last'] as String,
    );

RealmFriend realmFriendFromJson(Map<String, Object?> json) => RealmFriend(
      json['id'] as int,
      json['name'] as String,
    );

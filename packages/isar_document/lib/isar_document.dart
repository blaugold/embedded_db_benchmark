import 'package:isar/isar.dart';

part 'isar_document.g.dart';

@Collection()
class IsarDoc {
  @Id()
  late final id_ = Isar.autoIncrement;
  @Index()
  late final String id;
  late final int index;
  late final String guid;
  late final bool isActive;
  late final String balance;
  late final String picture;
  late final int age;
  late final String eyeColor;
  final name = IsarLink<IsarName>();
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
  final friends = IsarLinks<IsarFriend>();
  late final String greeting;
  late final String favoriteFruit;

  IsarDoc();

  factory IsarDoc.fromJson(String id, Map<String, dynamic> json) => IsarDoc()
    ..id = id
    ..index = json['index'] as int
    ..guid = json['guid'] as String
    ..isActive = json['isActive'] as bool
    ..balance = json['balance'] as String
    ..picture = json['picture'] as String
    ..age = json['age'] as int
    ..eyeColor = json['eyeColor'] as String
    ..name.value = IsarName.fromJson(json['name'] as Map<String, Object?>)
    ..company = json['company'] as String
    ..email = json['email'] as String
    ..phone = json['phone'] as String
    ..address = json['address'] as String
    ..about = json['about'] as String
    ..registered = json['registered'] as String
    ..latitude = json['latitude'] as String
    ..longitude = json['longitude'] as String
    ..greeting = json['greeting'] as String
    ..favoriteFruit = json['favoriteFruit'] as String
    ..friends.addAll(
      (json['friends'] as List<Object?>)
          .cast<Map<String, Object?>>()
          .map(IsarFriend.fromJson),
    )
    ..tags = (json['tags'] as List<Object?>).cast()
    ..range = (json['range'] as List<Object?>).cast();

  Map<String, Object?> toJson() => {
        'id': id,
        'index': index,
        'guid': guid,
        'isActive': isActive,
        'balance': balance,
        'picture': picture,
        'age': age,
        'eyeColor': eyeColor,
        'name': (name..loadSync()).value!.toJson(),
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
        'friends':
            (friends..loadSync()).map((value) => value.toJson()).toList(),
        'greeting': greeting,
        'favoriteFruit': favoriteFruit,
      };
}

@Collection()
class IsarName {
  int? id;
  late final String first;
  late final String last;

  IsarName();

  IsarName.fromJson(Map<String, Object?> json)
      : first = json['first'] as String,
        last = json['last'] as String;

  Map<String, Object?> toJson() => {
        'first': first,
        'last': last,
      };
}

@Collection()
class IsarFriend {
  int id = Isar.autoIncrement;
  late final String name;

  IsarFriend();

  IsarFriend.fromJson(Map<String, Object?> json)
      : id = json['id'] as int,
        name = json['name'] as String;

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
      };
}

import 'package:isar/isar.dart';

part 'isar_document.g.dart';

@Collection()
class IsarDoc {
  @Id()
  late final id_ = Isar.autoIncrement;
  late final String id;
  late final int index;
  late final String guid;
  late final bool isActive;
  late final String balance;
  late final String picture;
  late final int age;
  late final String eyeColor;
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
  late final String greeting;
  late final String favoriteFruit;
}

IsarDoc isarDocFromJson(String id, Map<String, Object?> json) => IsarDoc()
  ..id = id
  ..index = json['index'] as int
  ..guid = json['guid'] as String
  ..isActive = json['isActive'] as bool
  ..balance = json['balance'] as String
  ..picture = json['picture'] as String
  ..age = json['age'] as int
  ..eyeColor = json['eyeColor'] as String
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
  ..tags = (json['tags'] as List<Object?>).cast()
  ..range = (json['range'] as List<Object?>).cast();

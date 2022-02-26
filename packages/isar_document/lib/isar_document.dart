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
}

@Collection()
class IsarName {
  int? id;
  late final String first;
  late final String last;

  IsarName();
}

@Collection()
class IsarFriend {
  int id = Isar.autoIncrement;
  late final String name;

  IsarFriend();
}

import 'package:hive/hive.dart';

part 'hive_document.g.dart';

@HiveType(typeId: 0)
class HiveDoc {
  HiveDoc({
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

  @HiveField(0)
  final String id;
  @HiveField(1)
  final int index;
  @HiveField(2)
  final String guid;
  @HiveField(3)
  final bool isActive;
  @HiveField(4)
  final String balance;
  @HiveField(5)
  final String picture;
  @HiveField(6)
  final int age;
  @HiveField(7)
  final String eyeColor;
  @HiveField(8)
  final HiveName name;
  @HiveField(9)
  final String company;
  @HiveField(10)
  final String email;
  @HiveField(11)
  final String phone;
  @HiveField(12)
  final String address;
  @HiveField(13)
  final String about;
  @HiveField(14)
  final String registered;
  @HiveField(15)
  final String latitude;
  @HiveField(16)
  final String longitude;
  @HiveField(17)
  final List<String> tags;
  @HiveField(18)
  final List<int> range;
  @HiveField(19)
  final List<HiveFriend> friends;
  @HiveField(20)
  final String greeting;
  @HiveField(21)
  final String favoriteFruit;
}

@HiveType(typeId: 1)
class HiveName {
  HiveName({required this.first, required this.last});

  @HiveField(0)
  final String first;
  @HiveField(1)
  final String last;
}

@HiveType(typeId: 3)
class HiveFriend {
  HiveFriend({required this.id, required this.name});

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
}

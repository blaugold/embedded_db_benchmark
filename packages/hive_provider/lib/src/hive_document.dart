import 'package:benchmark/benchmark.dart';
import 'package:hive/hive.dart';

part 'hive_document.g.dart';

@HiveType(typeId: 0)
class HiveDoc with BenchmarkDoc<String> {
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

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final int index;
  @override
  @HiveField(2)
  final String guid;
  @override
  @HiveField(3)
  final bool isActive;
  @override
  @HiveField(4)
  String balance;
  @override
  @HiveField(5)
  final String picture;
  @override
  @HiveField(6)
  final int age;
  @override
  @HiveField(7)
  final String eyeColor;
  @override
  @HiveField(8)
  final HiveName name;
  @override
  @HiveField(9)
  final String company;
  @override
  @HiveField(10)
  final String email;
  @override
  @HiveField(11)
  final String phone;
  @override
  @HiveField(12)
  final String address;
  @override
  @HiveField(13)
  final String about;
  @override
  @HiveField(14)
  final String registered;
  @override
  @HiveField(15)
  final String latitude;
  @override
  @HiveField(16)
  final String longitude;
  @override
  @HiveField(17)
  final List<String> tags;
  @override
  @HiveField(18)
  final List<int> range;
  @override
  @HiveField(19)
  final List<HiveFriend> friends;
  @override
  @HiveField(20)
  final String greeting;
  @override
  @HiveField(21)
  final String favoriteFruit;
}

@HiveType(typeId: 1)
class HiveName with BenchmarkName {
  HiveName({required this.first, required this.last});

  @override
  @HiveField(0)
  final String first;
  @override
  @HiveField(1)
  final String last;
}

@HiveType(typeId: 3)
class HiveFriend with BenchmarkFriend {
  HiveFriend({required this.id, required this.name});

  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String name;
}

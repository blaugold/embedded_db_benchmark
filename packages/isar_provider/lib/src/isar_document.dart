import 'package:benchmark/benchmark.dart';
import 'package:isar/isar.dart';

part 'isar_document.g.dart';

@Collection()
class IsarDoc with BenchmarkDoc<int> {
  IsarDoc();

  @override
  @Id()
  late int id = Isar.autoIncrement;
  @override
  late final int index;
  @override
  late final String guid;
  @override
  late final bool isActive;
  @override
  late String balance;
  @override
  late final String picture;
  @override
  late final int age;
  @override
  late final String eyeColor;
  final isarName = IsarLink<IsarName>();
  @override
  IsarName get name => isarName.value!;
  @override
  late final String company;
  @override
  late final String email;
  @override
  late final String phone;
  @override
  late final String address;
  @override
  late final String about;
  @override
  late final String registered;
  @override
  late final String latitude;
  @override
  late final String longitude;
  @override
  late final List<String> tags;
  @override
  late final List<int> range;
  final isarFriends = IsarLinks<IsarFriend>();
  @override
  List<IsarFriend> get friends =>
      isarFriends.toList()..sort((a, b) => a.id - b.id);
  @override
  late final String greeting;
  @override
  late final String favoriteFruit;
}

@Collection()
class IsarName with BenchmarkName {
  IsarName();

  @Id()
  late int dbId = Isar.autoIncrement;
  @override
  late final String first;
  @override
  late final String last;
}

@Collection()
class IsarFriend with BenchmarkFriend {
  IsarFriend();

  @Id()
  late int dbId = Isar.autoIncrement;
  @override
  late final int id;
  @override
  late final String name;
}

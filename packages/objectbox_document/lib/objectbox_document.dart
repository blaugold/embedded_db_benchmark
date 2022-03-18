import 'package:benchmark_document/benchmark_document.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObjectboxDoc with BenchmarkDoc<int> {
  ObjectboxDoc({
    this.id = 0,
    required this.index,
    required this.guid,
    required this.isActive,
    required this.balance,
    required this.picture,
    required this.age,
    required this.eyeColor,
    required this.company,
    required this.email,
    required this.phone,
    required this.address,
    required this.about,
    required this.registered,
    required this.latitude,
    required this.longitude,
    required this.tags,
    required this.dbRange,
    required this.greeting,
    required this.favoriteFruit,
  });

  @override
  @Id()
  int id;
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
  final obxName = ToOne<ObjectboxName>();
  @override
  ObjectboxName get name => obxName.target!;
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
  final List<String> dbRange;
  @override
  List<int> get range => dbRange.map(int.parse).toList();
  final obxFriends = ToMany<ObjectboxFriend>();
  @override
  List<ObjectboxFriend> get friends =>
      obxFriends.toList()..sort(((a, b) => a.id - b.id));
  @override
  final String greeting;
  @override
  final String favoriteFruit;
}

@Entity()
class ObjectboxName with BenchmarkName {
  ObjectboxName({this.dbId = 0, required this.first, required this.last});

  @Id()
  int dbId;
  @override
  final String first;
  @override
  final String last;
}

@Entity()
class ObjectboxFriend with BenchmarkFriend {
  ObjectboxFriend({this.dbId = 0, required this.id, required this.name});

  @Id()
  int dbId;
  @override
  final int id;
  @override
  final String name;
}

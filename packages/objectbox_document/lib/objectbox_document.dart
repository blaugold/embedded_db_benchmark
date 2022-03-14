import 'package:benchmark_document/benchmark_document.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObjectboxDoc with BenchmarkDoc {
  ObjectboxDoc({
    this.dbId = 0,
    required this.id,
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

  @Id()
  int dbId;
  @override
  @Index()
  String id;
  @override
  int index;
  @override
  String guid;
  @override
  bool isActive;
  @override
  String balance;
  @override
  String picture;
  @override
  int age;
  @override
  String eyeColor;
  final obxName = ToOne<ObjectboxName>();
  @override
  ObjectboxName get name => obxName.target!;
  @override
  String company;
  @override
  String email;
  @override
  String phone;
  @override
  String address;
  @override
  String about;
  @override
  String registered;
  @override
  String latitude;
  @override
  String longitude;
  @override
  List<String> tags;
  List<String> dbRange = [];
  @override
  List<int> get range => dbRange.map(int.parse).toList();
  set range(List<int> value) =>
      dbRange = value.map((v) => v.toString()).toList();
  final obxFriends = ToMany<ObjectboxFriend>();
  @override
  List<ObjectboxFriend> get friends =>
      obxFriends.toList()..sort(((a, b) => a.id - b.id));
  @override
  String greeting;
  @override
  String favoriteFruit;
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
  int id;
  @override
  String name;
}

import 'package:objectbox/objectbox.dart';

@Entity()
class ObjectboxDoc {
  @Id()
  int dbId;
  @Index()
  String id;
  int index;
  String guid;
  bool isActive;
  String balance;
  String picture;
  int age;
  String eyeColor;
  final name = ToOne<ObjectboxName>();
  String company;
  String email;
  String phone;
  String address;
  String about;
  String registered;
  String latitude;
  String longitude;
  List<String> tags;
  List<String> dbRange = [];
  List<int> get range => dbRange.map(int.parse).toList();
  set range(List<int> value) =>
      dbRange = value.map((v) => v.toString()).toList();
  final friends = ToMany<ObjectboxFriend>();
  String greeting;
  String favoriteFruit;

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
}

@Entity()
class ObjectboxName {
  @Id()
  int dbId;
  final String first;
  final String last;

  ObjectboxName({this.dbId = 0, required this.first, required this.last});
}

@Entity()
class ObjectboxFriend {
  @Id()
  int dbId;
  int id;
  String name;

  ObjectboxFriend({this.dbId = 0, required this.id, required this.name});
}

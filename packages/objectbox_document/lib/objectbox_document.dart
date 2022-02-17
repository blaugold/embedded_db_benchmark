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

  factory ObjectboxDoc.fromJson(String id, Map<String, dynamic> json) =>
      ObjectboxDoc(
        id: id,
        index: json["index"]! as int,
        guid: json["guid"]! as String,
        isActive: json["isActive"]! as bool,
        balance: json["balance"]! as String,
        picture: json["picture"]! as String,
        age: json["age"]! as int,
        eyeColor: json["eyeColor"]! as String,
        company: json["company"]! as String,
        email: json["email"]! as String,
        phone: json["phone"]! as String,
        address: json["address"]! as String,
        about: json["about"]! as String,
        registered: json["registered"]! as String,
        latitude: json["latitude"]! as String,
        longitude: json["longitude"]! as String,
        tags: (json["tags"] as List).cast<String>().toList(),
        dbRange: (json["range"] as List)
            .cast<int>()
            .map((value) => value.toString())
            .toList(),
        greeting: json["greeting"]! as String,
        favoriteFruit: json["favoriteFruit"]! as String,
      )
        ..name.target =
            ObjectboxName.fromJson(json["name"] as Map<String, dynamic>)
        ..friends.addAll(
          (json["friends"]! as List<Object?>)
              .map((value) =>
                  ObjectboxFriend.fromJson(value as Map<String, dynamic>))
              .toList(),
        );

  Map<String, Object?> toJson() => {
        "id": id,
        "index": index,
        "guid": guid,
        "isActive": isActive,
        "balance": balance,
        "picture": picture,
        "age": age,
        "eyeColor": eyeColor,
        "company": company,
        "email": email,
        "phone": phone,
        "address": address,
        "about": about,
        "registered": registered,
        "latitude": latitude,
        "longitude": longitude,
        "tags": tags,
        "range": range,
        "greeting": greeting,
        "favoriteFruit": favoriteFruit,
        "name": name.target!.toJson(),
        "friends": friends.map((value) => value.toJson()).toList(),
      };
}

@Entity()
class ObjectboxName {
  int id;
  final String first;
  final String last;

  ObjectboxName({this.id = 0, required this.first, required this.last});

  factory ObjectboxName.fromJson(Map<String, Object?> json) => ObjectboxName(
        first: json['first']! as String,
        last: json['last']! as String,
      );

  Map<String, Object?> toJson() => {
        'first': first,
        'last': last,
      };
}

@Entity()
class ObjectboxFriend {
  int id;
  String name;

  ObjectboxFriend({this.id = 0, required this.name});

  factory ObjectboxFriend.fromJson(Map<String, Object?> json) =>
      ObjectboxFriend(
        id: json['id']! as int,
        name: json['name']! as String,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
      };
}

import 'package:realm_dart/realm.dart';

part 'realm_document.g.dart';

@RealmModel()
class _SimpleRealmDoc {
  late final String name;
}

@RealmModel()
class _RealmDoc {
  @PrimaryKey()
  late final String id;
  late final int index;
  late final String guid;
  late final bool isActive;
  late final String balance;
  late final String picture;
  late final int age;
  late final String eyeColor;
  late final _RealmName? name;
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
  late final List<_RealmFriend> friends;
  late final String greeting;
  late final String favoriteFruit;
}

@RealmModel()
class _RealmName {
  late final String first;
  late final String last;
}

@RealmModel()
class _RealmFriend {
  late final int id;
  late final String name;
}

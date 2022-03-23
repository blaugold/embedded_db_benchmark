import 'package:benchmark/benchmark.dart';
import 'package:realm_dart/realm.dart';

part 'realm_document.g.dart';

@RealmModel()
class _RealmDoc with BenchmarkDoc<String> {
  @override
  @PrimaryKey()
  late final String id;
  @override
  late final int index;
  @override
  late final String guid;
  @override
  late final bool isActive;
  late String balance_;
  @Ignored()
  @override
  String get balance => balance_;
  @Ignored()
  String? updatedBalance;
  @Ignored()
  @override
  set balance(String value) {
    updatedBalance = value;
  }

  @override
  late final String picture;
  @override
  late final int age;
  @override
  late final String eyeColor;
  late final _RealmName? nameRel;
  @override
  _RealmName get name => nameRel!;
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
  @override
  late final List<_RealmFriend> friends;
  @override
  late final String greeting;
  @override
  late final String favoriteFruit;
}

@RealmModel()
class _RealmName with BenchmarkName {
  @override
  late final String first;
  @override
  late final String last;
}

@RealmModel()
class _RealmFriend with BenchmarkFriend {
  @override
  late final int id;
  @override
  late final String name;
}

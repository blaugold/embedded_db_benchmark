// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_document.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDocAdapter extends TypeAdapter<HiveDoc> {
  @override
  final int typeId = 0;

  @override
  HiveDoc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDoc(
      id: fields[0] as String,
      index: fields[1] as int,
      guid: fields[2] as String,
      isActive: fields[3] as bool,
      balance: fields[4] as String,
      picture: fields[5] as String,
      age: fields[6] as int,
      eyeColor: fields[7] as String,
      name: fields[8] as HiveName,
      company: fields[9] as String,
      email: fields[10] as String,
      phone: fields[11] as String,
      address: fields[12] as String,
      about: fields[13] as String,
      registered: fields[14] as String,
      latitude: fields[15] as String,
      longitude: fields[16] as String,
      tags: (fields[17] as List).cast<String>(),
      range: (fields[18] as List).cast<int>(),
      friends: (fields[19] as List).cast<HiveFriend>(),
      greeting: fields[20] as String,
      favoriteFruit: fields[21] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDoc obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.guid)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.balance)
      ..writeByte(5)
      ..write(obj.picture)
      ..writeByte(6)
      ..write(obj.age)
      ..writeByte(7)
      ..write(obj.eyeColor)
      ..writeByte(8)
      ..write(obj.name)
      ..writeByte(9)
      ..write(obj.company)
      ..writeByte(10)
      ..write(obj.email)
      ..writeByte(11)
      ..write(obj.phone)
      ..writeByte(12)
      ..write(obj.address)
      ..writeByte(13)
      ..write(obj.about)
      ..writeByte(14)
      ..write(obj.registered)
      ..writeByte(15)
      ..write(obj.latitude)
      ..writeByte(16)
      ..write(obj.longitude)
      ..writeByte(17)
      ..write(obj.tags)
      ..writeByte(18)
      ..write(obj.range)
      ..writeByte(19)
      ..write(obj.friends)
      ..writeByte(20)
      ..write(obj.greeting)
      ..writeByte(21)
      ..write(obj.favoriteFruit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveNameAdapter extends TypeAdapter<HiveName> {
  @override
  final int typeId = 1;

  @override
  HiveName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveName(
      first: fields[0] as String,
      last: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveName obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.first)
      ..writeByte(1)
      ..write(obj.last);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveFriendAdapter extends TypeAdapter<HiveFriend> {
  @override
  final int typeId = 3;

  @override
  HiveFriend read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveFriend(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveFriend obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveFriendAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

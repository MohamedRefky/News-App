// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mdel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UseerModelAdapter extends TypeAdapter<UseerModel> {
  @override
  final typeId = 0;

  @override
  UseerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UseerModel(
      name: fields[0] as String?,
      email: fields[1] as String?,
      password: fields[3] as String?,
      photoUrl: fields[2] as String?,
      countryName: fields[4] as String?,
      countryCode: fields[5] as String?,
      flagEmoji: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UseerModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.photoUrl)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.countryName)
      ..writeByte(5)
      ..write(obj.countryCode)
      ..writeByte(6)
      ..write(obj.flagEmoji);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UseerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

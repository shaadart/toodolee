// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bored_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoredModelAdapter extends TypeAdapter<BoredModel> {
  @override
  final int typeId = 2;

  @override
  BoredModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoredModel(
      boringActivity: fields[0] as String,
      boringType: fields[1] as String,
      boringLink: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BoredModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.boringActivity)
      ..writeByte(1)
      ..write(obj.boringType)
      ..writeByte(2)
      ..write(obj.boringLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoredModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

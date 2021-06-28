// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StreakModelAdapter extends TypeAdapter<StreakModel> {
  @override
  final int typeId = 1;

  @override
  StreakModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StreakModel(
      streakName: fields[0] as String,
      streakCount: fields[1] as int,
      streakEmoji: fields[2] as String,
      streakReminder: fields[3] as String,
      streakDays: fields[4] as int,
      isCompleted: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StreakModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.streakName)
      ..writeByte(1)
      ..write(obj.streakCount)
      ..writeByte(2)
      ..write(obj.streakEmoji)
      ..writeByte(3)
      ..write(obj.streakReminder)
      ..writeByte(4)
      ..write(obj.streakDays)
      ..writeByte(5)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreakModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

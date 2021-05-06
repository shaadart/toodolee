// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompletedTodoModelAdapter extends TypeAdapter<CompletedTodoModel> {
  @override
  final int typeId = 2;

  @override
  CompletedTodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedTodoModel(
      completedTodoName: fields[0] as String,
      completedTodoRemainder: fields[2] as String,
      completedTodoEmoji: fields[1] as String,
      isCompleted: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedTodoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.completedTodoName)
      ..writeByte(1)
      ..write(obj.completedTodoEmoji)
      ..writeByte(2)
      ..write(obj.completedTodoRemainder)
      ..writeByte(3)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletedTodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

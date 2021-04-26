import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  String todoName;
  @HiveField(1)
  String todoEmoji;
  @HiveField(2)
  DateTime todoRemainder;
  @HiveField(3)
  bool isCompleted;

  TodoModel(
      {this.todoName, this.todoRemainder, this.todoEmoji, this.isCompleted});
}

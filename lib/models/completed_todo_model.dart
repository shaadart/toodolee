//import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'completed_todo_model.g.dart';

@HiveType(typeId: 2)
class CompletedTodoModel {
  @HiveField(0)
  String completedTodoName;
  @HiveField(1)
  String completedTodoEmoji;
  @HiveField(2)
  String completedTodoRemainder;
  @HiveField(3)
  bool isCompleted;

  CompletedTodoModel(
      {this.completedTodoName,
      this.completedTodoRemainder,
      this.completedTodoEmoji,
      this.isCompleted}); //added false, value, if getting errors, remove "false" from here
}

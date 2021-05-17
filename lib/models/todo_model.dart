//import 'package:flutter/material.dart';
import 'package:hive/hive.dart'; //Local Database, Easy....

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  String todoName; //Name of Toooooooooooooooooodoooooooooooleeeeeeeeeee
  @HiveField(1)
  String todoEmoji; // Emoji (TAG)
  @HiveField(2)
  String todoRemainder; //Remainder
  @HiveField(3)
  bool isCompleted; //True or False, 

  TodoModel(
      {this.todoName,
      this.todoRemainder,
      this.todoEmoji,
      this.isCompleted}); //added false, value, if getting errors, remove "false" from here
}



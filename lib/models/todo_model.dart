//import 'package:flutter/material.dart';
import 'package:hive/hive.dart'; //Local Database, Easy....

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  String todoName; //Name of Toooooooooooooooooodoooooooooooleeeeeeeeeee
  @HiveField(1)
  String todoEmoji; // Emoji (TAG)
  @HiveField(2)
  String todoReminder; //Reminder
  @HiveField(3)
  bool isCompleted; //True or False,

  TodoModel(
      {this.todoName, this.todoReminder, this.todoEmoji, this.isCompleted});
}

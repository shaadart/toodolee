import 'package:hive/hive.dart';


part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  String todoName;
  @HiveField(1)
  String todoDescription;
  @HiveField(2)
  String todoEmoji;
  @HiveField(3)
  DateTime todoRemainder;
  @HiveField(4)
  bool isCompleted;

  TodoModel({this.todoName, this.todoDescription, this.isCompleted, this.todoRemainder, this.todoEmoji});
}

//import 'package:flutter/material.dart';
import 'package:hive/hive.dart'; //Local Database, Easy....

part 'completed_streak_model.g.dart';

@HiveType(typeId: 3)
class CompletedStreakModel extends HiveObject {
  @HiveField(0)
  String streakName;
  @HiveField(1)
  int streakCount;
  @HiveField(2)
  String streakEmoji;
  @HiveField(3)
  String streakRemainder;
  @HiveField(4)
  int streakDays;
  @HiveField(5)
  bool isCompleted;

  CompletedStreakModel(
      {this.streakName,
      this.streakCount,
      this.streakEmoji,
      this.streakRemainder,
      this.streakDays,
      this.isCompleted});

  //added false, value, if getting errors, remove "false" from here
}

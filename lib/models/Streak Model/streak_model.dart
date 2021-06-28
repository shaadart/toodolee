//import 'package:flutter/material.dart';
import 'package:hive/hive.dart'; //Local Database, Easy....

part 'streak_model.g.dart';

@HiveType(typeId: 1)
class StreakModel extends HiveObject {
  @HiveField(0)
  String streakName;
  @HiveField(1)
  int streakCount;
  @HiveField(2)
  String streakEmoji;
  @HiveField(3)
  String streakReminder;
  @HiveField(4)
  int streakDays;
  @HiveField(5)
  bool isCompleted;
  @HiveField(6)
  StreakModel(
      {this.streakName,
      this.streakCount,
      this.streakEmoji,
      this.streakReminder,
      this.streakDays,
      this.isCompleted});
}

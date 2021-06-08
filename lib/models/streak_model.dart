//import 'package:flutter/material.dart';
import 'package:hive/hive.dart'; //Local Database, Easy....

part 'streak_model.g.dart';

@HiveType(typeId: 1)
class StreakModel {
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

  StreakModel({
    this.streakName,
    this.streakCount,
    this.streakEmoji,
    this.streakRemainder,
    this.streakDays,
  });

  //added false, value, if getting errors, remove "false" from here
}

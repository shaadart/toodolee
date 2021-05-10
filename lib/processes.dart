import 'package:flutter/material.dart';
import "package:toodo/main.dart";
import 'package:cron/cron.dart';
import 'package:toodo/pages/more.dart';
import 'package:toodo/pages/more.dart';
import 'package:toodo/pages/weatherCard.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';

import 'pages/more.dart';

scheduleDeletingofLists() {
  final cron = Cron();
  cron.schedule(Schedule.parse('*/1 * * * *'), () async {});
  cron.schedule(Schedule.parse('* 00 * * *'), () async {
    print('Deleting all the Toooooodooolees');
    await todoBox.clear();
    await completedBox.clear();
    print(todoBox.length);
    print(completedBox.length);
    totalTodoCount.value = 10;
  });
}

// deletingWeatherData() {
//   final cron = Cron();
//   cron.schedule(Schedule.parse('*/1 * * * *'), () async {
//     print("thisis si ${weatherBox.get("weather")}");
//   });
// }

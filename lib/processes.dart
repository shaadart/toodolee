import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:locally/locally.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toodo/main.dart';
import 'package:toodo/pages/tommorownotification.dart';
import 'package:workmanager/workmanager.dart';

const deleteweatherdata = "deletingweatherData";
const deletequotesdata = "deletingquotesData";
const deletelistdata = "deletinglistsData";

setDailyRemainderMethod(timing, context) {
  // DateTime now = DateTime.now();

  // String formattedDate = DateFormat('kk:mm:ss').format(now);

  // String removeunwantedSymbolsfromRemainderTime =
  //     timing.replaceAll(":", ""); //14:13
  // String removeunwantedSymbolsfromCurrentTime =
  //     formattedDate.replaceAll(":", ""); //1413
  // int currentTime = int.parse(removeunwantedSymbolsfromCurrentTime);
  // int remainderTime = int.parse(removeunwantedSymbolsfromRemainderTime);

  // int timeRemaining = (remainderTime * 60) - currentTime;

  var splittingthevariable = timing.split(":");

  var hour = splittingthevariable.first;
  var minute = splittingthevariable.last;

  var time = Time(hour, minute, 0);
  //
  Locally locally = Locally(
    context: context,
    payload: 'test2',

    //pageRoute: MaterialPageRoute(builder: (context) => MorePage(title: "Hey Test Notification", message: "You need to Work for allah...")),
    appIcon: 'toodoleeicon',

    pageRoute: MaterialPageRoute(builder: (BuildContext context) {
      return DefaultedApp();
    }),
  );

  locally.showDailyAtTime(
    title: 'Write Toodoolee For Today',
    message:
        "Stay Productive throughout the Day, Start Writing the Todoolee Now and...",
    time: Time(11, 35, 1),
    suffixTime: true,
  );
}
// void callbackDispatcher() {
//   Workmanager.executeTask((task, inputdata) async {
//     print('Deleting all the Toooooodooolees');
//     await todoBox.clear();
//     await completedBox.clear();
//     print(todoBox.length);
//     print(completedBox.length);
//     totalTodoCount.value = 10;

//     //Return true when the task executed successfully or not
//     return Future.value(true);
//   });
// }

// void deletingWeatherData() {
// // this method will be called every hour
//   Workmanager.executeTask((task, inputdata) async {
//     switch (task) {
//       case deleteweatherdata:
//         print("thisis si ${weatherBox.get("weather")[0]}");
//         weatherBox.delete("weatherofuser");
//         break;

//       case Workmanager.iOSBackgroundTask:
//         print("iOS background fetch delegate ran");
//         break;
//     }

//     //Return true when the task executed successfully or not
//     return Future.value(true);
//   });
// }

// void deletingQuotesData() {
//   Workmanager.executeTask((task, inputdata) async {
//     switch (task) {
//       case deletequotesdata:
//         quotesBox.delete("quote");
//         print("thisis si ${quotesBox.get("quote")[0]}");
//         break;

//       case Workmanager.iOSBackgroundTask:
//         print("iOS background fetch delegate ran");
//         break;
//     }

//     //Return true when the task executed successfully or not
//     return Future.value(true);
//   });
// }

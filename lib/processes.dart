import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toodo/main.dart';
import 'package:toodo/pages/quotes.dart';
import 'package:toodo/pages/settingsPage/settingspagedefault.dart';
import 'package:toodo/pages/tommorownotification.dart';


const deleteweatherdata = "deletingweatherData";
const deletequotesdata = "deletingquotesData";
const deletelistdata = "deletinglistsData";



// 
// void callbackDispatcher() {}
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
// ignore: camel_case_types
// class scheduleNotificationRemainders {
//   String time;
//   String name;
//   int id;

//   scheduleNotificationRemainders(this.time, this.name, this.id);
//   setRemainderMethod(time, name, id, context) async {
//     if (settingsBox.get("remainderNotifications") == true) {
//       print("This is the ID here $this.id");
//       DateTime now = DateTime.now();

//       String formattedDate =
//           DateFormat('kk:mm').format(now); // 10:43 => "10:43"

//       String removeunwantedSymbolsfromRemainderTime =
//           (this.time).replaceAll(":", ""); //1413
//       String removeunwantedSymbolsfromCurrentTime =
//           formattedDate.replaceAll(":", ""); //1044
//       int currentTime = int.parse(removeunwantedSymbolsfromCurrentTime);
//       int remainderTime = int.parse(removeunwantedSymbolsfromRemainderTime);

//       int timeRemaining = remainderTime - currentTime;
//       //
//       Locally locally = Locally(
//         context: context,
//         payload: '${name}',

//         //pageRoute: MaterialPageRoute(builder: (context) => MorePage(title: "Hey Test Notification", message: "You need to Work for allah...")),
//         appIcon: 'toodoleeicon',

//         pageRoute: MaterialPageRoute(builder: (BuildContext context) {
//           return DefaultedApp();
//         }),
//       );

//       locally.schedule(
//           channelID: (this.id).toString(),
//           channelName: "Remainder Notifications $id",
//           channelDescription:
//               "Sends you Notifications of the remainders you set $id",
//           title: '$this.id - ${name}',
//           message: "${name}, Remember to Work today",
//           androidAllowWhileIdle: true,
//           duration: Duration(minutes: timeRemaining));
//     } else {
//       print(
//           "Settings of Remainder Notification is set to the $remainderNotifications");
//     }
//   }
// }

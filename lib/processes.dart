import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const deleteweatherdata = "deletingweatherData";
const deletequotesdata = "deletingquotesData";
const deletelistdata = "deletinglistsData";
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

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/cupertino.dart';

// class NoticationService extends ChangeNotifier {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future initialize() async {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings("toodoleeicon");

//     IOSInitializationSettings iosInitializationSettings =
//         IOSInitializationSettings();

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future scheduledNotification() async {
//     var interval = RepeatInterval.everyMinute,
//         bigPicture = BigPictureStyleInformation(
//             DrawableResourceAndroidBitmap("toodoleeicon"),
//             largeIcon: DrawableResourceAndroidBitmap("toodoleeicon"),
//             contentTitle: "Hey Do this..",
//             summaryText: "Hey you seriously need to do it",
//             htmlFormatContentTitle: true);
//     var android = AndroidNotificationDetails("id", "channel", "description",
//         styleInformation: bigPicture);
//     var platform = NotificationDetails(
//       android: android,
//     );
//     await _flutterLocalNotificationsPlugin.periodicallyShow(
//         0, "Scheduled Notification", "Go and Work", interval, platform);
//   }

//   Future cancelNotification() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//   }
// }

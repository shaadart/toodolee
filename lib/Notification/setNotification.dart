// Sets the Remainder Notification
import 'package:awesome_notifications/awesome_notifications.dart';

import '../main.dart';




setRemainderMethod(time, String name, id, context) {
  // In the settings, If remainderNotifications will be true, then only the Remanders will be set, 
  // OtherWise, Nooooo No ono ono no no.
  if (settingsBox.get("remainderNotifications") == true) {
    int hour = time.first; // getting the hour of notification, user wanted to set
    print(hour);

    int minute = time.last; // getting the minute for same reason
    print(minute);

    AwesomeNotifications().createNotification( //the contents of it.
        content: NotificationContent(
            id: id,
            channelKey: 'remainderNotific',
            title: "$name",
            body: "Today, $hour:$minute"),
        actionButtons: [
          NotificationActionButton(
            key: 'COMPLETED',
            label: 'Do it',
            autoCancel: true,
            buttonType: ActionButtonType.KeepOnTop,
          ),
        ],
        schedule: NotificationCalendar( // schedule
          hour: hour,
          minute: minute,
          allowWhileIdle: true,
          timeZone: AwesomeNotifications.localTimeZoneIdentifier,
        ));
  }
}

setDailyRemainderMethod(time, context) {
  int hour = int.parse(time.first);
  print(hour);

  int minute = int.parse(time.last);
  print(minute);
  if (settingsBox.get("dailyNotifications") == true) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 50,
            channelKey: 'dailyNotific',
            title: "Champion this Day 🏆",
            body: "Tap to and write toodo"),
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          allowWhileIdle: true,
          repeats: true, // This will help it repeat daily.
          timeZone: AwesomeNotifications.localTimeZoneIdentifier,
        ));
  }
}

setStreakRemainderMethod(time, name, emoji, id, context) {
  int hour = time.first;
  print(hour);

  int minute = time.last;
  print(minute);

  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'streakNotific',
          title: emoji == "null" ? "$name" : "$name $emoji", // if user has not set emoji, then only name will be shown, if user has set, name and emoji both will be shown together.
          body: "Save the Streak, its $hour:$minute"), 
      schedule: NotificationCalendar(
        hour: hour,
        minute: minute,
        allowWhileIdle: true,
        repeats: true, // This will help it repeat daily.
        timeZone: AwesomeNotifications.localTimeZoneIdentifier,
      ));
}




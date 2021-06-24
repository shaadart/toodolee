import 'package:awesome_notifications/awesome_notifications.dart';
import '../main.dart';

// Sets the Remainder Notification
setRemainderMethod(time, String name, id, context) {
  // In the settings, If remainderNotifications will be true, then only the Remanders will be set,
  // OtherWise, Nooooo No ono ono no no.
  if (settingsBox.get("remainderNotifications") == true) {
    int hour = time.first;
    // getting the hour of notification, user wanted to set.
    // ex, time is [3, 00] so, ".first" will take the first element. hence, 3 is the hour

    int minute = time.last;
    // getting the minute for same reason.
    // getting the minute of notification, user wanted to set.
    // ex, time is [3, 00] so, ".last" will take the last element. hence, 0 is the minute

    AwesomeNotifications().createNotification(
        //the contents of it.
        content: NotificationContent(
            id: id, //id
            channelKey: 'remainderNotific',
            title: "$name",
            body: minute.toString().length ==
                    1 //getting the length of the minute, and checking if it is 1
                ? "Today, $hour:0$minute" // if it is One, we are adding Zero at the start of the minute and
                : "Today, $hour:$minute"), //if the minute is two digited then we are doing nothing. (showing as it is.)

                                /*
                                  The problem Comes, when the Body looks like when the Notification poooops down,
                                  Tap and write toodo, 4:0, now it should be looking 4:00, It looks, 4:0 which is looking like one of the verse of the Holy Book. :hehe, 
                                  also minute part does not creates trouble-ing, when the minute is like 45, 11, etc, (two digited)
                                  it troubles when the minute is like 01, 05, 08... etc. ex, 4:09 will be written by the notification as 4:9,
                                  So What we are doing is, getting the length of the minute,
                                  if the length of minute is One, we are adding Zero at the start of the minute and
                                  if the minute is two digited then we are doing nothing. (showing as it is.)
                                  
                                */
        actionButtons: [
          NotificationActionButton(
            key: 'COMPLETED',
            label: 'Do it',
            autoCancel: true,
            buttonType: ActionButtonType.KeepOnTop,
          ),
        ],
        schedule: NotificationCalendar(
          // schedule
          hour: hour,
          minute: minute,
          allowWhileIdle: true,
          timeZone: AwesomeNotifications.localTimeZoneIdentifier, //local Time
        ));
  }
}

setDailyRemainderMethod(time, context) {
  int hour = time.first;
  // getting the hour of notification, user wanted to set.
  // ex, time is [2, 50] so, ".first" will take the first element. hence, 2 is the hour

  int minute = time.last;
  // getting the minute of notification, user wanted to set.
  // ex, time is [2, 50] so, ".last" will take the last element. hence, 50 is the minute

  if (settingsBox.get("dailyNotifications") == true) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 5000,
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
  if (settingsBox.get("remainderNotifications") == true) {
    int hour = time.first;
    // getting the hour of notification, user wanted to set.
    // ex, time is [6, 10] so, ".first" will take the first element. hence, 6 is the hour

    int minute = time.last;
    // getting the minute for same reason.
    // getting the minute of notification, user wanted to set.
    // ex, time is [6, 10] so, ".last" will take the last element. hence, 10 is the minute

    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'streakNotific',
            title: emoji == "null" // if user has set no emooji
                ? "$name" // show the name of the tooodooleee only
                : "$name $emoji", //Show name and emoji, if the both name and emoji is not Null
            // if user has not set emoji, then only name will be shown, if user has set, name and emoji both will be shown together.

            // The problem Comes, when the Body looks like when the Notification poooops down,
            // Today, 4:0, now it should be looking 4:00, It looks, 4:0 which is looking like one of the verse of the Holy Book. :hehe, also it doesnot troubles, when the minute is like 45, 11, etc, (two digited)
            // So What we are doing is, getting the length of the minute,
            //if it is One, we are adding Zero at the start of the minute and
            //if the minute is two digited then we are doing nothing. (showing as it is.)
            body: minute.toString().length == 1
                ? "Save the Streak, its $hour:0$minute"
                : "Save the Streak, its $hour:$minute"),
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          allowWhileIdle: true,
          repeats: true, // This will help it repeat daily.
          timeZone: AwesomeNotifications.localTimeZoneIdentifier,
        ));
  }
}

getRemainderTime(time, context) {
  if (time.contains("PM") == true) {
    // if the time has PM, ex 4:00 pm
    var splittingSpace = time.split(" "); //Splitting it, ["4:00", "pm"]
    var removePM = splittingSpace.removeAt(0); // Remove the PM, ex, ["4:00"]

    var removeUnwantedSymbol =
        removePM.split(":"); // Remove : Symbol, ex, ["4" ,"00"]

    Map convertTimetotwentyFourHourClock = {
      1: 13, // 1 pm can be written as 13
      2: 14, // 2 pm can we written as 14
      3: 15,
      4: 16,
      5: 17,
      6: 18,
      7: 19,
      8: 20,
      9: 21,
      10: 22, //10 pm can we written as 22
      11: 23, // 11 pm can we written as 23
      12: 12
    };
    var hourToBeChanged = int.parse(removeUnwantedSymbol
        .first); //it's no need to change the minute element, it does depended upon the hour one, ex, 4

    var hour = convertTimetotwentyFourHourClock[
        hourToBeChanged]; // Acording to the key it will change according to the value, ex, 16
    var minute =
        removeUnwantedSymbol.last; // the minute will be the same, ex, 00

    var remainderTime = [
      hour.toString(),
      minute.toString()
    ]; //Setting the hour and minute in the List. ex, ["16","00"]
    print(remainderTime); // ex, ["16","00"]
    print(hour); //16
    print(minute); //00

    return [
      int.parse(remainderTime[0]),
      int.parse(remainderTime[1])
    ]; //Converted to Int (each Tings) so to set Remainder Notifications, ex, [16, 0]
  } else if (time.contains("AM") == true) {
    // if it has AM in the Remainder, ex, 10:00 AM,
    var splittingSpace =
        time.split(" "); // Spilt the Spaces. ex, ["10:00", "AM"]
    var removeAM =
        splittingSpace.removeAt(0); // Remove the AM keyword, ex, ["10:00"]

    var remainderTime =
        removeAM.split(":"); // Remove the ":" keyword, ex, ["10","00"]
    return [
      int.parse(remainderTime[0]),
      int.parse(remainderTime[1])
    ]; //Converted to Int (each Tings) so to set Remainder Notifications, ex, [10, 0]
  } else if (time.contains("AM") == false && time.contains("PM") == false) {
    //if it is 24 hrs clock, ex, 18:00
    var remainderTime =
        time.split(":"); //split the by the patters of ":". ex, ["18", "00"]
    return [
      int.parse(remainderTime[0]),
      int.parse(remainderTime[1])
    ]; //Converted to Int (each Tings) so to set Remainder Notifications. ex, [18, 0]
  }
}

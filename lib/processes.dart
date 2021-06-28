import 'package:jiffy/jiffy.dart';
import 'package:toodo/Notification/NotificationsCancelAndRestart.dart';
import 'package:toodo/main.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'uis/quotes.dart';

/*
# Clears Toodos Next Day
# Clears Completed Ones Next day
# Resets Quotes
# Reset Boring Card.

This will Reset the Toodolee.
This is kind of better version of background Tasks.

I was litterelly Tired of Seeing WORKMANAGER or any other background service not working.
So, Thanks to the Nature and Lord, this Came to the Head,

This is the Method/Function checks wheather the today's date, month's first day and it predicts weather to reset-up the Toodolee or not 
*/
resetToodoleeMidNight(context) {
  /* if today's Date is null or month's first day is null, then,
  put the today's date inside the memory or today's date Box, and do same with the month's first day (Hive)

  in the month's first day case, using jiffy package from pub.dev, It shows when the next month's first day will going to be.
  We are checking next month's first day because the calender works from 1 - 30 or 31 sometimes or 28 we have to predict it already,
  and because the toodolee checks the dates sequence wise, if today is 15 the next should be 16 and if it is 16 then the next day must be  17, 
  if it is then Toodolee will be resetted, and suppose it's 30th of April today and next day is 1st of May.  

  and Clear up the Toodos, Boring Card, Quotes etc.
*/
  if (settingsBox.get("todayDate") == null ||
      settingsBox.get("monthFirstDay") == null) {
    DateTime now = DateTime.now();

    var year = now.year; // now year
    var month = now.month; // now month
    var day = now.day; // now day

    settingsBox
        .put("todayDate", [year, month, day]); // put the date in Local Storage

    var endOfMonthDaysRemaining =
        Jiffy().endOf(Units.MONTH).fromNow().split(" ");
    var checkWhentheMonthwillEnd = Jiffy().add(
        duration: Duration(
            days: endOfMonthDaysRemaining[1] == "a"
                ? 30
                : int.parse(endOfMonthDaysRemaining[1])));
    print(endOfMonthDaysRemaining[1]);
    print(checkWhentheMonthwillEnd.yMMMMd);
    var nextMonthYear = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").year;
    var nextMonthMonth = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").month;
    var nextMonthDay = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").date;

    print(nextMonthMonth);
    print(nextMonthDay);
    print(nextMonthYear);
    // var monthFirstDay = formatDate(
    //     DateTime(nextMonthYear, nextMonthMonth, nextMonthDay),
    //     [yy, ' ', M, ' ', d]).split(" ");
    settingsBox
        .put("monthFirstDay", [nextMonthYear, nextMonthMonth, nextMonthDay]);

    for (final key in todoBox.keys.toList()) {
      var toodo = todoBox.get(key);

      if (todoBox.length > 0) {
        print(" cancelling the notifications of ${toodo.todoName}");

        cancelReminderNotifications(toodo.todoReminder, context);

        todoBox.delete(key);
      }
    }

    completedBox.clear();
    deleteQuotes();
    boredBox.clear();
    totalTodoCount.value = 10 - streakBox.length;
    resetStreakMidNight(context);
    // streako.isCompleted = false;
    print("everything is reset-ed");
  } else {
    DateTime now = DateTime.now();

    var year = now.year;
    var month = now.month;
    var day = now.day;
    var endOfMonthDaysRemaining =
        Jiffy().endOf(Units.MONTH).fromNow().split(" ");
    var checkWhentheMonthwillEnd = Jiffy().add(
        duration: Duration(
            days: endOfMonthDaysRemaining[1] == "a"
                ? 30
                : int.parse(endOfMonthDaysRemaining[1])));
    print(endOfMonthDaysRemaining[1]);
    print(checkWhentheMonthwillEnd.yMMMMd);
    var nextMonthYear = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").year;
    var nextMonthMonth = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").month;
    var nextMonthDay = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").date;
    if ((year == settingsBox.get("todayDate")[0] &&
            month == settingsBox.get("todayDate")[1] &&
            day == settingsBox.get("todayDate")[2]) ||
        (nextMonthYear == settingsBox.get("monthFirstDay")[0] &&
            nextMonthMonth == settingsBox.get("monthFirstDay")[0] &&
            nextMonthDay == settingsBox.get("monthFirstDay")[2])) {
      print("nothing to do");
    } else {
      for (final key in todoBox.keys.toList()) {
        var toodo = todoBox.get(key);

        if (todoBox.length > 0) {
          print(" cancelling the notifications of ${toodo.todoName}");

          cancelReminderNotifications(toodo.todoReminder, context);

          todoBox.delete(key);
        }
      }

      completedBox.clear();
      deleteQuotes();
      boredBox.clear();
      totalTodoCount.value = 10 - streakBox.length;
      resetStreakMidNight(context);
      // streako.isCompleted = false;
      print("everything is reset-ed");
      settingsBox.put("todayDate", [year, month, day]);
      settingsBox
          .put("monthFirstDay", [nextMonthYear, nextMonthMonth, nextMonthDay]);
    }
  }
}

/*
# Clears The Streaks Next Day
# If One Streak is Completed, then it will be moved to Incompleted with the count of +1.
# If the Streak is not Completed by use it will be Deleted.

Works similar to the resetToodoleeMidnight() Method also the Template is also identical.

*/

resetStreakMidNight(context) {
  if (settingsBox.get("todayDate") == null ||
      settingsBox.get("monthFirstDay") == null ||
      settingsBox.get("nextDay") == null) {
    DateTime now = DateTime.now();

    var year = now.year;
    var month = now.month;
    var day = now.day;

    var nextDayDate = Jiffy()
        .add(duration: Duration(days: 1))
        .yMMMMd
        .replaceAll(",", "")
        .split(" ");
    print(nextDayDate);

    var endOfMonthDaysRemaining =
        Jiffy().endOf(Units.MONTH).fromNow().split(" ");
    var checkWhentheMonthwillEnd = Jiffy().add(
        duration: Duration(
            days: endOfMonthDaysRemaining[1] == "a"
                ? 30
                : int.parse(endOfMonthDaysRemaining[1])));
    print(endOfMonthDaysRemaining[1]);
    print(checkWhentheMonthwillEnd.yMMMMd);
    var nextMonthYear = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").year;
    var nextMonthMonth = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").month;
    var nextMonthDay = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").date;

    print(nextMonthMonth);
    print(nextMonthDay);
    print(nextMonthYear);

    settingsBox.put("todayDate", [year, month, day]);
    settingsBox.put("nextDayDate", nextDayDate[1]);
    settingsBox
        .put("monthFirstDay", [nextMonthYear, nextMonthMonth, nextMonthDay]);

    /*
      checks if the streak is completed it will be updated to incompleted next day.
      if it is not, it will be deleted
*/

    for (final key in streakBox.keys.toList()) {
      var streak = streakBox.get(key);

      if (streak.isCompleted) {
        streak.isCompleted = false;
        restartStreakNotifications(streak.streakName, streak.streakEmoji,
            streak.streakReminder, context);
        streakBox.put(key, streak);
      } else {
        cancelStreakNotifications(streak.streakReminder, context);
        streakBox.delete(key);
      }
    }

    print("everything is reset-ed");
  } else {
    DateTime now = DateTime.now();

    var year = now.year;
    var month = now.month;
    var day = now.day;
    var endOfMonthDaysRemaining =
        Jiffy().endOf(Units.MONTH).fromNow().split(" ");
    var checkWhentheMonthwillEnd = Jiffy().add(
        duration: Duration(
            days: endOfMonthDaysRemaining[1] == "a"
                ? 30
                : int.parse(endOfMonthDaysRemaining[1])));
    print(endOfMonthDaysRemaining[1]);
    print(checkWhentheMonthwillEnd.yMMMMd);
    var nextMonthYear = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").year;
    var nextMonthMonth = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").month;
    var nextMonthDay = Jiffy(checkWhentheMonthwillEnd, "MMM dd yy").date;

    var nextDayDate = Jiffy()
        .add(duration: Duration(days: 1))
        .yMMMMd
        .replaceAll(",", "")
        .split(" ");
    print(nextDayDate);
    if (day == settingsBox.get("nextDayDate")) {
      /*
      checks if the streak is completed it will be updated to incompleted next day.
      if it is not, it will be deleted
*/

      for (final key in streakBox.keys.toList()) {
        var streak = streakBox.get(key);

        if (streak.isCompleted) {
          streak.isCompleted = false;
          restartStreakNotifications(streak.streakName, streak.streakEmoji,
              streak.streakReminder, context);
          streakBox.put(key, streak);
        } else {
          cancelStreakNotifications(streak.streakReminder, context);
          streakBox.delete(key);
        }
      }

      print("everything is reset-ed");
      settingsBox.put("todayDate", [year, month, day]);
      settingsBox
          .put("monthFirstDay", [nextMonthYear, nextMonthMonth, nextMonthDay]);
      settingsBox.put("nextDayDate", nextDayDate[1]);
    }
  }
}

import 'package:jiffy/jiffy.dart';
import 'package:toodo/main.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'uis/quotes.dart';

resetToodoleeMidNight(context) {
  if (settingsBox.get("todayDate") == null ||
      settingsBox.get("monthFirstDay") == null) {
    DateTime now = DateTime.now();

    var year = now.year;
    var month = now.month;
    var day = now.day;

    settingsBox.put("todayDate", [year, month, day]);

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

    todoBox.clear();
    completedBox.clear();
    deleteQuotes();
    boredBox.clear();
    totalTodoCount.value = 10;
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
      todoBox.clear();
      completedBox.clear();
      deleteQuotes();
      boredBox.clear();
      totalTodoCount.value = 10;
      resetStreakMidNight(context);
      // streako.isCompleted = false;
      print("everything is reset-ed");
      settingsBox.put("todayDate", [year, month, day]);
      settingsBox
          .put("monthFirstDay", [nextMonthYear, nextMonthMonth, nextMonthDay]);
    }
  }
}

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

    print(streakBox.keys.toList());
    for (final key in streakBox.keys.toList()) {
      var streak = streakBox.get(key);

      if (streak.isCompleted) {
        streak.isCompleted = false;
        streakBox.put(key, streak);
      } else {
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
      print(streakBox.keys.toList());
      for (final key in streakBox.keys.toList()) {
        var streak = streakBox.get(key);

        if (streak.isCompleted) {
          streak.isCompleted = false;
          streakBox.put(key, streak);
        } else {
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

import 'package:date_format/date_format.dart';
import 'package:jiffy/jiffy.dart';
import 'package:toodo/main.dart';
import 'package:toodo/uis/Streak/streakCompletedUi.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';

import 'uis/Streak/streakListUi.dart';

// resetStreakMidNight(context) {
//   if (settingsBox.get("todayDate") == null &&
//       settingsBox.get("nextDayDate") == null) {
//     DateTime now = DateTime.now();

//     var year = now.year;
//     var month = now.month;
//     var day = now.day;

//     var nextDayDate = Jiffy()
//         .add(duration: Duration(days: 1))
//         .yMMMMd
//         .replaceAll(",", "")
//         .split(" ");
//     print(nextDayDate);

//     settingsBox.put("todayDate", [year, month, day]);
//     settingsBox.put("nextDayDate", nextDayDate[1]);

//     compStreak.isCompleted = false;
//     compStreak.save();
//     print("ran the completed == true");

//     // streako.isCompleted = false;
//     print("streak is reset-ed");
//   } else {
//     DateTime now = DateTime.now();

//     var year = now.year;
//     var month = now.month;
//     var day = now.day;

//     if ((year == settingsBox.get("todayDate")[0] &&
//             month == settingsBox.get("todayDate")[1] &&
//             day == settingsBox.get("todayDate")[2]) ||
//         (year == settingsBox.get("monthFirstDay")[0] &&
//             settingsBox.get("monthFirstDay")[1] == month &&
//             settingsBox.get("monthFirstDay")[2] == day) ||
//         (settingsBox.get("nextDayDate") == settingsBox.get("todayDate")[2])) {
//       print("nothing to do");
//     } else {
//       compStreak.isCompleted = false;
//       compStreak.save();
//       print("ran the completed streak");
//     }
//   }
// }

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
    // var monthFirstDay = formatDate(
    //     DateTime(nextMonthYear, nextMonthMonth, nextMonthDay),
    //     [yy, ' ', M, ' ', d]).split(" ");
    settingsBox.put("todayDate", [year, month, day]);
    settingsBox.put("nextDayDate", nextDayDate[1]);
    settingsBox
        .put("monthFirstDay", [nextMonthYear, nextMonthMonth, nextMonthDay]);

    //deleteStreakfromCompleted(context);
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
    } else if (day == settingsBox.get("nextDay")) {
      //deleteStreakfromCompleted(context);
      print("everything is reset-ed");
      settingsBox.put("todayDate", [year, month, day]);
      settingsBox
          .put("monthFirstDay", [nextMonthYear, nextMonthMonth, nextMonthDay]);
    } else if (((year != settingsBox.get("todayDate")[0] &&
                month != settingsBox.get("todayDate")[1] &&
                day != settingsBox.get("todayDate")[2]) ||
            (nextMonthYear != settingsBox.get("monthFirstDay")[0] &&
                nextMonthMonth != settingsBox.get("monthFirstDay")[0] &&
                nextMonthDay != settingsBox.get("monthFirstDay")[2])) ||
        //streako.streakName == null ||
        settingsBox.get("nextDayDate") != day) {
      streakBox.clear();
      completedStreakBox.clear();
    }
  }
}

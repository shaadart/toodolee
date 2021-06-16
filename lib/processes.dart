import 'package:date_format/date_format.dart';
import 'package:jiffy/jiffy.dart';
import 'package:toodo/main.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';

import 'uis/quotes.dart';


resetToodoleeMidNight() {
  if (settingsBox.get("todayDate") == null) {
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
    var nextMonthYear = Jiffy(checkWhentheMonthwillEnd, "MMM dd, yy").year;
    var nextMonthMonth = Jiffy(checkWhentheMonthwillEnd, "MMM dd, yy").month;
    var nextMonthDay = Jiffy(checkWhentheMonthwillEnd, "MMM dd, yy").date;

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
    var nextMonthYear = Jiffy(checkWhentheMonthwillEnd, "MMM dd, yy").year;
    var nextMonthMonth = Jiffy(checkWhentheMonthwillEnd, "MMM dd, yy").month;
    var nextMonthDay = Jiffy(checkWhentheMonthwillEnd, "MMM dd, yy").date;
    if ((year == settingsBox.get("todayDate")[0] &&
            month == settingsBox.get("todayDate")[1] &&
            day == settingsBox.get("todayDate")[2]) ||
        (settingsBox.get("monthFirstDay")[0] == nextMonthYear &&
            settingsBox.get("monthFirstDay")[1] == nextMonthMonth &&
            settingsBox.get("monthFirstDay")[2] == nextMonthDay)) {
      print("nothing to do");
    } else {
      todoBox.clear();
      completedBox.clear();
      deleteQuotes();
      boredBox.clear();
      totalTodoCount.value = 10;
      // streako.isCompleted = false;
      print("everything is reset-ed");
      settingsBox.put("todayDate", [year, month, day]);
      settingsBox
          .put("monthFirstDay", [nextMonthYear, nextMonthMonth, nextMonthDay]);
    }
  }
}

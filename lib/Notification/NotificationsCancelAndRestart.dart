import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:toodo/Notification/setNotification.dart';
import 'package:toodo/main.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';




cancelNotifications(reference, context) {
  if (reference.contains("PM") == true) {
    AwesomeNotifications().cancel(
      (getRemainderTime(reference, context).first +
          getRemainderTime(reference, context).last),
    );
  } else if (reference.contains("AM") == true) {
    AwesomeNotifications().cancel(
      (getRemainderTime(reference, context).first +
          getRemainderTime(reference, context).last),
    );
  } else if (reference.contains("AM") == false &&
      reference.contains("PM") == false) {
    AwesomeNotifications().cancel(
      (getRemainderTime(reference, context).first +
          getRemainderTime(reference, context).last),
    );
  }
}

restartRemainderNotifications(name, reference, context) {
  if (reference.contains("PM") == true) {
    setRemainderMethod(
        getRemainderTime(reference, context),
        name,
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last),
        context);
    print(
        "${((getRemainderTime(reference, context).first + getRemainderTime(reference, context).last))} is the current value of the channel id");
  } else if (reference.contains("AM") == true) {
    setRemainderMethod(
        getRemainderTime(reference, context),
        name,
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last),
        context);
    print(
        "${(getRemainderTime(reference, context).first + getRemainderTime(reference, context).last)} is the current value of the channel id");
  } else if (reference.contains("AM") == false &&
      reference.contains("PM") == false) {
    setRemainderMethod(
        getRemainderTime(reference, context),
        name,
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last),
        context);
    print(
        "${(getRemainderTime(reference, context).first + getRemainderTime(reference, context).last)} is the current value of the channel id");
  }
}

restartStreakNotifications(name, emoji, reference, context) {
  if (reference.contains("PM") == true) {
    setStreakRemainderMethod(
        getRemainderTime(reference, context),
        name,
        emoji,
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last * 100),
        context);
    print(
        "${getRemainderTime(reference, context).first + getRemainderTime(reference, context).last * 100}");
  } else if (reference.contains("AM") == true) {
    setStreakRemainderMethod(
        getRemainderTime(reference, context),
        name,
        emoji,
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last * 100),
        context);
    print(
        "${getRemainderTime(reference, context).first + getRemainderTime(reference, context).last * 100}");
  } else if (reference.contains("AM") == false &&
      reference.contains("PM") == false) {
    setStreakRemainderMethod(
        getRemainderTime(reference, context),
        name,
        emoji,
        (getRemainderTime(reference, context).first +
            getRemainderTime(reference, context).last * 100),
        context);
  }
}

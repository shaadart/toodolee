import 'package:flutter/material.dart';
import 'package:toodo/Notification/setNotification.dart';
import 'package:toodo/main.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final pages = [
      PageModel.withChild(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.shortestSide / 20),
                child: Center(
                  child: Text(
                    "You have got a Dream...",
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          color: Colors.amberAccent,
          doAnimateChild: false),
      PageModel.withChild(
          child: Center(
              child: Text("Packet it Daily",
                  style: Theme.of(context).textTheme.headline4)),
          color: Colors.blue,
          doAnimateChild: true),
      PageModel.withChild(
          child: Center(
              child: Text("Open it Daily,",
                  style: Theme.of(context).textTheme.headline4)),
          color: Colors.yellow,
          doAnimateChild: true),
    ];

    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: false,
        skipCallback: () {
          // set reminderNotifications be true,
          //it will let the app set Reminders, You can check the pages/settingspage.dart there in it the reminderNotification must have true as the value to let the user set the reminder notifications, otherwise the remiander will not ring.
          settingsBox.put("reminderNotifications", true);
          settingsBox.put("dailyNotifications",
              true); //set the daily notifications be true, with this you can get daily notifications for writing the Toodolee, so to create a Habit,
          setDailyReminderMethod([
            //daily Reminder Notification takes the hour and minute in inside the list.
            6,
            30
          ], context); // as in the start the Daily Notifications will have null as the value, so default is 6:30 when the daily alarm will ring (you can change time from settings Page inside the app)
          player.play(
            'sounds/hero_decorative-celebration-03.wav',
            stayAwake: false,
          );
          // onboardingBox is what store True or False as the value, if it is true the the on Boarding or most first welcomming screen is shown if it is false then it is not shown and the user will see the normal screeen that we all see.
          onboardingScreenBox.put('shownOnBoard', true);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DefaultedApp()),
          ); // Navigate to the main App. when the skip button is pressed.
        },
        finishCallback: () {
          // set reminderNotifications be true,
          //it will let the app set Reminders, You can check the pages/settingspage.dart there in it the reminderNotification must have true as the value to let the user set the reminder notifications, otherwise the remiander will not ring.
          settingsBox.put("reminderNotifications", true);
          settingsBox.put("dailyNotifications", true);
          //set the daily notifications be true, with this you can get daily notifications for writing the Toodolee, so to create a Habit,
          setDailyReminderMethod([
            6,
            30
          ], context); // as in the start the Daily Notifications will have null as the value, so default is 6:30 when the daily alarm will ring (you can change time from settings Page inside the app)
          player.play(
            'sounds/hero_decorative-celebration-03.wav',
            stayAwake: false,
          );
          // onboardingBox is what store True or False as the value, if it is true the the on Boarding or most first welcomming screen is shown if it is false then it is not shown and the user will see the normal screeen that we all see.
          onboardingScreenBox.put('shownOnBoard', true);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DefaultedApp()),
          );
        },
      ),
    );
  }
}

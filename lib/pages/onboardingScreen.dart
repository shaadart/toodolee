import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:toodo/main.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:toodo/pages/settingsPage/settingspagedefault.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final pages = [
      //Ghost White: 0xffF6F8FF
//Lemon Glacier :0xffFBFB0E
//Rich Black: 0xff010C13
// Azure: 0xff4785FF
      PageModel.withChild(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset('assets/play football.jpg',
              //     width: MediaQuery.of(context).size.width / 1.5),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
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
                  style: Theme.of(context).textTheme.headline6)),
          color: Colors.blue,
          doAnimateChild: true),
      // PageModel.withChild(
      //     child: new Padding(
      //       padding: new EdgeInsets.only(bottom: 25.0),
      //       child: new Image.asset('assets/quotes.jpg',
      //           width: MediaQuery.of(context).size.width / 0.9,
      //           height: MediaQuery.of(context).size.width / 0.9),
      //     ),
      //     color: Colors.blue,
      //     doAnimateChild: true),
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
          
          Text("Skip clicked");
          Hive.box(settingsName).put("remainderNotifications", true);
          Hive.box(settingsName).put("dailyNotifications", true);
          setDailyRemainderMethod("6:30", context);
          player.play(
            'sounds/hero_simple-celebration-03.wav',
            stayAwake: false,

            // mode: PlayerMode.LOW_LATENCY,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DefaultedApp()),
          );
        },
        finishCallback: () {
          Hive.box(settingsName).put("remainderNotifications", true);
          Hive.box(settingsName).put("dailyNotifications", true);
          setDailyRemainderMethod("6:30", context);
          player.play(
            'sounds/hero_decorative-celebration-03.wav',
            stayAwake: false,
            // mode: PlayerMode.LOW_LATENCY,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DefaultedApp()),
          );
        },
      ),
    );
  }
}

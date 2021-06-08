import 'package:flutter/material.dart';
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
              //     width: MediaQuery.of(context).size.shortestSide / 1.5),
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
      // PageModel.withChild(
      //     child:   Padding(
      //       padding:   EdgeInsets.only(bottom: 25.0),
      //       child:   Image.asset('assets/quotes.jpg',
      //           width: MediaQuery.of(context).size.shortestSide / 0.9,
      //           height: MediaQuery.of(context).size.shortestSide / 0.9),
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
          settingsBox.put("remainderNotifications", true);
          settingsBox.put("dailyNotifications", true);
          setDailyRemainderMethod([6.toString(), 30.toString()], context);
          player.play(
            'sounds/hero_decorative-celebration-03.wav',
            stayAwake: false,
            // mode: PlayerMode.LOW_LATENCY,
          );
          onboardingScreenBox.put('shownOnBoard', true);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DefaultedApp()),
          );
        },
        finishCallback: () {
          settingsBox.put("remainderNotifications", true);
          settingsBox.put("dailyNotifications", true);
          setDailyRemainderMethod([6.toString(), 30.toString()], context);
          player.play(
            'sounds/hero_decorative-celebration-03.wav',
            stayAwake: false,
            // mode: PlayerMode.LOW_LATENCY,
          );
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

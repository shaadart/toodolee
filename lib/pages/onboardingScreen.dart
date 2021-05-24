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
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          content:
          Text("Skip clicked");
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

  final pages = [
    //Ghost White: 0xffF6F8FF
//Lemon Glacier :0xffFBFB0E
//Rich Black: 0xff010C13
// Azure: 0xff4785FF
    PageModel(
        color: const Color(0xff4785FF),
        imageAssetPath: 'assets/bitmojis/cat.png',
        title: 'Write Tooodoos',
        body:
            'Limit your Works to 10, To Give 100 to each Task. Toodolee is first in this kind',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xffFBFB0E),
        imageAssetPath: 'assets/bitmojis/hi 14.png',
        title: 'Weather Quotes and Progress',
        body: 'Pre-Plan your Day ahead',
        doAnimateImage: true),
    PageModel(
        color: Colors.green,
        imageAssetPath: 'assets/bitmojis/mario.png',
        title: 'End the Boredom',
        body:
            'Connect with the Productivity, End the Boredom after completion of your Ten Most Important Toodooleees.',
        doAnimateImage: true),
  ];
}

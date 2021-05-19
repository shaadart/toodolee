//  Container(
//                 child: AdWidget(
//                   key: UniqueKey(),
//                   ad: AdMobService.createBannerAd()..load,
//                 ),
//                 height: 50,
//               ),

import 'dart:io';
//import 'dart:html';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admob/flutter_admob.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';

import 'package:toodo/pages/bored.dart';
import 'package:toodo/pages/listspage.dart';
import 'package:toodo/pages/progressbar.dart';
import 'package:toodo/pages/quotes.dart';
import 'package:toodo/pages/settingsPage/ad-state.dart';
import 'package:toodo/pages/tommorownotification.dart';
import 'package:toodo/pages/weatherCard.dart';
import 'package:animate_do/animate_do.dart';

import 'package:toodo/main.dart';

//import "package:pexels/pexels.dart";
//import 'dart:async';

//List of Cards with color and icon

class WithLoveMoreComming extends StatelessWidget {
  const WithLoveMoreComming({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
      child: Opacity(
        opacity: 0.7,
        child: Text(" - With ❤️ More Cards are on the way ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              //color: Colors.black54,
              fontSize: 15,
            )),
      ),
    ));
  }
}

class AdTest extends StatefulWidget {
  @override
  _AdTestState createState() => _AdTestState();
}

class _AdTestState extends State<AdTest> {
  String _platformVersion = 'Unknown';
  Future<void> showAdMob(BuildContext ctx) async {
    if (Platform.isAndroid) {
      setState(() {
        _platformVersion = "Android";
      });
      try {
        await FlutterAdmob.init("ca-app-pub-3940256099942544~3347511713")
            .then((_) {
          // FlutterAdmob.banner.show(
          //   "ca-app-pub-3940256099942544/6300978111",
          //   // size: Size.FULL_BANNER,
          //   // gravity: Gravity.BOTTOM,
          //   //anchorOffset: 60,
          // );
          // FlutterAdmob.showInterstitial(
          //     "ca-app-pub-3940256099942544/1033173712");
          FlutterAdmob.showRewardVideo(
              "ca-app-pub-3940256099942544/5224354917");
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Builder(
      builder: (BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            floatingActionButton: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        showAdMob(context);
                      },
                    ),
                    FloatingActionButton(onPressed: () {
                      // FlutterAdmob.showBanner("ca-app-pub-3940256099942544/2934735716",
                      //   size: Size.SMART_BANNER,
                      //   gravity: Gravity.BOTTOM,
                      //   anchorOffset: 100,
                      // );
                    })
                  ],
                )));
      },
    ));
  }
}

class BackGroundTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData icondata;

  BackGroundTile({this.backgroundColor, this.icondata});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Icon(icondata, color: Colors.white),
    );
  }
}

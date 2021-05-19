import 'package:animate_do/animate_do.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:toodo/pages/listspage.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        color: Colors.white70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
              duration: Duration(milliseconds: 1200),
              child: Center(
                  child: Icon(CarbonIcons.checkmark,
                      size: 90, 
                      //color: Colors.black87
                      )),
            ),
            FadeOut(
                duration: Duration(milliseconds: 1100),
                child: Center(child: Text("Made by Proco :love"))),
          ],
        ),
      ),
    );
  }
}

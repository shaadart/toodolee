//import 'package:carbon_icons/carbon_icons.dart';
//import 'package:carbon_icons/carbon_icons.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';

import 'package:toodo/pages/bored.dart';

import 'package:toodo/pages/progressbar.dart';
import 'package:toodo/pages/quotes.dart';
import 'package:toodo/pages/tommorownotification.dart';
import 'package:toodo/pages/weatherCard.dart';
import 'package:animate_do/animate_do.dart';

import 'package:toodo/main.dart';

//import "package:pexels/pexels.dart";
//import 'dart:async';

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

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // Staggered Grid View starts here
          child: ListView(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  MediaQuery.of(context).size.width / 40,
                  0,
                  MediaQuery.of(context).size.width / 10),
              child: Quotes()),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width / 10),
              child: Bored()),
          WithLoveMoreComming()
        ],
      )),
    );
  }
}

//import 'package:carbon_icons/carbon_icons.dart';
//import 'package:carbon_icons/carbon_icons.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';

import 'package:toodo/pages/bored.dart';
import 'package:toodo/pages/listspage.dart';
import 'package:toodo/pages/progressbar.dart';
import 'package:toodo/pages/quotes.dart';
import 'package:toodo/pages/tommorownotification.dart';
import 'package:toodo/pages/weatherCard.dart';
import 'package:animate_do/animate_do.dart';

import 'package:toodo/main.dart';

//import "package:pexels/pexels.dart";
//import 'dart:async';

List<StaggeredTile> _cardTile = <StaggeredTile>[
  StaggeredTile.count(2, 4.5), //QuotesCard
  StaggeredTile.count(2, 2.5),

  StaggeredTile.count(2, 2.5),

  StaggeredTile.count(4, 2.6), //Text
  StaggeredTile.count(5, 2),
];

//List of Cards with color and icon
List<Widget> _listTile = <Widget>[
  Quotes(),
  Weathercard(),
  FadeInUp(child: ProgressBar()),
  // FadeInRight(child: TommorowNotification()),
  FadeInUp(child: Bored()),
  FadeInUp(
    child: WithLoveMoreComming(),
  ),
];

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
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          staggeredTiles: _cardTile,
          children: _listTile,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
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

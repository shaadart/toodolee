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
  StaggeredTile.count(2, 2.5),
  StaggeredTile.count(2, 4),
  StaggeredTile.count(2, 2.3),
  StaggeredTile.count(2, 1.3),
  //StaggeredTile.count(2, 1.5),

  StaggeredTile.count(4, 2.6),
  StaggeredTile.count(5, 2),
  // StaggeredTile.count(15, 1),
  // StaggeredTile.count(15, 1),
  // StaggeredTile.count(15, 1),
  // StaggeredTile.count(15, 1),
];

//List of Cards with color and icon
List<Widget> _listTile = <Widget>[
  Weathercard(),
  Quotes(),
  FadeInUp(child: ProgressBar()),
  FadeInRight(child: TommorowNotification()),
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
      child: Text(" - With ❤️ More Cards are on the way ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black54,
            fontSize: 15,
          )),
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

//  Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height / 1.6,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Expanded(
//                     child: Container(
//                   alignment: Alignment.topLeft,
//                   height: MediaQuery.of(context).size.height / 1,
//                   decoration: BoxDecoration(
//                       borderRadius:
//                           BorderRadius.only(bottomLeft: Radius.circular(12)),
//                       border: Border.all(color: Colors.blueAccent)),
//                   child: Text("Ss"),
//                 )),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(12)),
//                               color: Colors.amber.withOpacity(0.4),
//                               border: Border.all(color: Colors.blueAccent)),
//                           child: Text("Ss"),
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(),
//                             child: Center(
//                               child: Text(
//                                 "4/10" + " : " + "🏃",
//                                 style: TextStyle(
//                                     fontFamily: "Elsie",
//                                     fontWeight: FontWeight.w900,
//                                     fontSize: 30),
//                               ),
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListView(
//             children: [
//               ListTile(
//                 leading: Icon(
//                   CarbonIcons.add,
//                   color: Colors.red,
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),

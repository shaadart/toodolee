//import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//import "package:pexels/pexels.dart";
//import 'dart:async';
//
List<StaggeredTile> _cardTile = <StaggeredTile>[
  StaggeredTile.count(2, 2),
  StaggeredTile.count(2, 4),
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 1),
  StaggeredTile.count(15, 1),
  StaggeredTile.count(15, 1),
  StaggeredTile.count(15, 1),
  StaggeredTile.count(15, 1),
];

//List of Cards with color and icon
List<Widget> _listTile = <Widget>[
  BackGroundTile(
      backgroundColor: Colors.amberAccent.withOpacity(0.6),
      icondata: Icons.wb_sunny),
  BackGroundTile(
      backgroundColor: Colors.lightGreenAccent.withOpacity(0.6),
      icondata: Icons.lightbulb),
  BackGroundTile(
      backgroundColor: Colors.blueAccent.withOpacity(0.6),
      icondata: Icons.format_quote_sharp),
  BackGroundTile(
      backgroundColor: Colors.orangeAccent.withOpacity(0.6),
      icondata: Icons.check),
  BackGroundTile(
      backgroundColor: Colors.orangeAccent.withOpacity(0.6),
      icondata: Icons.check),
  BackGroundTile(
      backgroundColor: Colors.orangeAccent.withOpacity(0.6),
      icondata: Icons.check),
  BackGroundTile(
      backgroundColor: Colors.orangeAccent.withOpacity(0.6),
      icondata: Icons.check),
];

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.black54),
      elevation: 5,
      title: Text("More Page",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black54,
          )),
      backgroundColor: Colors.white,
    ));
    body:
    Container(
      // Staggered Grid View starts here
      child: ListView(
        children: [
          StaggeredGridView.count(
            crossAxisCount: 4,
            staggeredTiles: _cardTile,
            children: _listTile,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        ],
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

//import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
//import "package:pexels/pexels.dart";
//import 'dart:async';

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
        ),
        body: ListView(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    color: Colors.red,
                    child: Text("data"),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Expanded(
                    child: Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                          title: Text(
                            "The true way to render ourselves happy is to love our work and find in it our pleasure. ",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          subtitle: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "......",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]));
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

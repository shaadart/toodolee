// import 'dart:math';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:confetti/confetti.dart';
// import 'package:flutter/material.dart';
// import 'package:toodo/uis/bored.dart';
// import 'package:toodo/uis/quotes.dart';
// import 'package:toodo/uis/streakListUi.dart';

// class WithLoveMoreComming extends StatelessWidget {
//   const WithLoveMoreComming({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Padding(
//       padding: EdgeInsets.all(MediaQuery.of(context).size.shortestSide / 10),
//       child: Opacity(
//         opacity: 0.7,
//         child: Text(" - With ❤️ More Cards are on the way ",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontStyle: FontStyle.italic,
//               //color: Colors.black54,
//               fontSize: 15,
//             )),
//       ),
//     ));
//   }
// }

// class StreakPage extends StatefulWidget {
//   @override
//   _StreakPageState createState() => _StreakPageState();
// }

// class _StreakPageState extends State<StreakPage> {
  

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.longestSide / 1.5,
//       child: Stack(children: <Widget>[
//         //CENTER -- Blast
//         Align(
//           alignment: Alignment.center,
//           child: ConfettiWidget(
//             colors: [
//               Colors.green,
//               Theme.of(context).primaryColor,
//               Colors.redAccent,
//               Theme.of(context).accentColor,
//             ],
//             // colors: [
//             //   Theme.of(context).accentColor,
//             //   Theme.of(context).scaffoldBackgroundColor,
//             //   Theme.of(context).canvasColor,
//             //   Theme.of(context).primaryColor,
//             //   Theme.of(context).primaryColorLight,
//             //   Theme.of(context).primaryColorDark,
//             //   Theme.of(context).colorScheme.onSurface,
//             //   Theme.of(context).colorScheme.secondaryVariant
//             // ],
//             maximumSize: Size(20, 15),
//             shouldLoop: true,
//             confettiController: controllerbottomCenter,

//             blastDirectionality: BlastDirectionality.explosive,
//             maxBlastForce: 50, // set a lower max blast force
//             minBlastForce: 10, // set a lower min blast force
//             emissionFrequency: 0.5,
//             numberOfParticles: 2, // a lot of particles at once
//             gravity: 0.5,
//           ),
//         ),
//         buildButton()
//       ]),
//     );
//   }

//   Align buildButton() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 100),
//         child: RaisedButton(
//           onPressed: () {},
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           color: Colors.red,
//           textColor: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               "Congratulations!",
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

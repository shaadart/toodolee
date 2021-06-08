import 'package:flutter/material.dart';
import 'package:toodo/uis/bored.dart';
import 'package:toodo/uis/quotes.dart';
import 'package:toodo/uis/streakListUi.dart';

class WithLoveMoreComming extends StatelessWidget {
  const WithLoveMoreComming({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.shortestSide / 10),
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

class StreakPage extends StatefulWidget {
  @override
  _StreakPageState createState() => _StreakPageState();
}

class _StreakPageState extends State<StreakPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // Staggered Grid View starts here
          child: ListView(
        children: [StreakCard()],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:toodo/uis/bored.dart';
import 'package:toodo/uis/quotes.dart';

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
                  MediaQuery.of(context).size.shortestSide / 40,
                  0,
                  MediaQuery.of(context).size.shortestSide / 10),
              child: Quotes()),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.shortestSide / 10),
              child: Bored()),
          // Padding(
          //     padding: EdgeInsets.only(
          //         bottom: MediaQuery.of(context).size.shortestSide / 10),
          //     child: Weathercard()),
          WithLoveMoreComming()
        ],
      )),
    );
  }
}

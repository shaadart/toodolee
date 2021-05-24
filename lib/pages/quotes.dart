import 'dart:convert';
import 'dart:io';
//import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:davinci/davinci.dart';

import 'package:flutter/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
//import "package:permission_handler/permission_handler.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:path_provider/path_provider.dart';

import 'package:share/share.dart';

import 'package:toodo/main.dart';

// import 'package:screenshot/screenshot.dart'

class Quotes extends StatefulWidget {
  const Quotes({
    Key key,
  }) : super(key: key);

  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  int lengthofJSON = 1643;
  String quote =
      "For those real creators whose dreams are so big, in front of which a whole day is shortened.";
  String author = "@Universe";

  GlobalKey imageKey;
  int _counter = 0;

  getQuotes(context) async {
    final String response =
        await DefaultAssetBundle.of(context).loadString("jsons/quotes.json");
    var myquotes = json.decode(response);
    var rangeofQuotes = random(0, lengthofJSON);

    quotesBox.put("quote",
        [myquotes[rangeofQuotes]["text"], myquotes[rangeofQuotes]["author"]]);

    quote = quotesBox.get("quote")[0];
    author = quotesBox.get("quote")[1];

    print(quote);
    print(author);
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (getQuotes(context) == null ||
        quote == null ||
        author == null ||
        lengthofJSON == null) {
      return Container(
        child: Center(
          child: SizedBox(
            child: CircularProgressIndicator(),
            height: 60.0,
            width: 60.0,
          ),
        ),
      ); // I understand it will be empty for now
    } else {
      print(quote);
      //var randomMyQuotes = myquotes[0].shuffle().first;
      return FlipCard(
        key: cardKey,
        front: Davinci(builder: (key) {
          ///3. set the widget key to the globalkey
          this.imageKey = key;
          return Container(
            color: Colors.transparent,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              margin: EdgeInsets.all(0),
              // color: Colors.transparent,
              child: GradientCard(
                gradient: Gradients.buildGradient(
                    Alignment.topRight, Alignment.bottomLeft, [
                  Colors.blueAccent[700],
                  Colors.blue,
                  Colors.blueAccent[100],
                  // Colors.black54,
                  //  Colors.black87,
                  //  Colors.black87,
                ]),
                semanticContainer: false,
                child: Wrap(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 20)),
                          FadeIn(
                            duration: Duration(milliseconds: 2000),
                            child: Container(
                                child: Icon(CarbonIcons.quotes,
                                    color: Colors.white)),
                          ),
                          FadeInUp(
                            delay: Duration(milliseconds: 300),
                            duration: Duration(milliseconds: 1000),
                            child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 30),
                                child: Text("$quote",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: quote.length > //161
                                                90
                                            ? 15
                                            : 18))),
                          ),
                          FadeIn(
                            delay: Duration(milliseconds: 1000),
                            duration: Duration(milliseconds: 800),
                            child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 30),
                                child: Text(
                                    author == null ? "..." : "@${author}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic))),
                          )
                        ],
                      ),
                    ),
                    // Image.asset("arrow up.gif"),
                  ],
                ),
              ),
            ),
          );
        }),
        back: Card(
          // color: Colors.transparent,
          child: GradientCard(
            gradient: Gradients.buildGradient(
                Alignment.bottomRight, Alignment.topRight, [
              Colors.blueAccent[700],
              Colors.blue,
              Colors.blue[400],
              //Colors.blueAccent[700],
              // Colors.white,
            ]),
            semanticContainer: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 30),
                      child: Text("Share or Download",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ))),
                  FadeInUp(
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Center(
                                child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  player.play(
                                    'sounds/ui_tap-variant-01.wav',
                                    stayAwake: false,
                                    // mode: PlayerMode.LOW_LATENCY,
                                  );
                                  Share.share(
                                    "${quote} \n @${author} \n @ToodoleeApp",
                                  );
                                },
                                icon: Icon(CarbonIcons.share),
                              ),
                            )),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Center(
                                child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () async {
                                  cardKey.currentState.toggleCard();
                                  // String imagespath = "";
                                  await DavinciCapture.click(
                                    imageKey,
                                    saveToDevice: true,
                                    fileName:
                                        "Toodolee App ${DateTime.now().microsecondsSinceEpoch.toString()}",
                                    openFilePreview: true,
                                    albumName: "Toodolees",
                                    pixelRatio: 3,
                                  );

                                  print("Quote Captured");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.blue[200],
                                          content: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text("👍",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white))),
                                              Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    "Quotes, is captured sucessfully",
                                                  )),
                                              // FlatButton(
                                              //   child: Text("Undo"),
                                              //   color: Colors.white,
                                              //   onPressed: () async{
                                              //     await box.deleteAt(index);
                                              //     Navigator.pop(context);
                                              //   },
                                              // ),
                                            ],
                                          )));
                                },
                                icon: Icon(CarbonIcons.download),
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }
}

import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:davinci/davinci.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:share/share.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:toodo/main.dart';

int lengthofJSON = 1652;

class Quotes extends StatefulWidget {
  const Quotes({
    Key key,
  }) : super(key: key);

  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  GlobalKey quoteKey;
  bool showToolTip = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(quotesCardname).listenable(),
        builder: (context, quotes, _) {
          if (quotes.isEmpty) {
            getQuotes(context);
            // AndroidAlarmManager.oneShot(
            //     Duration(seconds: 30), 1, deleteQuotes());
            return Shimmer(
              duration: Duration(seconds: 1), //Default value
              interval:
                  Duration(seconds: 0), //Default value: Duration(seconds: 0)
              color: Theme.of(context).cardColor, //Default value
              enabled: true, //Default value
              direction: ShimmerDirection.fromLTRB(), //Default Value
              child: Container(
                height: MediaQuery.of(context).size.shortestSide / 2,
              ),
            );
            // I understand it will be empty for now
          } else {
            //var randomMyQuotes = myquotes[0].shuffle().first;

            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Davinci(builder: (key) {
                  ///3. set the widget key to the globalkey
                  this.quoteKey = key;
                  return Container(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showToolTip = !showToolTip;
                        });
                      },
                      child: Card(
                        margin: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),

                        // color: Colors.transparent,
                        child: GradientCard(
                          gradient: Gradients.buildGradient(
                              Alignment.topRight, Alignment.topLeft, [
                            Colors.blueAccent[700],
                            Color(0xff4785FF),
                            Colors.blue,
                            //Colors.blueAccent[100],

                            Colors.blue[500], Colors.blue[300]
                          ]),
                          semanticContainer: true,
                          child: Wrap(
                            children: [
                              WillPopScope(
                                onWillPop: () {
                                  if (showToolTip) {
                                    setState(() {
                                      showToolTip = false;
                                    });
                                  } else {
                                    Navigator.pop(context);
                                  }
                                  return Future.value(false);
                                },
                                child: Column(
                                  children: [
                                    Center(
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      12)),
                                          Container(
                                              child: Icon(CarbonIcons.quotes,
                                                  color: Colors.white)),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20),
                                            child: Container(
                                                child: Text(
                                                    "${quotes.get("quote")[0]}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: quotes
                                                                    .length > //161
                                                                90
                                                            ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                24
                                                            : MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                18))),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20),
                                            child: Container(
                                                child: Text(
                                                    quotes.get("quote")[1] ==
                                                            null
                                                        ? "..."
                                                        : "@${quotes.get("quote")[1]}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontStyle:
                                                            FontStyle.italic))),
                                          ),
                                          showToolTip == true
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              20),
                                                  child: toolTip(context),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              8),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                //   back: Card(
                //     // color: Colors.transparent,
                //     child: GradientCard(
                //       gradient: Gradients.buildGradient(
                //           Alignment.bottomRight, Alignment.topRight, [
                //         Colors.blueAccent[700],
                //         Colors.blue,
                //         Colors.blue[400],
                //         //Colors.blueAccent[700],
                //         // Colors.white,
                //       ]),
                //       semanticContainer: true,
                //       child: Center(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Container(
                //                 padding: EdgeInsets.all(
                //                     MediaQuery.of(context).size.shortestSide / 30),
                //                 child: Text("Share or Download",
                //                     textAlign: TextAlign.center,
                //                     style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 16,
                //                     ))),
                //             FadeInUp(
                //               child: Row(
                //                 children: [
                //                   Expanded(
                //                     child: Align(
                //                       alignment: Alignment.center,
                //                       child: Center(
                //                           child: CircleAvatar(
                //                         radius: 30,
                //                         backgroundColor: Colors.white,
                //                         child: IconButton(
                //                           onPressed: () {
                //                             player.play(
                //                               'sounds/ui_tap-variant-01.wav',
                //                               stayAwake: false,
                //                               // mode: PlayerMode.LOW_LATENCY,
                //                             );
                //                             Share.share(
                //                               "${quotes.get("quote")[0]} \n @${quotes.get("quote")[1]} \n @toodoleeApp",
                //                             );
                //                           },
                //                           icon: Icon(CarbonIcons.share),
                //                         ),
                //                       )),
                //                     ),
                //                   ),
                //                   Expanded(
                //                     child: Align(
                //                       alignment: Alignment.center,
                //                       child: Center(
                //                           child: CircleAvatar(
                //                         radius: 30,
                //                         backgroundColor: Colors.white,
                //                         child: IconButton(
                //                           onPressed: () async {
                //                             cardKey.currentState.toggleCard();
                //                             // String imagespath = "";
                //                             await DavinciCapture.click(
                //                               quoteKey,
                //                               saveToDevice: true,
                //                               fileName:
                //                                   "Toodolee App ${DateTime.now().microsecondsSinceEpoch.toString()}",
                //                               openFilePreview: true,
                //                               albumName: "Toodolees",
                //                               pixelRatio: 3,
                //                             );

                //                             print("Quote Captured");
                //                             ScaffoldMessenger.of(context)
                //                                 .showSnackBar(SnackBar(
                //                                     backgroundColor:
                //                                         Colors.blue[200],
                //                                     content: Row(
                //                                       children: [
                //                                         Expanded(
                //                                             flex: 1,
                //                                             child: Text("👍",
                //                                                 style: TextStyle(
                //                                                     color: Colors
                //                                                         .white))),
                //                                         Expanded(
                //                                             flex: 5,
                //                                             child: Text(
                //                                               "Quotes, is captured sucessfully",
                //                                             )),
                //                                         // MaterialButton(
                //                                         //   child: Text("Undo"),
                //                                         //   color: Colors.white,
                //                                         //   onPressed: () async{
                //                                         //     await box.deleteAt(index);
                //                                         //     Navigator.pop(context);
                //                                         //   },
                //                                         // ),
                //                                       ],
                //                                     )));
                //                           },
                //                           icon: Icon(CarbonIcons.download),
                //                         ),
                //                       )),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          }
        });
  }

  Widget toolTip(context) {
    return FadeIn(
        duration: Duration(milliseconds: 200),
        child: Opacity(
          opacity: 0.8,
          child: SpeechBubble(
              color: Theme.of(context).colorScheme.onSurface,
              nipLocation: NipLocation.TOP,
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                IconButton(
                  onPressed: () {
                    player.play(
                      'sounds/ui_tap-variant-01.wav',
                      stayAwake: false,
                      // mode: PlayerMode.LOW_LATENCY,
                    );
                    Share.share(
                      "${Hive.box(quotesCardname).get("quote")[0]} \n \n @${Hive.box(quotesCardname).get("quote")[1]} \n @toodolee",
                    );
                  },
                  icon: Icon(CarbonIcons.share,
                      color: Theme.of(context).cardColor),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                ),
                Container(
                    height: 20,
                    child: VerticalDivider(color: Theme.of(context).cardColor)),
                IconButton(
                  onPressed: () async {
                    setState(() {
                      showToolTip = false;
                    });
                    await Future.delayed(const Duration(seconds: 1), () {
                      DavinciCapture.click(
                        quoteKey,
                        saveToDevice: true,
                        fileName:
                            "Toodolee App ${DateTime.now().microsecondsSinceEpoch.toString()}",
                        openFilePreview: true,
                        albumName: "Toodolees",
                        pixelRatio: 3,
                      );
                    });

                    print("Quote Captured");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.blue[200],
                        content: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text("👍",
                                    style: TextStyle(color: Colors.white))),
                            Expanded(
                                flex: 5,
                                child: Text(
                                  "Quotes, is captured sucessfully",
                                )),
                          ],
                        )));
                    //
                  },
                  icon: Icon(CarbonIcons.download,
                      color: Theme.of(context).cardColor),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                )
              ])),
        ));
  }
}

getQuotes(context) async {
  final String response =
      await DefaultAssetBundle.of(context).loadString("jsons/quotes.json");
  var myquotes = json.decode(response);
  var rangeofQuotes = random(0, lengthofJSON);

  Hive.box(quotesCardname).put("quote",
      [myquotes[rangeofQuotes]["text"], myquotes[rangeofQuotes]["author"]]);
}

void deleteQuotes() {
  Hive.box(quotesCardname).clear();
  print("Quotes Fired");
}

random(min, max) {
  var rn = Random();
  return min + rn.nextInt(max - min);
}

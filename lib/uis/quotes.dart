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

/*

This is the Quotes UI which you see in the MorePage();

# Shows Quotes
# Updates Quotes
# Downloads Quotes
# Share Quotes

      
*/
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
  bool showToolTip =
      false; // First the tooltip should not annoy anyone, hence it is false.

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
            // if quotesBox is not having quotes, it will generate it.
            // While it generates, Let it Load with an Interface of Shimmering.

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
            // If the Quote is already there, and is not empty. then,

            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Davinci(builder: (key) {
                  // takes the screenshot.
                  //It is the screenshotting widget.
                  this.quoteKey = key;
                  return Container(
                    color: Colors.transparent,
                    child: GestureDetector(
                      // If it is Tapped, i.e Quotees Card, then Tool Tip will be shown,
                      onTap: () {
                        setState(() {
                          showToolTip = !showToolTip;
                          // If tooltip is false, Tooltip will bbe true and if it will be true it will become false.
                        });
                      },
                      child: Card(
                        margin: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
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
// Will Pop Scope will help when User clicks not in the Quotes Card else some where else, like App bar or something the Tool Tip will be changed to false.
// Like how Emoji Keyboard is Doing in addTodoBottomSheet.dart
                              WillPopScope(
                                onWillPop: () {
                                  if (showToolTip) {
                                    setState(() {
                                      showToolTip = false; //see
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
                                                    "${quotes.get("quote")[0]}", //This is the Main Quote, that is the final Product.
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        //fontsize is gonna be change according to the quotes letters length...
                                                        //If the Quote Letters are more than 90, i.e more than 90 letters, then the fontsize will be less.
                                                        // else if the Letters Count is less than 90 hence, the Font size will be large
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
                                                                20))),
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
                                                        : "@${quotes.get("quote")[1]}", // This is Quotes author.
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontStyle:
                                                            FontStyle.italic))),
                                          ),
                                          //If ToolTip is activiated, so to fit it beautifully the Tooltip changing some padding according to if the tool tip is on and off...
                                          if (showToolTip == true)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20),
                                              child: toolTip(context),
                                            )
                                          else
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
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
              ],
            );
          }
        });
  }

  // This is the design of the ToolTip, yes that downloading and sharing one.
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
                    );
                    Share.share(
                      "${Hive.box(quotesCardname).get("quote")[0]} \n \n @${Hive.box(quotesCardname).get("quote")[1]} \n @toodolee",
                    ); // How sharing works.
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
                    // This is how, downloading Works.

                    print("Quote Captured");

                    // Giving User feedback that, the workd they were doin is successful.. i.e Downloading of the Card.
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

// This Method gets the Quote, and is gamechanger.
// It gets JSON data from Local Assets,

getQuotes(context) async {
  final String response =
      await DefaultAssetBundle.of(context).loadString("jsons/quotes.json");
  var myquotes = json.decode(response); // this is the decoding of json
  var rangeofQuotes = random(0, lengthofJSON); // we are randomizing the quotes.

  Hive.box(quotesCardname).put("quote",
      [myquotes[rangeofQuotes]["text"], myquotes[rangeofQuotes]["author"]]);
} // putting the quotes inside the box(hive) so it will not disappear when the app is reloaded

void deleteQuotes() {
  // This Method helps in deleting the Quotes.
  Hive.box(quotesCardname).clear(); // We can Delete the quotes.
  print("Quotes Fired");
}

random(min, max) {
  // Method which return the random value from two ranges, (minimum and maximum)
  var rn = Random();
  return min + rn.nextInt(max - min);
}

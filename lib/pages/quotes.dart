import 'dart:convert';
import 'dart:io';
//import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/services.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:toodo/pages/more.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_saver/gallery_saver.dart';

class Quotes extends StatefulWidget {
  const Quotes({
    Key key,
  }) : super(key: key);

  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  int _counter = 0;
  Uint8List _imageFile;
  ScreenshotController screenshotquotes = new ScreenshotController();
  List _items = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/quotes.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("jsons/quotes.json"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var myquotes = json.decode(snapshot.data.toString());
        int lengthofJSON = 1643;
        var rangeofQuotes = random(0, lengthofJSON);

        if (myquotes.length < lengthofJSON) {
          return Container(
              height: MediaQuery.of(context).size.width / 10,
              child: CircularProgressIndicator());
        } else {
          //var randomMyQuotes = myquotes[0].shuffle().first;
          return Screenshot(
            controller: screenshotquotes,
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL,
              front: Card(
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
                            Container(
                                child: Icon(CarbonIcons.quotes,
                                    color: Colors.white)),
                            Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 30),
                                child: Text(
                                    "${myquotes[rangeofQuotes]["text"]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: (myquotes[rangeofQuotes]
                                                        ["text"]) //161
                                                    .length >
                                                90
                                            ? 12
                                            : 16))),
                            Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 30),
                                child: Text(
                                    "@${myquotes[rangeofQuotes]["author"]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic)))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                                  fontWeight: FontWeight.bold,
                                ))),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Center(
                                    child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    onPressed: () {},
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
                                    onPressed: () {
                                      screenshotquotes
                                          .capture()
                                          .then((Uint8List image) async {
                                        //Capture Done

                                        setState(() {
                                          _imageFile = image;
                                        });
                                      }).catchError((onError) {
                                        print(onError);
                                      });

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
                                                              color: Colors
                                                                  .white))),
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }
}

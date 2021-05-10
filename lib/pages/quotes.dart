import 'dart:convert';
import 'dart:io';
//import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
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

// import 'package:screenshot/screenshot.dart';

class Quotes extends StatefulWidget {
  const Quotes({
    Key key,
  }) : super(key: key);

  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  int _counter = 0;
  static GlobalKey _repaintKey = new GlobalKey();
  Uint8List _imageFile;
  var baseFileName = "Quote";
  final player = AudioCache();

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
          if (!snapshot.hasData) {
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
            var myquotes = json.decode(snapshot.data.toString());
            int lengthofJSON = 1643;
            var rangeofQuotes = random(0, lengthofJSON);

            //var randomMyQuotes = myquotes[0].shuffle().first;
            return FlipCard(
              direction: FlipDirection.HORIZONTAL,
              front: RepaintBoundary(
                key: _repaintKey,
                child: Card(
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
                              ),
                              FadeIn(
                                delay: Duration(milliseconds: 1000),
                                duration: Duration(milliseconds: 800),
                                child: Container(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width / 30),
                                    child: Text(
                                        myquotes[rangeofQuotes]["author"] ==
                                                null
                                            ? "..."
                                            : "@${myquotes[rangeofQuotes]["author"]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic))),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
                                          mode: PlayerMode.LOW_LATENCY,
                                        );
                                        Share.share(
                                          "${myquotes[rangeofQuotes]["text"]} \n @${myquotes[rangeofQuotes]["author"]}\n \n Get More Quotes while writing toodoos on (play store link)",
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
                                      onPressed: () {
                                        // ScreenShot();
                                        print("Quote Captured");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    Colors.blue[200],
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }

  random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  // Future<bool> saveFile(var byteList) async {
  //   Directory storageDir;
  //   try {
  //     if (await requestPermission(Permission.storage)) {
  //       storageDir = await getExternalStorageDirectory();

  //       String newPath = '';
  //       List<String> folders = storageDir.path.split('/');
  //       for (int x = 1; x < folders.length; x++) {
  //         String folder = folders[x];
  //         if (folder != 'Android') {
  //           newPath += '/' + folder;
  //         } else {
  //           break;
  //         }
  //       }
  //       newPath = newPath + '/yourFolderName';
  //       storageDir = Directory(newPath);
  //     } else {
  //       if (await requestPermission(Permission.photos)) {
  //         storageDir = await getTemporaryDirectory();
  //       } else {
  //         return false;
  //       }
  //     }
  //     if (!await storageDir.exists()) {
  //       await storageDir.create(recursive: true);
  //     }
  //     if (await storageDir.exists()) {
  //       File savedFile = File(storageDir.path + "/yourfileName");
  //       var savedPath = storageDir.path + "/$baseFileName";
  //       savedFile.writeAsBytesSync(
  //           byteList); //the byteList that you send from captureBoundary
  //       if (savedPath != null) {
  //         print("File saved");
  //       } else {
  //         print("Error saving");
  //       }
  //       return true;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return false;
  // }

  // Future<Uint8List> captureBoundary() async {
  //   try {
  //     RenderRepaintBoundary boundary =
  //         _repaintKey.currentContext.findRenderObject();
  //     Image savedImage = (await boundary.toImage(pixelRatio: 3.0)) as Image;
  //     ByteData byteData =
  //         await savedImage.toByteData(format: ImageByteFormat.png);
  //     Uint8List pngBytes = byteData.buffer.asUint8List();
  //     saveFile(widget.pickedImage.uri.path, pngBytes);
  //     return pngBytes;
  //   } catch (e) {
  //     print(e);
  //   }

  // Future<Uint8List> captureBoundary() async {
  //   try {
  //     RenderRepaintBoundary boundary =
  //         _repaintKey.currentContext.findRenderObject();
  //     Image savedImage = (await boundary.toImage(pixelRatio: 3.0)) as Image;
  //     ByteData byteData =
  //         await savedImage.toByteData(format: ImageByteFormat.png);
  //     UInt8List pngBytes = byteData.buffer.asUint8List();
  //     saveFile(widget.pickedImage.uri.path, pngBytes);
  //     return pngBytes;
  //   } catch (e) {
  //     print(e);
  //   }

  //   Future<bool> saveFile(var byteList) async {
  //     Directory storageDir;
  //     try {
  //       if (await requestPermission(Permission.storage)) {
  //         storageDir = await getExternalStorageDirectory();

  //         String newPath = '';
  //         List<String> folders = storageDir.path.split('/');
  //         for (int x = 1; x < folders.length; x++) {
  //           String folder = folders[x];
  //           if (folder != 'Android') {
  //             newPath += '/' + folder;
  //           } else {
  //             break;
  //           }
  //         }
  //         newPath = newPath + '/yourFolderName';
  //         storageDir = Directory(newPath);
  //       } else {
  //         if (await requestPermission(Permission.photos)) {
  //           storageDir = await getTemporaryDirectory();
  //         } else {
  //           return false;
  //         }
  //       }
  //       if (!await storageDir.exists()) {
  //         await storageDir.create(recursive: true);
  //       }
  //       if (await storageDir.exists()) {
  //         File savedFile = File(storageDir.path + "/yourfileName");
  //         savedPath = storageDir.path + "/$baseFileName";
  //         savedFile.writeAsBytesSync(
  //             byteList); //the byteList that you send from captureBoundary
  //         if (savedPath != null) {
  //           print("File saved");
  //         } else {
  //           print("Error saving");
  //         }
  //         return true;
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  //     return false;
  //   }
  // }
}

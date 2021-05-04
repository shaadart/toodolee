import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:http/http.dart';
import 'package:toodo/pages/more.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:animate_do/animate_do.dart';
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

// http://www.boredapi.com/api/activity/
class Bored extends StatefulWidget {
  const Bored({
    Key key,
  }) : super(key: key);

  @override
  _BoredState createState() => _BoredState();
}

class _BoredState extends State<Bored> {
  //https://www.boredapi.com/api/activity/
  var myboringListOne;
  var myboringListTwo;
  var myboringListThree;
  Future getBoringData() async {
    var resOne = await http.get(Uri.https('boredapi.com', '/api/activity/'));
    var resTwo = await http.get(Uri.https('boredapi.com', '/api/activity/'));
    //'/api/activity?minaccessibility=0&maxaccessibility=0.5'));
    var resThree = await http.get(Uri.https('boredapi.com', '/api/activity/'));
    myboringListOne = json.decode(resOne.body.toString());
    myboringListTwo = json.decode(resTwo.body.toString());
    myboringListThree = json.decode(resThree.body.toString());
    print(myboringListOne["activity"]);
    print(myboringListTwo["activity"]);
    print(myboringListThree["activity"]);
  }

  Future<void> _launched;

  Future<void> _launchBoringWorkinWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: true,
          forceWebView: true,
          headers: <String, String>{'my_header_key': 'my_value_key'});
    } else {
      throw await 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    //var myquotes = json.decode(snapshot.data.toString());
    // while (myboringListThree["activity"] == null) {
    //   return Container(
    //       height: MediaQuery.of(context).size.width / 10,
    //       child: CircularProgressIndicator());

    //   //http.get(Uri.https('boredapi.com', '/api/activity/'));
    // }
    return FutureBuilder(
      future: getBoringData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (myboringListThree == null) {
          return Container(
            child: Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 60.0,
                width: 60.0,
              ),
            ),
          );
        } else {
          return FlipCard(
            front: Card(
              // color: Colors.transparent,
              child: GradientCard(
                gradient: Gradients.buildGradient(
                    Alignment.topRight, Alignment.bottomLeft, [
                  Colors.green,
                  Colors.green[300],
                  Colors.green[100],
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
                              child: Text("You can do Today,",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700))),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 40)),
                          CarouselSlider(
                            items: [
                              Card(
                                  child: Wrap(
                                children: [
                                  ListTile(
                                    leading: IconButton(
                                      icon: Icon(CarbonIcons.star),
                                      onPressed: () {},
                                    ),
                                    title: Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20),
                                        child: Text(
                                            "${myboringListOne["activity"]}")),
                                    subtitle:
                                        Text("${myboringListOne["type"]}"),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      myboringListOne["link"] != ""
                                          ? IconButton(
                                              tooltip:
                                                  "${myboringListOne["link"]}",
                                              onPressed: () async {
                                                String texturl =
                                                    (myboringListOne["link"])
                                                        .toString();

                                                await canLaunch(texturl)
                                                    ? await launch(texturl)
                                                    : throw 'Could not launch $texturl';
                                              },
                                              icon: Icon(CarbonIcons.link))
                                          : Container(),
                                    ],
                                  ),
                                ],
                              )),
                              Card(
                                  child: Wrap(
                                children: [
                                  ListTile(
                                    leading: IconButton(
                                      icon: Icon(CarbonIcons.star),
                                      onPressed: () {},
                                    ),
                                    title: Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20),
                                        child: Text(
                                            "${myboringListTwo["activity"]}")),
                                    subtitle:
                                        Text("${myboringListTwo["type"]}"),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      myboringListTwo["link"] != ""
                                          ? IconButton(
                                              color: Colors.blue,
                                              tooltip:
                                                  "${myboringListTwo["link"]}",
                                              onPressed: () async {
                                                String texturl =
                                                    myboringListTwo["link"];

                                                await canLaunch(texturl)
                                                    ? await launch(texturl)
                                                    : throw 'Could not launch $texturl';
                                              },
                                              icon: Icon(CarbonIcons.link))
                                          : Container(),
                                    ],
                                  ),
                                ],
                              )),
                              Card(
                                  child: Wrap(
                                children: [
                                  ListTile(
                                    leading: IconButton(
                                      icon: Icon(CarbonIcons.star),
                                      onPressed: () {},
                                    ),
                                    title: Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20),
                                      child: Text(
                                          "${myboringListThree["activity"]}"),
                                    ),
                                    subtitle:
                                        Text("${myboringListThree["type"]}"),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      myboringListThree["link"] != ""
                                          ? IconButton(
                                              tooltip:
                                                  "${myboringListThree["link"]}",
                                              onPressed: () async {
                                                String texturl =
                                                    (myboringListThree["link"])
                                                        .toString();

                                                await canLaunch(texturl)
                                                    ? await launch(texturl)
                                                    : throw 'Could not launch $texturl';
                                              },
                                              icon: Icon(CarbonIcons.link))
                                          : Container(),
                                    ],
                                  ),
                                ],
                              )),
                            ],
                            options: CarouselOptions(
                              //height: 180.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              pauseAutoPlayOnTouch: true,
                              //aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.easeOutSine,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 4000),
                              viewportFraction: 0.9,
                            ),
                          ),
                          Container(
                              child: Text(
                                  "*This Grid is supposed to be for fun and gift from toodolee to you, you are not asked to do all the things that are mentioned in the boaring list, yeah you can do it when you will feel you are nothing to do or getting bored",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
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
                      children: [],
                    ),
                  )),
            ),
          );
        }
      },
    );
  }
// http://www.boredapi.com/api/activity/
}

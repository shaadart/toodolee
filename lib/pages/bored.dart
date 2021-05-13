import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:toodo/main.dart';
import 'package:toodo/pages/more.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
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
  CardController _cardController = CardController();
  final player = AudioCache();

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
    if (completedBox.length > 4) {
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
            return Wrap(
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
                                  color: Colors.black54,
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
                                        top: MediaQuery.of(context).size.width /
                                            20),
                                    child:
                                        Text("${myboringListOne["activity"]}")),
                                subtitle: Text("${myboringListOne["type"]}"),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  myboringListOne["link"] != ""
                                      ? IconButton(
                                          tooltip: "${myboringListOne["link"]}",
                                          onPressed: () async {
                                            player.play(
                                              'sounds/navigation_forward-selection-minimal.wav',
                                              stayAwake: false,
                                              mode: PlayerMode.LOW_LATENCY,
                                            );
                                            String texturl =
                                                (myboringListOne["link"])
                                                    .toString();

                                            await canLaunch(texturl)
                                                ? await launch(texturl)
                                                : throw 'Could not launch $texturl';
                                          },
                                          icon: Icon(CarbonIcons.link,
                                              color: Colors.blue))
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
                                        top: MediaQuery.of(context).size.width /
                                            20),
                                    child:
                                        Text("${myboringListTwo["activity"]}")),
                                subtitle: Text("${myboringListTwo["type"]}"),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  myboringListTwo["link"] != ""
                                      ? IconButton(
                                          color: Colors.blue,
                                          tooltip: "${myboringListTwo["link"]}",
                                          onPressed: () async {
                                            player.play(
                                              'sounds/navigation_forward-selection-minimal.wav',
                                              stayAwake: false,
                                              mode: PlayerMode.LOW_LATENCY,
                                            );
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
                                      top: MediaQuery.of(context).size.width /
                                          20),
                                  child:
                                      Text("${myboringListThree["activity"]}"),
                                ),
                                subtitle: Text("${myboringListThree["type"]}"),
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  myboringListThree["link"] != ""
                                      ? IconButton(
                                          tooltip:
                                              "${myboringListThree["link"]}",
                                          onPressed: () async {
                                            player.play(
                                              'sounds/navigation_forward-selection-minimal.wav',
                                              stayAwake: false,
                                              mode: PlayerMode.LOW_LATENCY,
                                            );
                                            String texturl =
                                                (myboringListThree["link"])
                                                    .toString();

                                            await canLaunch(texturl)
                                                ? await launch(texturl)
                                                : throw 'Could not launch $texturl';
                                          },
                                          icon: Icon(
                                            CarbonIcons.link,
                                            color: Colors.blue,
                                          ))
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
                    ],
                  ),
                ),
              ],
            );
          }
        },
      );
    } else {
      return ValueListenableBuilder(
        valueListenable: Hive.box(welcomeBoringCardname).listenable(),
        builder: (context, welcomeBoringCardBox, child) => welcomeBoringCardBox
                .get("welcome_shown", defaultValue: false)
            ? Defaultnullboredlist()
            : CarouselSlider(
                items: [
                  Card(
                      child: Wrap(
                    children: [
                      ListTile(
                        leading: Icon(CarbonIcons.hashtag,
                            size: MediaQuery.of(context).size.width / 8,
                            color: Colors.green.shade400),
                        title: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 20),
                          child: Text("Heyy, Welcome to Boring Card...",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 18)),
                        ),
                      ),
                      ListTile(
                        // trailing: Transform.rotate(
                        //   angle: 45 * pi / 180,
                        //   child: Icon(
                        //     CarbonIcons.hashtag,
                        //     size: MediaQuery.of(context).size.width / 8,
                        //     color: Colors.green[600],
                        //   ),
                        // ),
                        subtitle: Text("Swipe to know more.."),
                      ),
                    ],
                  )),
                  Card(
                      child: Wrap(
                    children: [
                      ListTile(
                        subtitle: Text("Swippppeeee..."),
                        title: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width / 20),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Literally, ',
                                        style: new TextStyle(
                                            color: Colors.blue,
                                            fontFamily: "WorkSans")),
                                    TextSpan(text: 'The Boring Card\n'),
                                    TextSpan(text: "Literally,"),
                                    TextSpan(
                                        text: 'The, ',
                                        style: new TextStyle(
                                            color: Colors.blue,
                                            fontFamily: "WorkSans")),
                                    TextSpan(text: 'Boring Card\n'),
                                    TextSpan(
                                      text: 'Literally, The ',
                                    ),
                                    TextSpan(
                                        text: "Boring",
                                        style: new TextStyle(
                                            color: Colors.blue,
                                            fontFamily: "WorkSans")),
                                    TextSpan(text: ' Card\n'),
                                    TextSpan(
                                      text: 'Literally, The Boring ',
                                    ),
                                    TextSpan(
                                        text: 'Card\n',
                                        style: new TextStyle(
                                            color: Colors.blue,
                                            fontFamily: "WorkSans"))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Card(
                      child: Wrap(
                    children: [
                      ListTile(
                        title: Text("Hereeeeee",
                            style: TextStyle(
                              fontFamily: "Elsie",
                              fontSize: MediaQuery.of(context).size.width / 18,
                            )),
                      ),
                      ListTile(
                        title: Text("issssssssss..",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 18,
                            )),
                      ),
                      ListTile(
                        title: Text(
                          "The Magical Deal ⭐️",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 18,
                          ),
                        ),
                      )
                    ],
                  )),
                  Card(
                      child: Wrap(
                    children: [
                      ListTile(
                        leading: todoBox.length >= 1 || completedBox.length >= 1
                            ? IconButton(
                                icon: Icon(CarbonIcons.checkbox_checked_filled,
                                    color: Colors.blue),
                                onPressed: () {
                                  player.play(
                                    'sounds/ui_tap-variant-01.wav',
                                    stayAwake: false,
                                    mode: PlayerMode.LOW_LATENCY,
                                  );
                                })
                            : IconButton(
                                icon: Icon(
                                  CarbonIcons.checkbox,
                                ),
                                onPressed: () {
                                  player.play(
                                    'sounds/ui_tap-variant-01.wav',
                                    stayAwake: false,
                                    mode: PlayerMode.LOW_LATENCY,
                                  );
                                }),
                        title: todoBox.length >= 1
                            ? Text(
                                "Write Toooodos",
                                style:
                                    TextStyle(), //decoration: TextDecoration.lineThrough),
                              )
                            : Text("Write Toooodos"),
                      ),
                      ListTile(
                        leading: completedBox.length >= 1
                            ? IconButton(
                                icon: Icon(CarbonIcons.checkbox_checked_filled,
                                    color: Colors.blue),
                                onPressed: () async {
                                  player.play(
                                    'sounds/ui_tap-variant-01.wav',
                                    stayAwake: false,
                                    mode: PlayerMode.LOW_LATENCY,
                                  );
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
                                })
                            : IconButton(
                                icon: Icon(
                                  CarbonIcons.checkbox,
                                ),
                                onPressed: () async {
                                  player.play(
                                    'sounds/ui_tap-variant-01.wav',
                                    stayAwake: false,
                                    mode: PlayerMode.LOW_LATENCY,
                                  );
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
                                }),
                        title: Text("Complete 'em"),
                      ),
                      ListTile(
                        leading: IconButton(
                            onPressed: () async {
                              player.play(
                                'sounds/ui_tap-variant-01.wav',
                                stayAwake: false,
                                mode: PlayerMode.LOW_LATENCY,
                              );
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                              );
                            },
                            icon: Icon(CarbonIcons.checkbox)),
                        title: Text("Atleast 5, to Unlock the Boring Card"),
                      ),
                    ],
                  )),
                  Card(
                      child: Wrap(
                    children: [
                      ListTile(
                        title: Center(
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 20),
                            child: RichText(
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 19,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Soooooo, \n',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: "WorkSans")),
                                  TextSpan(
                                      text:
                                          "Complete them daily, so to never ever Get Bored After the Completions 🏆 of your",
                                      style: TextStyle(fontFamily: "WorkSans")),
                                  TextSpan(
                                      text: " Toodoooleeeees",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: "WorkSans")),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ListTile(
                      //   subtitle: Text("- veeery veeerrry deeeeeep.",
                      //       style: TextStyle(fontStyle: FontStyle.italic)),
                      // ),
                    ],
                  )),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 20),
                      child: Center(
                        child: ExtendedImage.asset(
                          "assets/bitmojis/hmmm...gif",
                          mode: ExtendedImageMode.gesture,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          initGestureConfigHandler: (state) {
                            return GestureConfig(
                              minScale: 1,
                              //animationMinScale: 0.7,
                              maxScale: 2,
                              animationMaxScale: 5,
                              speed: 1,
                              inertialSpeed: 10.0,
                              initialScale: 1.0,
                              inPageView: false,
                              initialAlignment: InitialAlignment.center,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Card(
                      child: Wrap(
                    children: [
                      ListTile(
                        title: Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width / 20,
                                MediaQuery.of(context).size.width / 20,
                                MediaQuery.of(context).size.width / 20,
                                0),
                            child: RichText(
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Happpy Tooodlleee 😃,\n',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: "WorkSans")),
                                  TextSpan(
                                      text:
                                          "May You Achieve Big heights and...",
                                      style: TextStyle(fontFamily: "WorkSans")),
                                  TextSpan(
                                      text:
                                          " Annd Yeahh Never ever Get Bored from now..",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontFamily: "WorkSans")),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Center(
                          child: Row(
                            children: [
                              FlatButton(
                                  color: Colors.blue,
                                  onPressed: () async {
                                    var welcomeBoringCardBox =
                                        Hive.box(welcomeBoringCardname);
                                    welcomeBoringCardBox.put(
                                        "welcome_shown", true);
                                  },
                                  child: Text("Let's Start",
                                      style: TextStyle(color: Colors.white))),
                              IconButton(
                                  icon: Icon(
                                    CarbonIcons.share,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    player.play(
                                      'sounds/ui_tap-variant-01.wav',
                                      stayAwake: false,
                                      mode: PlayerMode.LOW_LATENCY,
                                    );
                                  }),
                            ],
                          ),
                        ),
                      )
                      // ListTile(
                      //   subtitle: Text("- veeery veeerrry deeeeeep.",
                      //       style: TextStyle(fontStyle: FontStyle.italic)),
                      // ),
                    ],
                  )),
                ],
                options: CarouselOptions(
                  //height: 180.0,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  //pauseAutoPlayOnTouch: true,
                  //aspectRatio: 16 / 9,
                  //autoPlayCurve: Curves.easeOutSine,
                  enableInfiniteScroll: false,
                  autoPlayAnimationDuration: Duration(milliseconds: 4000),
                  viewportFraction: 0.9,
                ),
              ),
      );
    }
  }
}

class Defaultnullboredlist extends StatelessWidget {
  const Defaultnullboredlist({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(CarbonIcons.delete),
            onPressed: () {
              Hive.box(welcomeBoringCardname).delete("welcome_shown");
            }),
        Text("Seee the Status..."),
      ],
    );
  }
}

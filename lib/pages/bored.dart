import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:locally/locally.dart';
import 'package:share/share.dart';
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
import 'package:toodo/pages/settingsPage/settingspagedefault.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:url_launcher/url_launcher.dart';

var boredBox = Hive.box(boringcardName);

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
          boredBox.put("firstCard", [
            myboringListOne["activity"],
            myboringListOne["type"],
            myboringListOne["link"],
          ]);

          boredBox.put("secondCard", [
            myboringListTwo["activity"],
            myboringListTwo["link"],
          ]);

          boredBox.put("thirdCard", [
            myboringListThree["activity"],
            myboringListThree["link"],
          ]);

          print("${boredBox.get("firstCard")[0]}");
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
            if (boredBox.get("showedNotification") == false ||
                boredBox.get("showedNotification") == null) {
              if (boredNotifications == true) {
                Locally locally = Locally(
                  context: context,
                  payload: 'test2',

                  //pageRoute: MaterialPageRoute(builder: (context) => MorePage(title: "Hey Test Notification", message: "You need to Work for allah...")),
                  appIcon: 'toodoleeicon',

                  pageRoute: MaterialPageRoute(builder: (BuildContext context) {
                    return DefaultedApp();
                  }),
                );

                locally.schedule(
                  channelName: "Bored Card Notifications",
                  channelID: "BoringCard",
                  channelDescription:
                      "Sends you Notifications related to Boring Card",
                  title: 'Hey, You have unlocked the Boring Card',
                  message:
                      "You have unlocked the Boring Card, enjoy it after the completion of your toodoos, go to Grid Tab",
                  duration: Duration(seconds: 2),
                );
                boredBox.put("showedNotification", true);
              } else {
                print("Notifications are not allowed by user");
              }
            }

            return CarouselSlider(
              items: [
                Card(
                    child: Center(
                  child: Wrap(
                    children: [
                      ListTile(
                        leading: IconButton(
                          icon: Icon(CarbonIcons.checkbox),
                          onPressed: () {},
                        ),
                        title: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width / 20),
                            child: Text("${boredBox.get("firstCard")[0]}")),
                        subtitle: Text("${boredBox.get("firstCard")[1]}"),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          boredBox.get("firstCard")[2] != ""
                              ? IconButton(
                                  tooltip: "${boredBox.get("firstCard")[2]}",
                                  onPressed: () async {
                                    player.play(
                                      'sounds/navigation_forward-selection-minimal.wav',
                                      stayAwake: false,
                                      // mode: PlayerMode.LOW_LATENCY,
                                    );
                                    String texturl =
                                        (boredBox.get("firstCard")[2])
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
                  ),
                )),
                Card(
                    child: Center(
                  child: Wrap(
                    children: [
                      ListTile(
                        leading: IconButton(
                          icon: Icon(CarbonIcons.checkbox),
                          onPressed: () {},
                        ),
                        title: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width / 20),
                            child: Text("${myboringListTwo["activity"]}")),
                        subtitle: Text("${myboringListTwo["type"]}"),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          myboringListTwo["link"] != ""
                              ? IconButton(
                                  tooltip: "${myboringListTwo["link"]}",
                                  onPressed: () async {
                                    player.play(
                                      'sounds/navigation_forward-selection-minimal.wav',
                                      stayAwake: false,
                                      // mode: PlayerMode.LOW_LATENCY,
                                    );
                                    String texturl =
                                        (myboringListTwo["link"]).toString();

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
                  ),
                )),
                Card(
                    child: Center(
                  child: Wrap(
                    children: [
                      ListTile(
                        leading: IconButton(
                          icon: Icon(CarbonIcons.checkbox),
                          onPressed: () {},
                        ),
                        title: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width / 20),
                            child: Text("${myboringListThree["activity"]}")),
                        subtitle: Text("${myboringListThree["type"]}"),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          myboringListThree["link"] != ""
                              ? IconButton(
                                  tooltip: "${myboringListThree["link"]}",
                                  onPressed: () async {
                                    player.play(
                                      'sounds/navigation_forward-selection-minimal.wav',
                                      stayAwake: false,
                                      // mode: PlayerMode.LOW_LATENCY,
                                    );
                                    String texturl =
                                        (myboringListThree["link"]).toString();

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
                  ),
                )),
              ],
              options: CarouselOptions(
                //height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                pauseAutoPlayOnTouch: true,
                //aspectRatio: 16 / 9,
                autoPlayCurve: Curves.easeIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 6000),
                viewportFraction: 0.8,
              ),
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
                                    //color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Literally, ',
                                        style: new TextStyle(
                                            color: Colors.blue,
                                            fontFamily: "WorkSans")),
                                    TextSpan(
                                        text: 'The Boring Card\n',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface)),
                                    TextSpan(
                                        text: "Literally,",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface)),
                                    TextSpan(
                                        text: 'The, ',
                                        style: new TextStyle(
                                            color: Colors.blue,
                                            fontFamily: "WorkSans")),
                                    TextSpan(
                                        text: 'Boring Card\n',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface)),
                                    TextSpan(
                                        text: 'Literally, The ',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface)),
                                    TextSpan(
                                        text: "Boring",
                                        style: new TextStyle(
                                            color: Colors.blue,
                                            fontFamily: "WorkSans")),
                                    TextSpan(
                                        text: ' Card\n',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface)),
                                    TextSpan(
                                        text: 'Literally, The Boring ',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface)),
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
                                    // mode: PlayerMode.LOW_LATENCY,
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
                                    // mode: PlayerMode.LOW_LATENCY,
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
                                    // mode: PlayerMode.LOW_LATENCY,
                                  );
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DefaultedApp()),
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
                                    // mode: PlayerMode.LOW_LATENCY,
                                  );
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DefaultedApp()),
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
                                // mode: PlayerMode.LOW_LATENCY,
                              );
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DefaultedApp()),
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
                                  //color: Colors.black,
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
                                      style: TextStyle(
                                          fontFamily: "WorkSans",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface)),
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
                        child: Image.asset(
                          "assets/bitmojis/hmmm...gif",
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
                                  //color: Colors.black,
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
                                      style: TextStyle(
                                          fontFamily: "WorkSans",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface)),
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
                                  icon: Opacity(
                                    opacity: 0.7,
                                    child: Icon(
                                      CarbonIcons.share,
                                      //color: Colors.black54,
                                    ),
                                  ),
                                  onPressed: () {
                                    player.play(
                                      'sounds/ui_tap-variant-01.wav',
                                      stayAwake: false,
                                      // mode: PlayerMode.LOW_LATENCY,
                                    );
                                    Share.share(
                                        "Hi, 👋 I am Using Toodooleee, Write Limited todos for Better Productivity.. \n \n The Best Part to Use Toodolee is that you will never Get bored after the completion of your toodos.. \n \n After doing your toodos it recommends you Top 3 (daily) Task #Productive for your Better Day ahead, \n \n example.. Make Food, Hang on with some Friends on Discord, Make Cake, and.. etc.. etc.. \n \n So Download toodolee (play store Link)");
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

class Defaultnullboredlist extends StatefulWidget {
  const Defaultnullboredlist({
    Key key,
  }) : super(key: key);

  @override
  _DefaultnullboredlistState createState() => _DefaultnullboredlistState();
}

class _DefaultnullboredlistState extends State<Defaultnullboredlist> {
  @override
  Widget build(BuildContext context) {
    List boringaskingList = [
      "Are you getting Booored?",
      "Booored ha..",
      "Booooooooored",
      "Getting Bor..red?",
      "Needs Something Living Productive..",
      "Searching for Productivity \n haa?",
      "Boring Times Hundred?",
      "At the Peak of Boredom",
      "Itsss All Flat...",
      "Feel No Spiritless After Doing these",
      "Tired?",
      "Remarkable Journey Waits..",
      "Colors are Here..",
      "Abundance lalala..",
      "Skill, Reality, Colors in hereeee",
      "Where isss Boring Sheets",
      "Blueprint of Anti-Boredom Sits here",
      "Fabulous! only these things are the hurdles",
      "Hey Champ, Get up and Complete all",
      "Hey Happy, Creatives never Get Bored..",
      "My Buddies Its easy to never get bored..",
      "Haa.. findng The Boring Card?",
      "Needs Boring Card?",
      "Oh here, Boring Card",
      "Booooring Caaard",
      "Get Creative After doing these",
      "Urgues of Creativity Starts heeeeeere..",
    ];

    List iconsList = [
      CarbonIcons.apple,
      CarbonIcons.basketball,
      CarbonIcons.star,
      CarbonIcons.rocket,
      CarbonIcons.paint_brush,
      CarbonIcons.tree,
      CarbonIcons.checkmark,
      CarbonIcons.thumbs_up,
      CarbonIcons.hashtag,
      CarbonIcons.idea,
      CarbonIcons.pen,
      CarbonIcons.trophy,
      CarbonIcons.flash
    ];

    var randomCardWords = randomChoice(boringaskingList);
    var randomicons = randomChoice(iconsList);
    final player = AudioCache();
    return CarouselSlider(
      items: [
        Card(
            child: Wrap(
          children: [
            ListTile(
              leading: Icon(randomicons,
                  size: MediaQuery.of(context).size.width / 8,
                  color: Colors.green.shade400),
              title: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
                child: Text("$randomCardWords...",
                    style: TextStyle(
                        fontSize: randomCardWords.length < 10
                            ? MediaQuery.of(context).size.width / 10
                            : MediaQuery.of(context).size.width / 18)),
              ),
            ),
            ListTile(
              subtitle: Text("Complete 'em now.."),
            ),
            // IconButton(
            //     icon: Icon(CarbonIcons.delete),
            //     onPressed: () {
            //       Hive.box(welcomeBoringCardname).delete("welcome_shown");
            //     }),
            // Text("Seee the Status..."),
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
                          // mode: PlayerMode.LOW_LATENCY,
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
                          // mode: PlayerMode.LOW_LATENCY,
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
                          // mode: PlayerMode.LOW_LATENCY,
                        );
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DefaultedApp()),
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
                          // mode: PlayerMode.LOW_LATENCY,
                        );
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DefaultedApp()),
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
                      // mode: PlayerMode.LOW_LATENCY,
                    );
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DefaultedApp()),
                    );
                  },
                  icon: Icon(CarbonIcons.checkbox)),
              title: Text("Atleast 5, to Unlock the Boring Card"),
            ),
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
    );
  }
}

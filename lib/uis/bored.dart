import 'package:connection_verify/connection_verify.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:hive/hive.dart';
import 'package:share/share.dart';
import 'package:toodo/main.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:url_launcher/url_launcher.dart';

/* The Boring card is the most differnet and one of the most powerful thing, in the Toodolee
It's obvius you will surely get bored, just after you will completed you most important task, 

Most of the Time Highly prioritizing works, (it may count to 3 or 7 or 10), 
they takes time, But in some day, (hopefully) you have completed your Most Inflential Task Earlity, (great applause for that comming day)

So the Boring card, Comes forward and Gives you Extra (relaxing, Socializing, Recreational, etc.) Tooooooodoos which willhelp you fight the boredom and sometimes they can also can emower your goals.

# 🔓 When You complete atleast Three Toodolees then Boring Card Unlocks.
# ⛵  Fights Boredom


*/

var myboringListOne; //first Boring Card Item
var myboringListTwo; //Second Boring Card Item
var myboringListThree; //Third Boring Card Item

// http://www.boredapi.com/api/activity/ is the place where we are taking the data.
class Bored extends StatefulWidget {
  const Bored({
    Key key,
  }) : super(key: key);

  @override
  _BoredState createState() => _BoredState();
}

class _BoredState extends State<Bored> {
  //https://www.boredapi.com/api/activity/

  Future<void> _launchBoringWorkinWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

// Checks for the Internet Connection (already)
  isInNetwork() async {
    if (await ConnectionVerify.connectionStatus() == true) {
      // if there is Internet
      print("I have network connection!");
      return true;
    } else {
      // If not
      print("I don't have network connection!");
      return false;
      // So, when the verification returns false, you are Offline, so offline treatments must be done here.
      // Do your offline stuff here
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: boredBox.listenable(),
        // ignore: missing_return
        builder: (context, bored, _) {
          // It will Unlock then only when the atleast streaks and completed Tooodos are combinely making 3 or any one of it is making three as the sum.
          if (completedBox.length +
                  streakBox.values
                      .where((streak) => streak.isCompleted)
                      .toList()
                      .length >=
              3) {
            if (boredBox.isEmpty) {
              // if boring Card were not there, then Fetch the Cards from the API and While you get it show the Loading Screen.
              //If there is no Internet Already, Shw custom Screeen that Network is not there.
              if (isInNetwork() == false) {
                Card(
                    child: Wrap(children: [
                  Center(
                      child: ListTile(
                          leading: Icon(CarbonIcons.wifi_off,
                              size:
                                  MediaQuery.of(context).size.shortestSide / 8,
                              color: Colors.green.shade400))),
                  ListTile(
                    title: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide / 20),
                      child: Text("Pss. Connect to the Network",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.shortestSide /
                                      20)),
                    ),
                  ),
                ]));
              } else {
                getBoringData();
                return Container(
                  child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      height: 60.0,
                      width: 60.0,
                    ),
                  ),
                );
              }
            } else {
              // If everything is fine then build the data in the App Interface
              return CarouselSlider(
                // It is a Slider, or Moving Slideshow which shows Widgets, or images anything.
                // They are using this tool to showcase the boring card elements
                items: [
                  //Before this, ctrl + enter the boringCard below to know, howthe UI is looking, yet it is easy to understand,
                  //0th Index - Boring Card Task
                  //1st Index - Boring Card Task - Type
                  //2nd Index - Boring Card Link (if there is)
                  boringCard(
                      bored.get("firstCard")[0], //task
                      bored.get("firstCard")[1], // type
                      bored.get("firstCard")[2], //link
                      context),
                  //Same applies to all below.
                  boringCard(
                      bored.get("secondCard")[0],
                      bored.get("secondCard")[1],
                      bored.get("secondCard")[2],
                      context),
                  boringCard(
                      bored.get("thirdCard")[0],
                      bored.get("thirdCard")[1],
                      bored.get("thirdCard")[2],
                      context),
                ],
                // This is the Settings of this Slideshow, How it should behave, the variables are easy to understand.
                options: CarouselOptions(
                  //height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(seconds: 12),
                  viewportFraction: 0.8,
                ),
              );
            }
          } else {
            return Defaultnullboredlist();
            //   return ValueListenableBuilder(
            //     valueListenable: Hive.box(welcomeBoringCardname).listenable(),
            //     builder: (context, welcomeBoringCardBox, child) =>
            //         welcomeBoringCardBox.get("welcome_shown", defaultValue: false)
            //             ? Defaultnullboredlist()
            //             : CarouselSlider(
            //                 items: [
            //                   Card(
            //                       child: Wrap(
            //                     children: [
            //                       ListTile(
            //                         leading: Icon(CarbonIcons.hashtag,
            //                             size: MediaQuery.of(context)
            //                                     .size
            //                                     .shortestSide /
            //                                 8,
            //                             color: Colors.green.shade400),
            //                         title: Padding(
            //                           padding: EdgeInsets.all(
            //                               MediaQuery.of(context)
            //                                       .size
            //                                       .shortestSide /
            //                                   20),
            //                           child: Text(
            //                               "Heyy, Welcome to Boring Card...",
            //                               style: TextStyle(
            //                                   fontSize: MediaQuery.of(context)
            //                                           .size
            //                                           .width /
            //                                       18)),
            //                         ),
            //                       ),
            //                       ListTile(
            //                         subtitle: Text("Swipe to know more.."),
            //                       ),
            //                     ],
            //                   )),
            //                   Card(
            //                       child: Wrap(
            //                     children: [
            //                       ListTile(
            //                         subtitle: Text("Swippppeeee..."),
            //                         title: Center(
            //                           child: Padding(
            //                             padding: EdgeInsets.only(
            //                                 top: MediaQuery.of(context)
            //                                         .size
            //                                         .width /
            //                                     20),
            //                             child: Center(
            //                               child: RichText(
            //                                 text: TextSpan(
            //                                   // Note: Styles for TextSpans must be explicitly defined.
            //                                   // Child text spans will inherit styles from parent
            //                                   style: TextStyle(
            //                                     fontSize: MediaQuery.of(context)
            //                                             .size
            //                                             .width /
            //                                         20,
            //                                     //color: Colors.black,
            //                                   ),
            //                                   children: <TextSpan>[
            //                                     TextSpan(
            //                                         text: 'Literally, ',
            //                                         style: TextStyle(
            //                                             color: Colors.blue,
            //                                             fontFamily: "WorkSans")),
            //                                     TextSpan(
            //                                         text: 'The Boring Card\n',
            //                                         style: TextStyle(
            //                                             color: Theme.of(context)
            //                                                 .colorScheme
            //                                                 .onSurface)),
            //                                     TextSpan(
            //                                         text: "Literally,",
            //                                         style: TextStyle(
            //                                             color: Theme.of(context)
            //                                                 .colorScheme
            //                                                 .onSurface)),
            //                                     TextSpan(
            //                                         text: 'The, ',
            //                                         style: TextStyle(
            //                                             color: Colors.blue,
            //                                             fontFamily: "WorkSans")),
            //                                     TextSpan(
            //                                         text: 'Boring Card\n',
            //                                         style: TextStyle(
            //                                             color: Theme.of(context)
            //                                                 .colorScheme
            //                                                 .onSurface)),
            //                                     TextSpan(
            //                                         text: 'Literally, The ',
            //                                         style: TextStyle(
            //                                             color: Theme.of(context)
            //                                                 .colorScheme
            //                                                 .onSurface)),
            //                                     TextSpan(
            //                                         text: "Boring",
            //                                         style: TextStyle(
            //                                             color: Colors.blue,
            //                                             fontFamily: "WorkSans")),
            //                                     TextSpan(
            //                                         text: ' Card\n',
            //                                         style: TextStyle(
            //                                             color: Theme.of(context)
            //                                                 .colorScheme
            //                                                 .onSurface)),
            //                                     TextSpan(
            //                                         text:
            //                                             'Literally, The Boring ',
            //                                         style: TextStyle(
            //                                             color: Theme.of(context)
            //                                                 .colorScheme
            //                                                 .onSurface)),
            //                                     TextSpan(
            //                                         text: 'Card\n',
            //                                         style: TextStyle(
            //                                             color: Colors.blue,
            //                                             fontFamily: "WorkSans"))
            //                                   ],
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   )),
            //                   Card(
            //                       child: Wrap(
            //                     children: [
            //                       ListTile(
            //                         title: Text("Hereeeeee",
            //                             style: TextStyle(
            //                               fontFamily: "Elsie",
            //                               fontSize: MediaQuery.of(context)
            //                                       .size
            //                                       .shortestSide /
            //                                   18,
            //                             )),
            //                       ),
            //                       ListTile(
            //                         title: Text("issssssssss..",
            //                             style: TextStyle(
            //                               fontSize: MediaQuery.of(context)
            //                                       .size
            //                                       .shortestSide /
            //                                   18,
            //                             )),
            //                       ),
            //                       ListTile(
            //                         title: Text(
            //                           "The Magical Deal ⭐️",
            //                           style: TextStyle(
            //                             fontSize: MediaQuery.of(context)
            //                                     .size
            //                                     .shortestSide /
            //                                 18,
            //                           ),
            //                         ),
            //                       )
            //                     ],
            //                   )),
            //                   Card(
            //                       child: Wrap(
            //                     children: [
            //                       ListTile(
            //                         leading: todoBox.length >= 1 ||
            //                                 completedBox.length >= 1
            //                             ? IconButton(
            //                                 icon: Icon(
            //                                     CarbonIcons
            //                                         .checkbox_checked_filled,
            //                                     color: Colors.blue),
            //                                 onPressed: () {
            //                                   player.play(
            //                                     'sounds/ui_tap-variant-01.wav',
            //                                     stayAwake: false,
            //                                     // mode: PlayerMode.LOW_LATENCY,
            //                                   );
            //                                 })
            //                             : IconButton(
            //                                 icon: Icon(
            //                                   CarbonIcons.checkbox,
            //                                 ),
            //                                 onPressed: () {
            //                                   Navigator.push(
            //                                     context,
            //                                     MaterialPageRoute(
            //                                         builder: (context) =>
            //                                             DefaultedApp()),
            //                                   );
            //                                   // addTodoBottomSheet(context);
            //                                   player.play(
            //                                     'sounds/ui_tap-variant-01.wav',
            //                                     stayAwake: false,
            //                                     // mode: PlayerMode.LOW_LATENCY,
            //                                   );
            //                                 }),
            //                         title: todoBox.length >= 1
            //                             ? Text(
            //                                 "Write Toooodos",
            //                                 style:
            //                                     TextStyle(), //decoration: TextDecoration.lineThrough),
            //                               )
            //                             : Text("Write Toooodos"),
            //                       ),
            //                       ListTile(
            //                         leading: completedBox.length >= 1
            //                             ? IconButton(
            //                                 icon: Icon(
            //                                     CarbonIcons
            //                                         .checkbox_checked_filled,
            //                                     color: Colors.blue),
            //                                 onPressed: () async {
            //                                   player.play(
            //                                     'sounds/ui_tap-variant-01.wav',
            //                                     stayAwake: false,
            //                                     // mode: PlayerMode.LOW_LATENCY,
            //                                   );
            //                                   await Navigator.push(
            //                                     context,
            //                                     MaterialPageRoute(
            //                                         builder: (context) =>
            //                                             DefaultedApp()),
            //                                   );
            //                                 })
            //                             : IconButton(
            //                                 icon: Icon(
            //                                   CarbonIcons.checkbox,
            //                                 ),
            //                                 onPressed: () async {
            //                                   player.play(
            //                                     'sounds/ui_tap-variant-01.wav',
            //                                     stayAwake: false,
            //                                     // mode: PlayerMode.LOW_LATENCY,
            //                                   );
            //                                   await Navigator.push(
            //                                     context,
            //                                     MaterialPageRoute(
            //                                         builder: (context) =>
            //                                             DefaultedApp()),
            //                                   );
            //                                 }),
            //                         title: Text("Complete 'em"),
            //                       ),
            //                       ListTile(
            //                         leading: IconButton(
            //                             onPressed: () async {
            //                               player.play(
            //                                 'sounds/ui_tap-variant-01.wav',
            //                                 stayAwake: false,
            //                                 // mode: PlayerMode.LOW_LATENCY,
            //                               );
            //                               await Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(
            //                                     builder: (context) =>
            //                                         DefaultedApp()),
            //                               );
            //                             },
            //                             icon: Icon(CarbonIcons.checkbox)),
            //                         title: Text(
            //                             "Atleast 3, to Unlock the Boring Card"),
            //                       ),
            //                     ],
            //                   )),
            //                   Card(
            //                       child: Wrap(
            //                     children: [
            //                       ListTile(
            //                         title: Center(
            //                           child: Padding(
            //                             padding: EdgeInsets.all(
            //                                 MediaQuery.of(context)
            //                                         .size
            //                                         .shortestSide /
            //                                     20),
            //                             child: RichText(
            //                               text: TextSpan(
            //                                 // Note: Styles for TextSpans must be explicitly defined.
            //                                 // Child text spans will inherit styles from parent
            //                                 style: TextStyle(
            //                                   fontSize: MediaQuery.of(context)
            //                                           .size
            //                                           .width /
            //                                       19,
            //                                   //color: Colors.black,
            //                                 ),
            //                                 children: <TextSpan>[
            //                                   TextSpan(
            //                                       text: 'Soooooo, \n',
            //                                       style: TextStyle(
            //                                           color: Colors.blue,
            //                                           fontFamily: "WorkSans")),
            //                                   TextSpan(
            //                                       text:
            //                                           "Complete them daily, so to never ever Get Bored After the Completions 🏆 of your",
            //                                       style: TextStyle(
            //                                           fontFamily: "WorkSans",
            //                                           color: Theme.of(context)
            //                                               .colorScheme
            //                                               .onSurface)),
            //                                   TextSpan(
            //                                       text: " Toodoooleeeees",
            //                                       style: TextStyle(
            //                                           color: Colors.blue,
            //                                           fontFamily: "WorkSans")),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       // ListTile(
            //                       //   subtitle: Text("- veeery veeerrry deeeeeep.",
            //                       //       style: TextStyle(fontStyle: FontStyle.italic)),
            //                       // ),
            //                     ],
            //                   )),
            //                   Card(
            //                     child: Padding(
            //                       padding: EdgeInsets.all(
            //                           MediaQuery.of(context).size.shortestSide /
            //                               20),
            //                       child: Center(
            //                         child: Image.asset(
            //                           "assets/hmmm...gif",
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   Card(
            //                       child: Wrap(
            //                     children: [
            //                       ListTile(
            //                         title: Center(
            //                           child: Padding(
            //                             padding:
            //                                 EdgeInsets.fromLTRB(
            //                                     MediaQuery.of(context)
            //                                             .size
            //                                             .shortestSide /
            //                                         20,
            //                                     MediaQuery.of(context)
            //                                             .size
            //                                             .shortestSide /
            //                                         20,
            //                                     MediaQuery.of(context)
            //                                             .size
            //                                             .shortestSide /
            //                                         20,
            //                                     0),
            //                             child: RichText(
            //                               text: TextSpan(
            //                                 // Note: Styles for TextSpans must be explicitly defined.
            //                                 // Child text spans will inherit styles from parent
            //                                 style: TextStyle(
            //                                   fontSize: MediaQuery.of(context)
            //                                           .size
            //                                           .width /
            //                                       20,
            //                                   //color: Colors.black,
            //                                 ),
            //                                 children: <TextSpan>[
            //                                   TextSpan(
            //                                       text: 'Happpy Tooodlleee 😃,\n',
            //                                       style: TextStyle(
            //                                           color: Colors.blue,
            //                                           fontFamily: "WorkSans")),
            //                                   TextSpan(
            //                                       text:
            //                                           "May You Achieve Big heights and...",
            //                                       style: TextStyle(
            //                                           fontFamily: "WorkSans",
            //                                           color: Theme.of(context)
            //                                               .colorScheme
            //                                               .onSurface)),
            //                                   TextSpan(
            //                                       text:
            //                                           " Annd Yeahh Never ever Get Bored from now..",
            //                                       style: TextStyle(
            //                                           color: Colors.blue,
            //                                           fontFamily: "WorkSans")),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       ListTile(
            //                         title: Center(
            //                           child: Row(
            //                             children: [
            //                               MaterialButton(
            //                                   color: Colors.blue,
            //                                   onPressed: () async {
            //                                     player.play(
            //                                       'sounds/hero_decorative-celebration-03.wav',
            //                                       stayAwake: false,
            //                                       // mode: PlayerMode.LOW_LATENCY,
            //                                     );
            //                                     var welcomeBoringCardBox =
            //                                         Hive.box(
            //                                             welcomeBoringCardname);
            //                                     welcomeBoringCardBox.put(
            //                                         "welcome_shown", true);
            //                                   },
            //                                   child: Text("Let's Start",
            //                                       style: TextStyle(
            //                                           color: Colors.white))),
            //                               IconButton(
            //                                   icon: Opacity(
            //                                     opacity: 0.7,
            //                                     child: Icon(
            //                                       CarbonIcons.share,
            //                                       //color: Colors.black54,
            //                                     ),
            //                                   ),
            //                                   onPressed: () {
            //                                     player.play(
            //                                       'sounds/ui_tap-variant-01.wav',
            //                                       stayAwake: false,
            //                                       // mode: PlayerMode.LOW_LATENCY,
            //                                     );
            //                                     Share.share(
            //                                         "Hi, 👋 I am Using Toodooleee, It's Just about Limiting your things to achieve limitless,\n \nYou had always been with me at all walks,\n \nI believe in you,\nYou would never waste your whole energy of your life in random un-productive things, \n \nSo if you need to be productive in the state of boredom, (which I want you to be) and pass on the boredom, I am with you, Toodolee it to End Boredom from Your Pocket. \n \n (I know that was some big message, indeed this is a sign that I care for you) (play store Link)");
            //                                   }),
            //                             ],
            //                           ),
            //                         ),
            //                       )
            //                       // ListTile(
            //                     ],
            //                   )),
            //                 ],
            //                 options: CarouselOptions(
            //                   //height: 180.0,
            //                   enlargeCenterPage: false,
            //                   autoPlay: false,
            //                   //pauseAutoPlayOnTouch: true,
            //                   //aspectRatio: 16 / 9,
            //                   //autoPlayCurve: Curves.easeOutSine,
            //                   enableInfiniteScroll: false,
            //                   autoPlayAnimationDuration:
            //                       Duration(milliseconds: 4000),
            //                   viewportFraction: 0.9,
            //                 ),
            //               ),
            //   );
            // }
          }
        });
  }
}

/* 
It is a WhiteScreen like how the Main Page is Using, where there will be nothing there should be something. 
if user has not completed the Three Tooooodoleees (can have streaks in it)
then Something should be shown to user, like how well he is progressing and how much effort is needed to unlock 🔓 
The Boring Card.
*/

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
      //Some Starters to show, if user has not completed the Three Tooooodoleees (can have streaks in it)
      "Are you getting Booored?",
      "Booored ha..",
      "Booooooooored",
      "oohooooo Booooring Caaaaaaaard",
      "Getting Bor..red?",
      "Needs Something Living Productive..",
      "Pro-duct-tea-vee-tea\nhaa?",
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
      "Your You Yours\nBoooing Boooooing Card",
      "Oh here, Boring Card",
      "Booooring Caaard",
      "Get Creative After doing these",
      "Urges of Creativity Starts heeeeeere..",
    ];

// List of Icons
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
      CarbonIcons.flash,
      CarbonIcons.sun,
      CarbonIcons.explore,
      CarbonIcons.palm_tree,
      CarbonIcons.bicycle,
      CarbonIcons.bee
    ];
// Randomizing the Words and the Icons
// Taking one from each one.
    var randomCardWords = randomChoice(boringaskingList);
    var randomicons = randomChoice(iconsList);

//Then building it inside the UI,
    return CarouselSlider(
      items: [
        Card(
            child: Wrap(
          children: [
            ListTile(
              leading: Icon(randomicons,
                  size: MediaQuery.of(context).size.shortestSide / 8,
                  color: Colors.green.shade400),
              title: Padding(
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.shortestSide / 20),
                child: Text("$randomCardWords...",
                    style: TextStyle(
                        fontSize: randomCardWords.length < 10
                            ? MediaQuery.of(context).size.shortestSide / 10
                            : MediaQuery.of(context).size.shortestSide / 20)),
              ),
            ),
            ListTile(
              subtitle: Text("Complete 'em now.."),
            ),
          ],
        )),

        /* Creating a Condition, and showing the user their progress
        Conditions are as follows, 
        # You Must Write a Toodooleee
        # You Must Complete at Least One.
        # You must Do it for Three Times.
        
        This Card is building in a same way, 
        Creating the Interface acording to the following Conditions

      User can Track theri record, like how much push is needed now to secure the place of getting the boring card.
      The Condition will be ticked ✔️
      And if not I will be abide there as an empty check
       */
        Card(
            child: Wrap(
          children: [
            ListTile(
              // If the streak is cmpleted and the completed ones count greated than one, or the case is with Tooodos or Completed Ones.
              // then Check the Icon which means Make the Icon Check, It will look like it is Completed.
              // If it is not the Case let the Leading Icon Looks like, nothing is checked,

              leading: todoBox.length >= 1 ||
                      completedBox.length >= 1 ||
                      streakBox.values
                              .where((streak) => streak.isCompleted)
                              .toList()
                              .length >=
                          1
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DefaultedApp()),
                        );
                      }),
              title: todoBox.length >= 1 ||
                      streakBox.values
                              .where((streak) => streak.isCompleted == false)
                              .toList()
                              .length >=
                          1
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
              title: Text("Atleast 3, to Unlock the Boring Card"),
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

boringCard(boringTask, boringType, boringLink, context) {
  // This is a Single Card.
  // This is a Template where the Boring card abides.
  // So,
  return Card(
      child: Center(
    child: Wrap(
      children: [
        ListTile(
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.shortestSide / 20),
              child: Text("$boringTask", textAlign: TextAlign.center),
            ),
          ),
          subtitle: Center(child: Text("$boringType")),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            // if boring Card's Link is not Equal to "", or is not empty,
            //then Show the Icon Button, of blue color, and it's tooltip with the link embeded in it.
            boringLink != ""
                ? IconButton(
                    tooltip: "$boringLink",
                    onPressed: () async {
                      player.play(
                        'sounds/navigation_forward-selection-minimal.wav',
                        stayAwake: false,
                        // mode: PlayerMode.LOW_LATENCY,
                      );
                      String texturl = (boringLink)
                          .toString(); // The URL must be converted to String

                      await canLaunch(texturl)
                          ? await launch(texturl)
                          : throw 'Could not launch $texturl'; //.. checking if we can launch the URL, if yes, It opens the Link in the Borwser, if there.
                    },
                    icon: Icon(CarbonIcons.link, color: Colors.blue))
                : Container(),
          ],
        ),
      ],
    ),
  ));
}

Future getBoringData() async {
  //Responses from the API grabbing,
  var resOne = await http.get(Uri.https('boredapi.com', '/api/activity/'));
  var resTwo = await http.get(Uri.https('boredapi.com', '/api/activity/'));
  var resThree = await http.get(Uri.https('boredapi.com', '/api/activity/'));

  // json Decoding these as they are crud and comes from Internet hence needs to get refined outputs
  // So decoding the response.
  myboringListOne = json.decode(resOne.body.toString());
  myboringListTwo = json.decode(resTwo.body.toString());
  myboringListThree = json.decode(resThree.body.toString());

// We got a Response. yay!

//now we need to put the Responses in the boxes.
// So the boring card will not die if the App reloads and also it should not die before the Reset of The Next Day
// check lib\processes.dart file. @resetToodoleeMidnight

// Box will store every thing in key-value pair,
// firstCard will be stored in one Index,
// second in another,
// and third in another.
// yet in most magical way.
  boredBox.put("firstCard", [
    myboringListOne["activity"],
    myboringListOne["type"],
    myboringListOne["link"],
  ]);

  boredBox.put("secondCard", [
    myboringListTwo["activity"],
    myboringListTwo["type"],
    myboringListTwo["link"],
  ]);

  boredBox.put("thirdCard", [
    myboringListThree["activity"],
    myboringListThree["type"],
    myboringListThree["link"],
  ]);
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';
import 'package:date_format/date_format.dart';
import 'package:davinci/core/davinci_capture.dart';
import 'package:davinci/core/davinci_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:jiffy/jiffy.dart';
import 'package:toodo/models/Streak Model/completed_streak_model.dart';

import 'package:toodo/main.dart';
import 'package:share/share.dart';
import 'package:toodo/models/Streak Model/streak_model.dart';

import 'package:carbon_icons/carbon_icons.dart';
import 'dart:core';

import 'package:toodo/uis/Streak/streakListUi.dart';

import '../quotes.dart';

CompletedStreakModel compStreak;

class CompletedStreakCard extends StatefulWidget {
  const CompletedStreakCard({
    Key key,
  }) : super(key: key);

  @override
  _CompletedStreakCardState createState() => _CompletedStreakCardState();
}

class _CompletedStreakCardState extends State<CompletedStreakCard> {
  GlobalKey imageKey;
  String platformResponse;
  CarouselController buttonCarouselController = CarouselController();

  ConfettiController controllerbottomCenter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initController();
    });
  }

  void initController() {
    controllerbottomCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  //bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    buildConfettiWidget() {
      return Align(
        alignment: Alignment.topCenter,
        child: ConfettiWidget(
          maxBlastForce: 30,
          minBlastForce: 15,
          // radial value - LEFT
          // apply drag to the confetti
          // blastDirection: pi,
          emissionFrequency: 0.1, // how often it should emit
          numberOfParticles: 20, // number of particles to emit
          gravity: 0.1, // gravity
          confettiController: controllerbottomCenter,
          blastDirectionality: BlastDirectionality
              .explosive, // don't specify a direction, blast randomly
          shouldLoop: false, // start again as soon as the animation is finished
          colors: [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple,
            Theme.of(context).accentColor,
            Theme.of(context).colorScheme.onSecondary,
          ], // manually specify the colors to be used
          // define a custom shape/path.
        ),
      );
    }

    return ValueListenableBuilder(
        valueListenable:
            Hive.box<CompletedStreakModel>(completedStreakBoxName).listenable(),
        // ignore: missing_return
        builder: (context, Box<CompletedStreakModel> csbox, _) {
          List<int> keys = csbox.keys.cast<int>().toList();

          if (streakBox.length == streakBox.length) {
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        //itemCount: box.length,// editing a bit
                        itemCount: csbox.length,
                        shrinkWrap: true,
                        separatorBuilder: (_, index) => Container(),
                        itemBuilder: (_, index) {
                          final int ckey = keys[index];
                          compStreak = csbox.get(ckey);
                          String incompletedStreakName = compStreak.streakName;
                          String incompletedStreakEmoji =
                              compStreak.streakEmoji;
                          var incompletedStreakRemainder =
                              compStreak.streakRemainder;
                          int incompletedStreakDays = compStreak.streakDays;
                          int incompletedStreakCount = compStreak.streakCount;
                          bool incompletedStreakCompleted = true;
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.shortestSide / 35,
                                0,
                                MediaQuery.of(context).size.shortestSide / 35,
                                0),
                            child: Card(
                              // color: Colors.white,

                              elevation: 0.4,
                              child: Wrap(
                                children: [
                                  ListTile(
                                    title: Opacity(
                                      opacity: 0.8,
                                      child: Text(
                                        '${(incompletedStreakName).toString()}',
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontFamily: "WorkSans",
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          //  color: Colors.black54,
                                          //decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ),
                                    onLongPress: () {
                                      print("object");
                                    },
                                    leading: IconButton(
                                      onPressed: () {
                                        // compStreak.isCompleted = false;
                                        // compStreak.save();
                                        deleteQuotes();
                                        player.play(
                                          'sounds/notification_simple-01.wav',
                                          stayAwake: false,
                                          // mode: PlayerMode.LOW_LATENCY,
                                        );

                                        StreakModel incompleteStreak =
                                            StreakModel(
                                          streakName: incompletedStreakName,
                                          streakEmoji: incompletedStreakEmoji,
                                          streakRemainder:
                                              incompletedStreakRemainder,
                                          streakDays: incompletedStreakDays,
                                          streakCount:
                                              incompletedStreakCount - 1,
                                          isCompleted: true,
                                        );
                                        streakBox.add(incompleteStreak);
                                        completedStreakBox.deleteAt(index);
                                      },
                                      icon: Icon(CarbonIcons.checkmark_filled,
                                          color: Colors.blue),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.fromLTRB(66.0, 0, 30, 0),
                                    //   // child: Text(
                                    //   //   'Greyhound d ',
                                    //   //   style:
                                    //   //       TextStyle(color: Colors.black.withOpacity(0.6)),
                                    //   // ),
                                    // ),

                                    trailing: IconButton(
                                      color: Colors.blue,
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: false,
                                          shape: RoundedRectangleBorder(
                                            // <-- for border radius
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                          ),
                                          builder: (context) {
                                            // Using Wrap makes the bottom sheet height the height of the content.
                                            // Otherwise, the height will be half the height of the screen.
                                            return Wrap(
                                              children: [
                                                // MaterialButton(
                                                //   onPressed: () {},
                                                //   child: ListTile(
                                                //     leading: Icon(CarbonIcons.edit),
                                                //     title: Text("Edit"),
                                                //   ),
                                                // ),
                                                MaterialButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    Share.share(
                                                        "Hey 👋, Todays Todo is Completed, \n \n ${incompletedStreakName} \n \n 🎉🎉🎉",
                                                        subject:
                                                            "Today's Toodo");
                                                  },
                                                  child: ListTile(
                                                    leading:
                                                        Icon(CarbonIcons.share),
                                                    title: Text("Share"),
                                                  ),
                                                ),

                                                Divider(),
                                                MaterialButton(
                                                  onPressed: () async {
                                                    await csbox.deleteAt(index);
                                                    incrementCount();
                                                    deleteQuotes();

                                                    Navigator.pop(context);
                                                  },
                                                  child: ListTile(
                                                    leading: Icon(
                                                        CarbonIcons.delete,
                                                        color:
                                                            Colors.redAccent),
                                                    title: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                          CarbonIcons.overflow_menu_horizontal),
                                    ),
                                    subtitle: Text("$incompletedStreakCount"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    Center(child: buildConfettiWidget()),
                    // LinearProgressIndicator(
                    //   value: incompletedStreakDays.toDouble(),
                    // )
                  ],
                ));
          }
        });
  }
}

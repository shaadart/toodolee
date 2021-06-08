import 'package:davinci/core/davinci_capture.dart';
import 'package:davinci/core/davinci_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:gradient_widgets/gradient_widgets.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:toodo/main.dart';

import 'package:share/share.dart';
import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/models/streak_model.dart';

import 'package:toodo/uis/quotes.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'dart:core';

import 'package:yudiz_modal_sheet/yudiz_modal_sheet.dart';

void incrementCount() {
  totalTodoCount.value++;
}

Box<StreakModel> sbox;

class StreakCard extends StatefulWidget {
  const StreakCard({
    Key key,
  }) : super(key: key);

  @override
  _StreakCardState createState() => _StreakCardState();
}

class _StreakCardState extends State<StreakCard> {
  GlobalKey imageKey;

  @override
  void initState() {
    super.initState();
  }

  //bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<StreakModel>(streakBoxName).listenable(),
        // ignore: missing_return
        builder: (context, Box<StreakModel> sbox, _) {
          List<int> keys = sbox.keys.cast<int>().toList();

          if (streakBox.length == streakBox.length) {
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    //itemCount: box.length,// editing a bit
                    itemCount: sbox.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, index) => Container(),
                    itemBuilder: (_, index) {
                      final int key = keys[index];
                      final StreakModel streako = sbox.get(key);
                      // String completedTodoName = streak.streakName;
                      // String completedTodoEmoji = streak.streakEmoji;
                      // String completedTodoRemainder = streak.streakRemainder;

                      return Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.shortestSide / 35,
                              0,
                              MediaQuery.of(context).size.shortestSide / 35,
                              0),
                          child: Davinci(builder: (imgkey) {
                            ///3. set the widget key to the globalkey
                            this.imageKey = imgkey;
                            return Container(
                                color: Colors.transparent,
                                child: GradientCard(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    margin: EdgeInsets.all(0),
                                    gradient: Gradients.buildGradient(
                                        Alignment.topRight, Alignment.topLeft, [
                                      Theme.of(context).scaffoldBackgroundColor,

                                      // Theme.of(context).cardColor.withOpacity(0.2),
                                      Theme.of(context).scaffoldBackgroundColor,

                                      // Colors.black54,
                                      //  Colors.black87,
                                      //  Colors.black87,
                                    ]),
                                    child: Column(children: [
                                      Card(
                                        elevation: 0.4,
                                        child: Wrap(children: [
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .shortestSide /
                                                      20),
                                              child:
                                                  CircularStepProgressIndicator(
                                                totalSteps: streako.streakDays,
                                                currentStep:
                                                    streako.streakCount,
                                                stepSize: streako.streakDays
                                                    .toDouble(),
                                                selectedColor:
                                                    Color(0xff4785FF),
                                                unselectedColor: Theme.of(
                                                        context)
                                                    .scaffoldBackgroundColor,
                                                padding: 0,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .shortestSide /
                                                    2.5,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .shortestSide /
                                                    2.5,
                                                selectedStepSize: 15,
                                                roundedCap: (_, __) => true,
                                                child: Center(
                                                  child: Text(
                                                      "${streako.streakCount} Days",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                          ListTile(
                                            leading: IconButton(
                                              onPressed: () {
                                                deleteQuotes();
                                                player.play(
                                                  'sounds/notification_simple-01.wav',
                                                  stayAwake: false,
                                                  // mode: PlayerMode.LOW_LATENCY,
                                                );
                                                setState(() {
                                                  streako.streakCount++;

                                                  // what I'm supposed to do here
                                                });
                                              },
                                              icon: Icon(
                                                  CarbonIcons.radio_button,
                                                  color: Colors.blue),
                                            ),
                                            title: Opacity(
                                              opacity: 0.8,
                                              child: Text(
                                                '${(streako.streakName).toString()}',
                                                style: TextStyle(
                                                  fontFamily: "WorkSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          19,
                                                  //  color: Colors.black54,
                                                  //decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ButtonBar(
                                            children: [
                                              Opacity(
                                                opacity: 0.7,
                                                child: Text(
                                                    '${streako.streakRemainder.toString()}'),
                                              ),
                                              Opacity(
                                                opacity: 0.5,
                                                child: Text(
                                                  "•",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    //color: Colors.black54
                                                  ),
                                                ),
                                              ),
                                              Text('${streako.streakEmoji}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  )),
                                              Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      8,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      8,
                                                  child: IconButton(
                                                      icon: Icon(CarbonIcons
                                                          .overflow_menu_horizontal),
                                                      color: Colors.blue,
                                                      onPressed: () {
                                                        player.play(
                                                          'sounds/ui_tap-variant-01.wav',
                                                          stayAwake: false,
                                                          // mode: PlayerMode.LOW_LATENCY,
                                                        );
                                                        showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              // <-- for border radius
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10.0),
                                                              ),
                                                            ),
                                                            builder: (context) {
                                                              return Wrap(
                                                                  children: [
                                                                    MaterialButton(
                                                                      onPressed:
                                                                          () {
                                                                        player
                                                                            .play(
                                                                          'sounds/ui_tap-variant-01.wav',
                                                                          stayAwake:
                                                                              false,
                                                                          // mode: PlayerMode.LOW_LATENCY,
                                                                        );
                                                                        Navigator.pop(
                                                                            context);
                                                                        if (streako.streakEmoji ==
                                                                                "null" &&
                                                                            streako.streakRemainder ==
                                                                                null) {
                                                                          Share.share(
                                                                              "${streako.streakName} \n \n @toodoleeApp",
                                                                              subject: "Today's Toodo");
                                                                        } else if (todo.todoRemainder ==
                                                                            null) {
                                                                          Share.share(
                                                                              "${streako.streakName} \n ${streako.streakEmoji}  \n \n @toodoleeApp",
                                                                              subject: "Today's Toodo");
                                                                        } else if (streako.streakEmoji ==
                                                                            "null") {
                                                                          Share.share(
                                                                              "${streako.streakRemainder}⏰ \n \n @toodoleeApp",
                                                                              subject: "Today's Toodo");
                                                                        } else {
                                                                          Share.share(
                                                                              "${streako.streakName} ${streako.streakEmoji} \n at ${streako.streakRemainder} \n \n @toodoleeApp",
                                                                              subject: "Today's Toodo");
                                                                        }
                                                                      },
                                                                      child:
                                                                          ListTile(
                                                                        leading:
                                                                            Icon(CarbonIcons.share),
                                                                        title: Text(
                                                                            "Share"),
                                                                      ),
                                                                    ),
                                                                    MaterialButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await DavinciCapture
                                                                            .click(
                                                                          imgkey,
                                                                          saveToDevice:
                                                                              true,
                                                                          fileName:
                                                                              "${DateTime.now().microsecondsSinceEpoch}",
                                                                          openFilePreview:
                                                                              true,
                                                                          albumName:
                                                                              "Toodolees",
                                                                          pixelRatio:
                                                                              2,
                                                                          // returnImageUint8List:
                                                                          //     true,
                                                                        );

                                                                        // setState(() {
                                                                        //   initialCanvasColor = null;
                                                                        //   initialmargin =
                                                                        //       EdgeInsets.all(4.0);
                                                                        // });

                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                            backgroundColor: Colors.blue[200],
                                                                            content: Row(
                                                                              children: [
                                                                                Expanded(flex: 1, child: Text("👍", style: TextStyle(color: Colors.white))),
                                                                                Expanded(
                                                                                    flex: 5,
                                                                                    child: Text(
                                                                                      "Share this Will, (Captured)",
                                                                                    )),
                                                                                // MaterialButton(
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
                                                                      // await DavinciCapture.offStage(
                                                                      //     PreviewWidget());

                                                                      child:
                                                                          ListTile(
                                                                        leading:
                                                                            Icon(CarbonIcons.download),
                                                                        title: Text(
                                                                            "Download"),
                                                                      ),
                                                                    ),
                                                                    Divider(),
                                                                    MaterialButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await sbox
                                                                            .deleteAt(index);
                                                                        incrementCount();
                                                                        deleteQuotes();
                                                                        //
                                                                        // Locally locally = Locally(
                                                                        //   context: context,
                                                                        //   payload: 'test',

                                                                        //   //pageRoute: MaterialPageRoute(builder: (context) => MorePage(title: "Hey Test Notification", message: "You need to Work for allah...")),
                                                                        //   appIcon: 'toodoleeicon',

                                                                        //   pageRoute: MaterialPageRoute(
                                                                        //       builder: (BuildContext
                                                                        //           context) {
                                                                        //     return DefaultedApp();
                                                                        //   }),
                                                                        // );

                                                                        // locally.cancel(0);
                                                                        player
                                                                            .play(
                                                                          'sounds/navigation_transition-left.wav',
                                                                          stayAwake:
                                                                              false,
                                                                          // mode: PlayerMode.LOW_LATENCY,
                                                                        );

                                                                        setState(
                                                                            () {});
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          ListTile(
                                                                        leading: Icon(
                                                                            CarbonIcons
                                                                                .delete,
                                                                            color:
                                                                                Colors.redAccent),
                                                                        title:
                                                                            Text(
                                                                          "Delete",
                                                                          style:
                                                                              TextStyle(color: Colors.redAccent),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ]);
                                                            });
                                                      })),
                                            ],
                                          ),
                                        ]),
                                      )
                                    ])));
                          }));
                    }));
          }
        });
  }
}

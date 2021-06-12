import 'package:davinci/core/davinci_capture.dart';
import 'package:davinci/core/davinci_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:gradient_widgets/gradient_widgets.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:toodo/main.dart';

import 'package:share/share.dart';
import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/uis/quotes.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'dart:core';

String firstButtonText = 'Take photo';
Box<TodoModel> box;
var todoList = [];
void incrementCount() {
  totalTodoCount.value++;
}

class TodoCard extends StatefulWidget {
  const TodoCard({
    Key key,
  }) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  GlobalKey imageKey;

  @override
  void initState() {
    super.initState();
  }

  //bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<TodoModel>(todoBoxname).listenable(),
        // ignore: missing_return
        builder: (context, Box<TodoModel> box, _) {
          List<int> keys = box.keys.cast<int>().toList();

          if (todoBox.length == todoBox.length) {
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    //itemCount: box.length,// editing a bit
                    itemCount: box.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, index) => Container(),
                    itemBuilder: (_, index) {
                      final int key = keys[index];
                      final TodoModel todo = box.get(key);
                      String completedTodoName = todo.todoName;
                      String completedTodoEmoji = todo.todoEmoji;
                      String completedTodoRemainder = todo.todoRemainder;

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
                                child: Card(
                                  elevation: 0.4,
                                  child: Wrap(
                                    children: [
                                      ListTile(
                                        leading: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                todo.isCompleted =
                                                    !todo.isCompleted;
                                                if (todo.isCompleted == true) {
                                                  CompletedTodoModel
                                                      completedTodo =
                                                      CompletedTodoModel(
                                                    completedTodoName:
                                                        completedTodoName,
                                                    completedTodoEmoji:
                                                        completedTodoEmoji,
                                                    completedTodoRemainder:
                                                        completedTodoRemainder,
                                                    isCompleted:
                                                        todo.isCompleted = true,
                                                  );
                                                  print(completedTodo
                                                      .completedTodoName);
                                                  completedBox
                                                      .add(completedTodo);
                                                  todoBox.deleteAt(index);
                                                  print(completedBox.length);
                                                }
                                              });
                                              player.play(
                                                'sounds/notification_simple-02.wav',
                                                stayAwake: false,
                                                // mode: PlayerMode.LOW_LATENCY,
                                              );
                                            },
                                            icon: Icon(CarbonIcons.radio_button,
                                                color: Colors.blue)),

                                        title: Opacity(
                                          opacity: 0.8,
                                          child: Text(
                                            '${todo.todoName}',
                                            style: TextStyle(
                                              fontFamily: "WorkSans",
                                              fontStyle: FontStyle.normal,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  19,
                                              fontWeight: FontWeight.w600,

                                              // color: Colors.black54
                                            ),
                                          ),
                                        ),

                                        // subtitle: Text("written on morning"),
                                      ),

                                      // Divider(thickness: 1.2),
                                      ButtonBar(
                                        alignment: MainAxisAlignment.end,
                                        children: [
                                          (todo.todoRemainder) == null
                                              ? Container(
                                                  margin: EdgeInsets.all(0),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: Opacity(
                                                      opacity: 0.7,
                                                      child: Text("Today")),
                                                )
                                              : Opacity(
                                                  opacity: 0.7,
                                                  child: Text(
                                                      '${todo.todoRemainder.toString()}'),
                                                ),
                                          // (todo.todoRemainder) == null ||
                                          //         todo.todoEmoji == "null"
                                          //     ? Container()
                                          //     : Opacity(
                                          //         opacity: 0.5,
                                          //         child: Text(
                                          //           "•",
                                          //           style: TextStyle(
                                          //             fontSize: 14,
                                          //             //color: Colors.black54
                                          //           ),
                                          //         ),
                                          //       ),
                                          (todo.todoEmoji) == "null"
                                              ? Container()
                                              : Text('${todo.todoEmoji}',
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
                                              color: Colors.blue,
                                              onPressed: () {
                                                player.play(
                                                  'sounds/ui_tap-variant-01.wav',
                                                  stayAwake: false,
                                                  // mode: PlayerMode.LOW_LATENCY,
                                                );
                                                showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                    // <-- for border radius
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      topRight:
                                                          Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  builder: (context) {
                                                    return Wrap(
                                                      children: [
                                                        MaterialButton(
                                                          onPressed: () {
                                                            player.play(
                                                              'sounds/ui_tap-variant-01.wav',
                                                              stayAwake: false,
                                                              // mode: PlayerMode.LOW_LATENCY,
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                            if (todo.todoEmoji ==
                                                                    "null" &&
                                                                todo.todoRemainder ==
                                                                    null) {
                                                              Share.share(
                                                                  "${todo.todoName} \n \n @toodoleeApp",
                                                                  subject:
                                                                      "Today's Toodo");
                                                            } else if (todo
                                                                    .todoRemainder ==
                                                                null) {
                                                              Share.share(
                                                                  "${todo.todoName} \n ${todo.todoEmoji}  \n \n @toodoleeApp",
                                                                  subject:
                                                                      "Today's Toodo");
                                                            } else if (todo
                                                                    .todoEmoji ==
                                                                "null") {
                                                              Share.share(
                                                                  "${todo.todoRemainder}⏰ \n \n @toodoleeApp",
                                                                  subject:
                                                                      "Today's Toodo");
                                                            } else {
                                                              Share.share(
                                                                  "${todo.todoName} ${todo.todoEmoji} \n at ${todo.todoRemainder} \n \n @toodoleeApp",
                                                                  subject:
                                                                      "Today's Toodo");
                                                            }
                                                          },
                                                          child: ListTile(
                                                            leading: Icon(
                                                                CarbonIcons
                                                                    .share),
                                                            title:
                                                                Text("Share"),
                                                          ),
                                                        ),
                                                        MaterialButton(
                                                          onPressed: () async {
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
                                                              pixelRatio: 2,
                                                              // returnImageUint8List:
                                                              //     true,
                                                            );

                                                            // setState(() {
                                                            //   initialCanvasColor = null;
                                                            //   initialmargin =
                                                            //       EdgeInsets.all(4.0);
                                                            // });

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        backgroundColor:
                                                                            Colors.blue[
                                                                                200],
                                                                        content:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                                flex: 1,
                                                                                child: Text("👍", style: TextStyle(color: Colors.white))),
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

                                                          child: ListTile(
                                                            leading: Icon(
                                                                CarbonIcons
                                                                    .download),
                                                            title: Text(
                                                                "Download"),
                                                          ),
                                                        ),
                                                        Divider(),
                                                        MaterialButton(
                                                          onPressed: () async {
                                                            await box.deleteAt(
                                                                index);
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
                                                            player.play(
                                                              'sounds/navigation_transition-left.wav',
                                                              stayAwake: false,
                                                              // mode: PlayerMode.LOW_LATENCY,
                                                            );

                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: ListTile(
                                                            leading: Icon(
                                                                CarbonIcons
                                                                    .delete,
                                                                color: Colors
                                                                    .redAccent),
                                                            title: Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .redAccent),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(CarbonIcons
                                                  .overflow_menu_horizontal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                      );
                    }));
          }
        });
  }
}

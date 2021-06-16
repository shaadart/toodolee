import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/main.dart';

//import 'package:share/share.dart';
//import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:toodo/models/completed_todo_model.dart';


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/main.dart';

import 'package:share/share.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:toodo/uis/quotes.dart';

import 'listui.dart';

Box<CompletedTodoModel> cbox;
bool fabScrollingVisibility = true;

class CompletedTodoCard extends StatefulWidget {
  const CompletedTodoCard({
    Key key,
  }) : super(key: key);

  @override
  _CompletedTodoCardState createState() => _CompletedTodoCardState();
}

class _CompletedTodoCardState extends State<CompletedTodoCard> {
  //bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    // return AnimatedList(
    //     key: _listKey,
    //     initialItemCount: cbox.length,
    //     itemBuilder: (BuildContext context, int index, Animation animation) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<CompletedTodoModel>(completedtodoBoxname).listenable(),
        // ignore: missing_return
        builder: (context, Box<CompletedTodoModel> cbox, _) {
          List<int> ckeys = cbox.keys.cast<int>().toList() ?? [];
          if (completedBox.isEmpty == true && todoBox.isEmpty == false) {
            return Column(children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.shortestSide / 15,
                      MediaQuery.of(context).size.shortestSide / 20,
                      MediaQuery.of(context).size.shortestSide / 15,
                      MediaQuery.of(context).size.shortestSide / 60),
                  child: Center(
                    child: Opacity(
                      opacity: 0.5,
                      child: Text(
                        'Completing is the new full',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                  ),
                ),
              ),
            ]);
          } else if (completedBox.length == completedBox.length) {
            return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    //itemCount: box.length,// editing a bit
                    itemCount: cbox.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, index) => Container(),
                    itemBuilder: (_, index) {
                      final int ckey = ckeys[index];
                      final CompletedTodoModel comptodo = cbox.get(ckey);
                      //comptodo.completedTodoName = todoName;

                      //todo.isCompleted = false;
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
                                    '${(comptodo.completedTodoName).toString()}',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
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
                                    deleteQuotes();
                                    player.play(
                                      'sounds/notification_simple-01.wav',
                                      stayAwake: false,
                                      // mode: PlayerMode.LOW_LATENCY,
                                    );
                                    setState(() {
                                      if (comptodo.isCompleted) {
                                        TodoModel incompletedTodo = TodoModel(
                                          todoName: comptodo.completedTodoName,
                                          todoEmoji:
                                              comptodo.completedTodoEmoji,
                                          todoRemainder:
                                              comptodo.completedTodoRemainder,
                                          isCompleted: comptodo.isCompleted =
                                              false,
                                        );
                                        completedBox.deleteAt(index);
                                        todoBox.add(incompletedTodo);

                                        // _listKey.currentState.removeItem(
                                        //     index,
                                        //     (context, animation) =>
                                        //         Container());

                                        /// what I'm supposed to do here

                                      }
                                      //     comptodo.isCompleted = !comptodo.isCompleted;
                                      //     if (comptodo.isCompleted == true) {
                                      //       CompletedTodoModel completedTodo = CompletedTodoModel(
                                      //         completedTodoName: comptodo.completedTodoName,
                                      //         completedTodoEmoji: comptodo.completedTodoEmoji,
                                      //         completedTodoRemainder: comptodo.completedTodoRemainder,
                                      //         isCompleted: comptodo.isCompleted = false,
                                      //       );
                                      //       todoBox.put(key, completedTodo);
                                      //     } else {
                                      //       TodoModel incompletedTodo = TodoModel(
                                      //         todoName: todo.todoName,
                                      //         todoEmoji: todo.todoEmoji,
                                      //         todoRemainder: todo.todoRemainder,
                                      //         isCompleted: todo.isCompleted = false,
                                      //       );
                                      //       todoBox.put(key, incompletedTodo);
                                      //     }
                                      //   });
                                      //   // setState(() {
                                      //   //   todo.isCompleted = !todo.isCompleted;

                                      //   // });
                                      // },

                                      // child:
                                      // ListTile(
                                      //     trailing: Text(
                                      //         "${comptodo.completedTodoEmoji}"),
                                      //     title: Text(
                                      //         "${comptodo.completedTodoName}"),
                                      //     subtitle: Text(
                                      //         "${comptodo.completedTodoRemainder}"));
                                    });
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
                                                    "Hey 👋, Todays Todo is Completed, \n \n ${comptodo.completedTodoName} \n \n 🎉🎉🎉",
                                                    subject: "Today's Toodo");
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
                                                await cbox.deleteAt(index);
                                                incrementCount();
                                                deleteQuotes();

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                leading: Icon(
                                                    CarbonIcons.delete,
                                                    color: Colors.redAccent),
                                                title: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
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
                              ),
                            ],
                          ),
                        ),
                      );
                    }));
          }
        });
  }
}

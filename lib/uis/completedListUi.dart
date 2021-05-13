import 'package:animate_do/animate_do.dart';


import 'package:flutter/material.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/main.dart';
import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/models/todo_model.dart';
//import 'package:share/share.dart';
//import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:toodo/uis/listui.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/main.dart';

import 'package:share/share.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:extended_image/extended_image.dart';

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
  final player = AudioCache();
  //bool isCompleted = false;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    // return AnimatedList(
    //     key: _listKey,
    //     initialItemCount: cbox.length,
    //     itemBuilder: (BuildContext context, int index, Animation animation) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<CompletedTodoModel>(completedtodoBoxname).listenable(),
        builder: (context, Box<CompletedTodoModel> cbox, _) {
          List<int> ckeys = cbox.keys.cast<int>().toList() ?? [];
          if (completedBox.isEmpty == true && todoBox.isEmpty == false) {
            return Column(children: [
              FadeInUp(
                //delay: Duration(milliseconds: 800),
                duration: Duration(milliseconds: 2000),
                child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 15,
                          MediaQuery.of(context).size.width / 60,
                          MediaQuery.of(context).size.width / 15,
                          MediaQuery.of(context).size.width / 30),
                      child: Center(
                        child: Text(
                          'Tap and Add Any Task in the Completed Column',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )),
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
                      return Card(
                        // color: Colors.white,
                        elevation: 0.7,
                        child: Wrap(
                          children: [
                            ListTile(
                                title: Text(
                                  '${(comptodo.completedTodoName).toString()}',
                                  style: TextStyle(
                                    fontFamily: "WorkSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                    color: Colors.black54,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                onLongPress: () {
                                  print("object");
                                },
                                leading: IconButton(
                                  onPressed: () {
                                    player.play(
                                      'sounds/notification_simple-01.wav',
                                      stayAwake: false,
                                      mode: PlayerMode.LOW_LATENCY,
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
                                )
                                // Padding(
                                //   padding: const EdgeInsets.fromLTRB(66.0, 0, 30, 0),
                                //   // child: Text(
                                //   //   'Greyhound d ',
                                //   //   style:
                                //   //       TextStyle(color: Colors.black.withOpacity(0.6)),
                                //   // ),
                                // ),
                                ),
                            ButtonBar(
                              children: [
                                Text(comptodo.completedTodoRemainder == null
                                    ? ""
                                    : '${comptodo.completedTodoRemainder.toString()}'),
                                Text(
                                  (comptodo.completedTodoRemainder) == null ||
                                          (comptodo.completedTodoEmoji == null)
                                      ? ""
                                      : "•",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                                Text(
                                    comptodo.completedTodoEmoji == "null"
                                        ? ""
                                        : '${comptodo.completedTodoEmoji}',
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                IconButton(
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
                                            FlatButton(
                                              onPressed: () {},
                                              child: ListTile(
                                                leading: Icon(CarbonIcons.edit),
                                                title: Text("Edit"),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);

                                                Share.share(
                                                    """Hey 👋, Todays Todo is done:
                                                  ${comptodo.completedTodoName} 

                                                  Share your Todoos from(playstore Link) I am really Excited
                                                  🎉🎉🎉""",
                                                    subject: "Today's Toodo");
                                              },
                                              child: ListTile(
                                                leading:
                                                    Icon(CarbonIcons.share),
                                                title: Text("Share"),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {},
                                              child: ListTile(
                                                leading:
                                                    Icon(CarbonIcons.download),
                                                title: Text("Download"),
                                              ),
                                            ),
                                            Divider(),
                                            FlatButton(
                                              onPressed: () async {
                                                await cbox.deleteAt(index);
                                                incrementCount();
                                                setState(() {});
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
                              ],
                            ),
                          ],
                        ),
                      );
                    }));
          }
        });
  }
}

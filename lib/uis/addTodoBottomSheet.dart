import 'dart:io';

import 'package:animate_do/animate_do.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

import 'package:toodo/main.dart';

import 'dart:async';
import 'package:hive/hive.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:flutter/src/widgets/navigator.dart';

import 'package:toodo/pages/more.dart';
import 'package:toodo/pages/quotes.dart';
import 'package:toodo/processes.dart';
import 'package:toodo/uis/listui.dart';
import 'package:intl/intl.dart';

Box<TodoModel> todoBox;
TodoModel todo;
CompletedTodoModel completedTodo;

void decrementCount() {
  totalTodoCount.value--;
}

bool showEmojiKeyboard = false;
// int indexT;

int initialTodoItem = 0;
final TextEditingController titleController = TextEditingController();
String selectedEmoji;
//String todoName = (titleController.text).toString();
String todoName = null;
String todoRemainder;
bool isCompleted = false;

void addTodoBottomSheet(BuildContext context) {
  FocusNode focusNode = FocusNode();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      // <-- for border radius
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          Widget emojiSelect() {
            return EmojiPicker(
                numRecommended: 25,
                recommendKeywords: todoName == null
                    ? [
                        "ball",
                        "play",
                        "good",
                        "race",
                      ]
                    : todoName.split(" "),
                columns: 7,
                buttonMode: ButtonMode.CUPERTINO,
                rows: 3,
                onEmojiSelected: (emoji, catergory) {
                  setState(() {
                    selectedEmoji = emoji.emoji;
                  });
                });
          }

          @override
          void initState() {
            //super.initState();

            focusNode.addListener(() {
              if (focusNode.hasFocus) {
                setState(() {
                  showEmojiKeyboard = false;
                });
              }
            });
          }

          Future<TimeOfDay> openTimePicker(BuildContext context) async {
            final TimeOfDay t = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());

            if (t != null) {
              setState(() {
                todoRemainder = t.format(context);
              });
            }
          }

          setTodo() {
            player.play(
              'sounds/navigation_forward-selection-minimal.wav',
              stayAwake: false,
              // mode: PlayerMode.LOW_LATENCY,
            );
            todo = TodoModel(
                todoName: todoName,
                todoRemainder: todoRemainder,
                todoEmoji: selectedEmoji.toString(),
                isCompleted: false);

            if ((todo.todoName).runtimeType != Null &&
                todo.todoName.length >= 2) {
              decrementCount();

              if (todo.todoRemainder == null) {
                print("No Remainders Set");
              } else if (todo.todoRemainder != null) {
                if (todo.todoRemainder.contains("PM") == true) {
                  var splittingSpace = todo.todoRemainder.split(" ");
                  var removePM = splittingSpace.removeAt(0);

                  var removeUnwantedSymbol = removePM.split(":");

                  Map convertTimetotwentyFourHourClock = {
                    1: 13,
                    2: 14,
                    3: 15,
                    4: 16,
                    5: 17,
                    6: 18,
                    7: 19,
                    8: 20,
                    9: 21,
                    10: 22,
                    11: 23,
                    12: 24
                  };
                  var hourToBeChanged = int.parse(removeUnwantedSymbol.first);

                  var hour = convertTimetotwentyFourHourClock[hourToBeChanged];
                  var minute = removeUnwantedSymbol.last;

                  var remainderTime = [hour.toString(), minute.toString()];
                  print(remainderTime);
                  print(hour);
                  print(minute);

                  setRemainderMethod(remainderTime, todo.todoName,
                      totalTodoCount.value, context);
                } else if (todo.todoRemainder.contains("AM") == true) {
                  var splittingSpace = todo.todoRemainder.split(" ");
                  var removeAM = splittingSpace.removeAt(0);

                  var remainderTime = removeAM.split(":");

                  setRemainderMethod(remainderTime, todo.todoName,
                      totalTodoCount.value, context);
                } else if (todo.todoRemainder.contains("AM") == false &&
                    todo.todoRemainder.contains("PM") == false) {
                  var remainderTime = todo.todoRemainder.split(":");

                  setRemainderMethod(remainderTime, todo.todoName,
                      totalTodoCount.value, context);
                }
              }
            } else if (todoName.runtimeType == Null ||
                (todo.todoName).runtimeType == Null) {
              print("No means no i will not do anything, hmmm");
            }
            // : setRemainderMethod(
            //     todo.todoRemainder,
            //     todo.todoName,
            //     todoBox.length +
            //         completedBox.length,
            //     context);
            print(
                "${totalTodoCount.value} is the current value of the channel id");
            setState(() {
              // todoName == null;
              // todoRemainder = null;
              titleController.clear();
              todoRemainder = null;
              selectedEmoji = null;
            });

            if (todo.todoName != null) {
              todoBox.add(todo);
              deleteQuotes();

              player.play(
                'sounds/hero_decorative-celebration-02.wav',
                stayAwake: false,
                // mode: PlayerMode.LOW_LATENCY,
              );

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.blue[200],
                  content: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                              todo.todoEmoji == "null"
                                  ? "👍"
                                  : "${todo.todoEmoji}",
                              style: TextStyle(color: Colors.white))),
                      Expanded(
                          flex: 5,
                          child: FadeOutRight(
                            child: Text(
                              "${todo.todoName}, is Added to the Toodolee",
                            ),
                          )),
                      // FlatButton(
                      //   child: Text("Undo"),
                      //   color: Colors.white,
                      //   onPressed: () async {
                      //     await box.delete();
                      //     Navigator.pop(context);
                      //   },
                      // ),
                    ],
                  )));
            }
          }

          return Wrap(
            children: [
              WillPopScope(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      //height: MediaQuery.of(context).size.height / 4.8,
                      children: [
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeIn(
                              child: TextFormField(
                                controller: titleController,
                                maxLength: 20,
                                onFieldSubmitted: (value) {
                                  setTodo();
                                  deleteQuotes();
                                  todoName = null;
                                  titleController.clear();
                                },
                                onChanged: (value) {
                                  todoName = value;
                                },
                                onTap: () {
                                  showEmojiKeyboard = false;
                                },
                                focusNode: focusNode,
                                autofocus: true,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  hoverColor: Colors.amber,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(CarbonIcons.pen_fountain,
                                      color: Theme.of(context).accentColor),
                                  hintText: "What toodo?",
                                  hintStyle: TextStyle(
                                      // color: Colors.black54,
                                      fontWeight: FontWeight.w200),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),
                              ),
                            ),
                            Row(
                              //  crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FadeInUp(
                                      child: IconButton(
                                        icon: (todoRemainder != null)
                                            ? Icon(
                                                CarbonIcons.notification_filled,
                                                color: Theme.of(context)
                                                    .accentColor)
                                            : Opacity(
                                                opacity: 0.6,
                                                child: Icon(
                                                    CarbonIcons.notification,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface)),
                                        onPressed: () async {
                                          await openTimePicker(context);
                                          player.play(
                                            'sounds/navigation_forward-selection-minimal.wav',
                                            stayAwake: true,
                                            // mode: PlayerMode.LOW_LATENCY,
                                          );
                                          // todoRemainder = timeChoosen as DateTime;
                                        },
                                      ),
                                    ),
                                    FadeInUp(
                                      child: IconButton(
                                        icon: selectedEmoji == null
                                            ? Opacity(
                                                opacity: 0.6,
                                                child: Icon(
                                                    CarbonIcons.face_add,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface),
                                              )
                                            : Text(
                                                selectedEmoji,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                        onPressed: () {
                                          player.play(
                                            'sounds/navigation_forward-selection-minimal.wav',
                                            stayAwake: false,
                                            // mode: PlayerMode.LOW_LATENCY,
                                          );
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            showEmojiKeyboard =
                                                !showEmojiKeyboard;
                                          });
                                        },
                                        //color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: MediaQuery.of(context)
                                                .size
                                                .shortestSide /
                                            30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        FadeInRight(
                                          child: FlatButton.icon(
                                              color:
                                                  Theme.of(context).accentColor,
                                              //hero_decorative-celebration-02.wav
                                              onPressed: () {
                                                setTodo();
                                                todoName = null;
                                                titleController.clear();

                                                print((todo.todoName)
                                                    .runtimeType);
                                                //sleep(Duration(seconds: 1));
                                              },
                                              icon: Icon(CarbonIcons.add),
                                              label: Text(
                                                "Add Todo",
                                                style: TextStyle(
                                                    //color: Colors.white
                                                    ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    showEmojiKeyboard == true ? emojiSelect() : Container(),
                  ],
                ),
                onWillPop: () {
                  if (showEmojiKeyboard) {
                    setState(() {
                      showEmojiKeyboard = false;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                  return Future.value(false);
                },
              ),
            ],
          );
        }),
      );
    },
  );
}

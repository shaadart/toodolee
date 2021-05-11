import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toodo/main.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/pages/listspage.dart';
import 'package:toodo/uis/listui.dart';
import 'package:intl/intl.dart';

Box<TodoModel> todoBox;
TodoModel todo;
void decrementCount() {
  totalTodoCount.value--;
}

// int indexT;

int initialTodoItem = 0;
final TextEditingController titleController = TextEditingController();
String selectedEmoji;
String todoName = (titleController.text).toString();
String todoRemainder;
bool isCompleted = false;
bool showEmojiKeyboard = false;
void addTodoBottomSheet(context) {
  FocusNode focusNode = FocusNode();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    isDismissible: true,
    shape: RoundedRectangleBorder(
      // <-- for border radius
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        final player = AudioCache();
        Widget emojiSelect() {
          return EmojiPicker(
              numRecommended: 25,
              recommendKeywords: todoName.split(" "),
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

        return Wrap(
          children: [
            WillPopScope(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                //mainAxisAlignment: MainAxisAlignment.end,
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
                                prefixIcon: Icon(CarbonIcons.pen_fountain),
                                hintText: "What toodo?",
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w200),
                                contentPadding: EdgeInsets.all(20.0),
                              ),
                            ),
                          ),
                          // TextFormField(
                          //   autocorrect: true,
                          //   decoration: InputDecoration(
                          //     hoverColor: Colors.amber,
                          //     border: InputBorder.none,
                          //     prefixIcon: Icon(CarbonIcons.pen),
                          //     hintText: "Description (optional)",
                          //     hintStyle: TextStyle(
                          //         color: Colors.black54,
                          //         fontWeight: FontWeight.w200),
                          //     contentPadding: EdgeInsets.all(20.0),
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FadeInUp(
                                    child: IconButton(
                                      icon: (todoRemainder != null)
                                          ? Icon(
                                              CarbonIcons.notification_filled,
                                              color: Colors.blue)
                                          : Icon(CarbonIcons.notification),
                                      onPressed: () async {
                                        await openTimePicker(context);
                                        player.play(
                                          'sounds/navigation_forward-selection-minimal.wav',
                                          stayAwake: false,
                                          mode: PlayerMode.LOW_LATENCY,
                                        );
                                        // todoRemainder = timeChoosen as DateTime;
                                      },
                                      color: (todoRemainder != null)
                                          ? Colors.blue
                                          : Colors.black54,
                                    ),
                                  ),
                                  FadeInUp(
                                    child: IconButton(
                                      icon: selectedEmoji == null
                                          ? Icon(CarbonIcons.face_add)
                                          : Text(
                                              selectedEmoji,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                      onPressed: () {
                                        player.play(
                                          'sounds/navigation_forward-selection-minimal.wav',
                                          stayAwake: false,
                                          mode: PlayerMode.LOW_LATENCY,
                                        );
                                        focusNode.unfocus();
                                        focusNode.canRequestFocus = false;
                                        setState(() {
                                          showEmojiKeyboard =
                                              !showEmojiKeyboard;
                                        });
                                      },
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              FadeInRight(
                                child: FlatButton.icon(
                                    //hero_decorative-celebration-02.wav
                                    onPressed: () {
                                      player.play(
                                        'sounds/hero_decorative-celebration-02.wav',
                                        stayAwake: false,
                                        mode: PlayerMode.LOW_LATENCY,
                                      );

                                      todo = TodoModel(
                                          todoName: todoName,
                                          todoRemainder: todoRemainder,
                                          todoEmoji: selectedEmoji.toString(),
                                          isCompleted: false);

                                      if (todo.todoName.length > 2) {
                                        setState(() {
                                          todoRemainder = null;
                                          titleController.clear();
                                        });
                                        Navigator.pop(context);
                                        todoBox.add(todo);
                                        print(
                                            "${DateFormat("hh:mm").parse(todo.todoRemainder)} is the time you kniw?");
                                        decrementCount();
                                        scheduleAlarm(DateFormat("hh:mm")
                                            .parse(todo.todoRemainder));
                                        Navigator.pop(context);
                                        //scheduleAlarm();
                                        //scheduleAlarm(todoRemainder);
                                        //scheduleAlarm(DateTime.parse(todoRemainder));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    Colors.blue[200],
                                                content: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            todo.todoEmoji ==
                                                                    "null"
                                                                ? "👍"
                                                                : "${todo.todoEmoji}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white))),
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
                                                    //   onPressed: () async{
                                                    //     await box.deleteAt(index);
                                                    //     Navigator.pop(context);
                                                    //   },
                                                    // ),
                                                  ],
                                                )));
                                      }

                                      //sleep(Duration(seconds: 1));
                                    },
                                    color: Colors.blue,
                                    icon: Icon(
                                      CarbonIcons.add,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      "Add Todo",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              Divider(),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  showEmojiKeyboard ? emojiSelect() : Container(),
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
      });
    },
  );
}

void scheduleAlarm(DateTime timetoBeRemainded) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    "${todoBox.length}",
    'todo_notification',
    'Channel for Alarm notification',
    icon: 'app_icon',
    sound: RawResourceAndroidNotificationSound('alert_simple.wav'),
    largeIcon: DrawableResourceAndroidBitmap('app_icon'),
  );

  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'alert_simple.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true);
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.schedule(
      todoBox.length,
      todo.todoName,
      "It's time to work on, ${todo.todoName}",
      timetoBeRemainded,
      // DateTime.parse(todo.todoRemainder),
      platformChannelSpecifics);
}

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:toodo/main.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:toodo/models/todo_model.dart';

Box<TodoModel> todoBox;
int totalTodoItem = 10;

String selectedEmoji;

void addTodoBottomSheet(context) {
  String todoName = (titleController.text).toString();
  String todoRemainder;

  bool showEmojiKeyboard = false;

  FocusNode focusNode = FocusNode();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
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
        Widget emojiSelect() {
          return EmojiPicker(
              numRecommended: 25,
              recommendKeywords: todoName.split(" "),
              columns: 7,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Wrap(
                    //height: MediaQuery.of(context).size.height / 4.8,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: titleController,
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
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(CarbonIcons.notification),
                                    onPressed: () async {
                                      openTimePicker(context);
                                      print(time.hour);
                                      // todoRemainder = timeChoosen as DateTime;
                                    },
                                    color: Colors.black54,
                                  ),
                                  IconButton(
                                    icon: selectedEmoji == null
                                        ? Icon(CarbonIcons.face_add)
                                        : Text(
                                            selectedEmoji,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                    onPressed: () {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                      setState(() {
                                        showEmojiKeyboard = !showEmojiKeyboard;
                                      });
                                    },
                                    color: Colors.black54,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FlatButton.icon(
                                      onPressed: () {
                                        TodoModel todo = TodoModel(
                                            todoName: todoName,
                                            todoRemainder: todoRemainder,
                                            todoEmoji: selectedEmoji.toString(),
                                            isCompleted: false);

                                        if (todo.todoName.length > 2) {
                                          todoBox.add(todo);
                                        }
                                        totalTodoItem = totalTodoItem - 1;

                                        Navigator.pop(context);

                                        setState(() {
                                          print(totalTodoItem);
                                        });
                                      },
                                      color: Colors.blue,
                                      icon: Icon(
                                        CarbonIcons.add,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        "Add Todo",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
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

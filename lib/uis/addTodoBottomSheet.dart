import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:emoji_picker/emoji_picker.dart';

void addTodoBottomSheet(context) {
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
      // Using Wrap makes the bottom sheet height the height of the content.
      // Otherwise, the height will be half the height of the screen.
      return StatefulBuilder(builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) {
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
                            focusNode: focusNode,
                            autofocus: false,
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
                                      final TimeOfDay newTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime:
                                            TimeOfDay(hour: 7, minute: 15),
                                      );
                                    },
                                    color: Colors.black54,
                                  ),
                                  IconButton(
                                    icon: Icon(CarbonIcons.face_add),
                                    onPressed: () {
                                      setState(() {
                                        focusNode.unfocus();
                                        focusNode.canRequestFocus = false;
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
                                      onPressed: () {},
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

Widget emojiSelect() {
  return EmojiPicker(
      numRecommended: 25,
      recommendKeywords: ["sing", "coding"],
      columns: 7,
      rows: 3,
      onEmojiSelected: (emoji, catergory) {
        print(emoji);
      });
}

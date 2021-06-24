import 'package:animate_do/animate_do.dart';
import 'package:better_cupertino_slider/better_cupertino_slider.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:toodo/Notification/setNotification.dart';
import 'package:toodo/main.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/models/Streak%20Model/streak_model.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:yudiz_modal_sheet/yudiz_modal_sheet.dart';

Box<TodoModel> todoBox; //box that stores todo
TodoModel todo; //model of TodoModel
StreakModel streak; // model of StreakModel
CompletedTodoModel completedTodo; // model of CompletedTodoModel

/* When the Tooodo is added (it is a possibility though).
so it will decrease the count of totalTodoCount, 
because the total count is initially 10, 

we will decrease the totalTodoCount as the thing will be added.
So thats why incrementing the count is also beneficial as the decrement count count, 
otherwise the tooodolee count or  Remaining count will only increase not decrease.) 
*/
void decrementCount() {
  totalTodoCount.value--; // making the totalTodoCount -1
}

bool showEmojiKeyboard =
    false; // Firrst the Emoji Keybard will not show itself, Whaat? It will look wiered if it will pump his face just after pressing floating action button
final TextEditingController titleController =
    TextEditingController(); // This takes Text from the Text field
String todoEmoji; // Emoji Tag associated with Tooodo
//String todoName = (titleController.text).toString();
String todoName; //Name associated with Tooodo
String todoRemainder; // remainder associated with Tooodo
bool isCompleted =
    false; // initially the toodo will be completed. what? you want it to be completed?

//addTodoBooooootomSheet is is method which will show up the bottom sheet when the addTodoBooooootomSheet() will be called.
void addTodoBottomSheet(context) {
  var enableHabitButton = false;
  //Habit Button will be available when the Remainder should not be null,
  //hence at first the remainder will be null so, also habit button will not be seen,
  // hence declaring it false, because Habit is depended upon Time.
  //And if there is not Time, No Habit,
  //And there is no good in showing Habit button that earlily,
  //so showing let be false
  FocusNode focusNode =
      FocusNode(); //This will help us with focusing on Text Field.

  showModalBottomSheet(
    isScrollControlled: true,
    // For Responsiveness,
    // Otherwise it just not open and drag up with Keyboard.
    //This setting = true, can help against the text field that goes behind the keyboard. this setting fixes it.
    context: context,
    shape: RoundedRectangleBorder(
      // for border radius
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    builder: (context) {
      return SingleChildScrollView(
        // Making it a Scroll-View
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          // This property converts a Method to a Stateful Widget, as we are dealing with setState then this configuration is worth it.
          Widget emojiSelect() {
            // Method of calling emojiKeyboard and taking it's input
            return EmojiPicker(
                numRecommended: 25,
                // if in somecase todoname == null, then recommned emojis of these.
                recommendKeywords: todoName == null
                    ? [
                        "ball",
                        "play",
                        "work",
                        "home",
                        "school",
                      ]
                    : todoName.split(" "),
                columns: 7,
                buttonMode: ButtonMode.CUPERTINO,
                rows: 3,
                onEmojiSelected: (emoji, catergory) {
                  // When the Emoji is picked the todoEmoji(string) will replaced by that emoji(string, (at least, I guess (like seriosly(many circular brackets))))
                  setState(() {
                    todoEmoji = emoji.emoji;
                  });
                });
          }

          @override
          void initState() {
            //super.initState();
// when the Keyboard is opened, hide the emojiKeyboard
            focusNode.addListener(() {
              if (focusNode.hasFocus) {
                setState(() {
                  showEmojiKeyboard = false;
                });
              }
            });
          }

// This is the Time Pciker, this method opens timepicker.
          Future<TimeOfDay> openTimePicker(BuildContext context) async {
            final TimeOfDay t = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());

            if (t != null) {
              // everytime new Time is picked it replaces the previous one,
              //and here todoRemainder is the variable who is storing this time in itself
              setState(() {
                todoRemainder = t.format(context);
              });
            }
          }

          // This Method set Tooodo, As everything is added, it sets remainder,
          //it then resets the bottom sheet to zero so no footprints of the older task afftect the new upcomming one.
          // Everything is so clean, UNLIKE MY COMMENTS

          setTodo() {
            player.play(
              'sounds/navigation_forward-selection-minimal.wav',
              stayAwake: false,
            );
            // in the model we are just fitting the objects,
            // so later we will add it,
            // This is the main part, it is from where all the things get add in.
            todo = TodoModel(
                todoName: todoName,
                todoRemainder: todoRemainder,
                todoEmoji: todoEmoji.toString(),
                isCompleted: false);

            if ((todo.todoName).runtimeType != Null &&
                todo.todoName.length >= 2) {
              decrementCount(); // which means the (remember the home screen says, "You can add 4 more"), we are decresing it, so it will be like "You can add 3 more"

//Here checking that if remainder is null then set no remainders, if user has asked to add remaiders for their tooooodo, then Set the Remainder.
              if (todo.todoRemainder == null) {
                print("No Remainders Set");
              } else if (todo.todoRemainder != null) {
                /* Many of the people use AM/PM things and many of them use 24 hour mode, 
                so the toodolee is for everyone, 
                so we had to set remainders for both of the every group. 
                so we are doing - 
                
                if remainder has PM, then Remove PM from the game, whatever left set that as the remainder. 
                If remainder has AM in it, then Remove AM from the game, whatever left set that as the remainder. 
                The errors preceds for this group,
                Suppose one of the hero, woke up at 6:00 and set the remainder of "Create Quadcopter 🚁 at 8 pm", 
                then the Notification can set Remainders for 8:00 am and won't ring at 8:00 night! 
                (Grave errrrror Right).
                That's they are using something, 
                1. Remove the PM/AM
                2. Converts whatever number they have to 24 hours clock.

                In this way it is efficient and more reliable.
                This process is done by the Function, getRemainderTime().
                which is in the last line of the addTodoBottomSheet.dart

                BTW,
                and if remainder has nothing, i.e PM/AM then, this is clear person has set remainder from 24 hours clock.
                So setting remianders in this case is easy as eatin Eat Watermelons.
                
                For more Info also Check setRemainderMethod(), which is in setNotification.dart in Notification File.
                For more Info, Check getRemainderTime() method, which is in the last line of the Notification/setNotification.dart
                */
                if (todo.todoRemainder.contains("PM") == true) {
                  // if the remainder has PM in it.
                  setRemainderMethod(
                      getRemainderTime(todo.todoRemainder, context),
                      todo.todoName,
                      (getRemainderTime(todo.todoRemainder, context).first +
                          getRemainderTime(todo.todoRemainder, context).last),
                      context);
                  print(
                      "${((getRemainderTime(todo.todoRemainder, context).first + getRemainderTime(todo.todoRemainder, context).last))} is the current value of the channel id");
                } else if (todo.todoRemainder.contains("AM") == true) {
                  setRemainderMethod(
                      getRemainderTime(todo.todoRemainder, context),
                      todo.todoName,
                      (getRemainderTime(todo.todoRemainder, context).first +
                          getRemainderTime(todo.todoRemainder, context).last),
                      context);
                  print(
                      "${(getRemainderTime(todo.todoRemainder, context).first + getRemainderTime(todo.todoRemainder, context).last)} is the current value of the channel id");
                } else if (todo.todoRemainder.contains("AM") == false &&
                    todo.todoRemainder.contains("PM") == false) {
                  setRemainderMethod(
                      getRemainderTime(todo.todoRemainder, context),
                      todo.todoName,
                      (getRemainderTime(todo.todoRemainder, context).first +
                          getRemainderTime(todo.todoRemainder, context).last),
                      context);
                  print(
                      "${(getRemainderTime(todo.todoRemainder, context).first + getRemainderTime(todo.todoRemainder, context).last)} is the current value of the channel id");
                }
              }
              //If user is trying to add something, which has no letters, then,
            } else if (todoName.runtimeType == Null ||
                (todo.todoName).runtimeType == Null) {
              print("No means no I will not do anything, hmmm");
            }
//Then we are clearing the old todo (which is added) footprints and reseting it to brand new.
            setState(() {
              titleController.clear();
              todoRemainder = null;
              todoEmoji = null;
            });

// If everything is good, user has added todo which is some pair of letters and todoName is not null, then,
// we will jump to WorkingOnPage() and also change chips, set every chip false and make the workingSelectedChip to true, i.e First Page before streaks.

            if (todo.todoName != null) {
              // deleteQuotes();
              setState(() {
                initialselectedPage = 0;

                settingsBox.put("selectedPage", 0);
              });
              settingsBox.put("workingSelectedChip", true);

              settingsBox.put("completedSelectedChip", false);

              player.play(
                'sounds/hero_decorative-celebration-02.wav',
                stayAwake: false,
              );
// Finally Adding the Toooodooleee. yay
              todoBox.add(todo);
              //Hiding the BottomSheet
              Navigator.pop(context);
              //Giving user feedback with the SnackBar, (gradient) that, yay! that the emotion is added.
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
                    ],
                  )));
            }
          }

          setChallenge(context) {
            if (enableHabitButton == false) {
              YudizModalSheet.show(
                  context: context,
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.9),
                  child: Container(
                    color: Theme.of(context).canvasColor,
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide / 20),
                      child: Center(child: SetChallenge()),
                    ),
                  ),
                  direction: YudizModalSheetDirection.TOP);
            }
          }

          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                WillPopScope(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        //height: MediaQuery.of(context).size.longestSide / 4.8,
                        children: [
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FadeIn(
                                child: TextFormField(
                                  controller: titleController,
                                  maxLength: 20,
                                  onFieldSubmitted: (value) {
                                    //after the field is submitted successful,
                                    // add whatever is in the field.
                                    // and reset the bottom sheet.
                                    setTodo();
                                    // deleteQuotes();
                                    todoName = null;
                                    titleController.clear();
                                  },
                                  onChanged: (value) {
                                    // whatever changes happenns ti the field, it will change the todoName to the value.
                                    todoName = value;
                                  },
                                  onTap: () {
                                    // Wheneve the Text-Field is opened, the EmojiKeyboard will be closed, and vice-versa.
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
                                                  CarbonIcons
                                                      .notification_filled,
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
                                            //oopening the TimePicker, so to add Remainder
                                            await openTimePicker(context);
                                            player.play(
                                              'sounds/navigation_forward-selection-minimal.wav',
                                              stayAwake: true,
                                            );
                                          },
                                        ),
                                      ),
                                      FadeInUp(
                                        child: IconButton(
                                          icon: todoEmoji == null
                                              ? Opacity(
                                                  opacity: 0.6,
                                                  child: Icon(
                                                      CarbonIcons.face_add,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface),
                                                )
                                              : Text(
                                                  todoEmoji,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                          onPressed: () {
                                            player.play(
                                              'sounds/navigation_forward-selection-minimal.wav',
                                              stayAwake: false,
                                            );
                                            //Just focusing and unfocusing,
                                            //if emojiKeyboard is on then it will turn to off if the Emoji Button willl be tapped,
                                            //and if it is off then it will be turned on
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            setState(() {
                                              showEmojiKeyboard =
                                                  !showEmojiKeyboard;
                                            });
                                          },
                                        ),
                                      ),

                                      //Streaks. yay!
                                      // So if the remainder is not null, then Habit buttom will appear, this will help build streaks,
                                      // If the button is tapped the Top Sheet will be slided and we will be able to set challenge of how long. <3 & >45
                                      if (todoRemainder != null)
                                        FadeInUp(
                                          child: IconButton(
                                            icon: Icon(
                                              CarbonIcons.edt_loop,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // Hide the Bottom sheet, so it will not annoy the upcomming Top Sheet.
                                              setChallenge(
                                                  context); //This will open the TopSheet where these is the rain of challenge.
                                            },
                                          ),
                                        )
                                      else
                                        Container(),
                                    ],
                                  ),
                                  //We cam also Add Tooooodoo from the button. :hehe
                                  // So the Button Serves the same purpose, and it is more reliable, and give the broader look.
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide /
                                              30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          FadeInUp(
                                            child: FlatButton.icon(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                onPressed: () {
                                                  //Resetting and Setting.
                                                  setTodo();
                                                  todoName = null;
                                                  titleController.clear();
                                                },
                                                icon: Icon(
                                                  CarbonIcons.add,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ),
                                                label: Text(
                                                  "Add Toodo",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  /*------------------------------------------------------------------------------------------------*/
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      //If showEmojiKeyboard (a variable); if it is true then show emoji Keyboard,
                      //otherwise a container of 0 height.
                      //Check the emojiSelect() in the addTodoBottomSheet.dart
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
            ),
          );
        }),
      );
    },
  );
}

/* 
Not just giving the cleaner look, but also giving nice things.
This will whole-ly set the Challenge.

# Top Sheet Design
# Set Remianders for StreakModel
# Adds Slider, so You can set your own Streak Duration from 3 days to 45 days.

*/

class SetChallenge extends StatefulWidget {
  const SetChallenge({Key key}) : super(key: key);

  @override
  _SetChallengeState createState() => _SetChallengeState();
}

class _SetChallengeState extends State<SetChallenge> {
  double sliderValue = 3; // starting sliderValue is 3
  var userDemandedDayCount = 3; // what user is demanding is also 3 (inititally)
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(
          "How long to set the challenge 🏁",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),

      ListTile(
          title: Text(
        "$userDemandedDayCount Days", // This Text in Real Time shows, How many days you are demanding.
        style: Theme.of(context).textTheme.subtitle2,
      )),

      // This is the Slider configuration.

      ListTile(
        title: BetterCupertinoSlider(
          min: 3,
          max: 45,
          value: sliderValue, //rememeber 3? twenty-thirty lines above.
          configure: BetterCupertinoSliderConfigure(
            trackHorizontalPadding: 8.0,
            trackHeight: 4.0,
            trackLeftColor: Theme.of(context).primaryColor,
            trackRightColor: Colors.grey.withOpacity(0.3),
            thumbRadius: 8.0,
            thumbPainter: (canvas, rect) {
              final RRect rrect = RRect.fromRectAndRadius(
                rect,
                Radius.circular(rect.shortestSide / 2.0),
              );
              canvas.drawRRect(
                  rrect, Paint()..color = Theme.of(context).accentColor);
            },
          ),
          onChanged: (value) {
            // So when the Slider is changed by you, the onChanged property tracks it and setState the value of sliderValue to be the changed value,
            // That is betweeen 3 to 45 days
            setState(() {
              sliderValue = value;
              print("${sliderValue.round()} days");
              setState(() {
                userDemandedDayCount = sliderValue
                    .round(); //userDemandedDayCount is Integer, and sliderValue is double. so We are rounding it to int, as days are Int not Double..
              });
            });
          },
        ),
      ),
      Divider(),
      /*------------------------------------------------------------------------------------------------*/
      // after presss of the Set Challenge button
      MaterialButton(
          child: Text("Set Challenge",
              style:
                  TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
          onPressed: () {
            setState(() {
              //Every chip is getting false, which means we are trying to open the streakChip and making every else to be the stationary. So, everyone is false except Streaks Chip. (home Page)
              settingsBox.put("streakSelectedChip", true);

              settingsBox.put("workingSelectedChip", false);

              settingsBox.put("completedSelectedChip", false);
            });
            // Whatever Data we got from BottomSheet,
            // We will take it and add it in streakModel and will later add it as a streak,

            streak = StreakModel(
                streakName: todoName,
                streakCount: 0,
                streakRemainder: todoRemainder,
                streakEmoji: todoEmoji.toString(),
                streakDays: userDemandedDayCount,
                isCompleted: false);
            streakBox.add(streak);
            //Appending the data to the streakBox.

//Lemme say it again,

            /* Many of the people use AM/PM things and many of them use 24 hour mode, 
                so the toodolee is for everyone, 
                so we had to set remainders for both of the every group. 
                so we are doing - 
                
                if remainder has PM, then Remove PM from the game, whatever left set that as the remainder. 
                If remainder has AM in it, then Remove AM from the game, whatever left set that as the remainder. 
                The errors preceds for this group,
                Suppose one of the hero, woke up at 6:00 and set the remainder of "Create Quadcopter 🚁 at 8 pm", 
                then the Notification can set Remainders for 8:00 am and won't ring at 8:00 night! 
                (Grave errrrror Right).
                That's they are using something, 
                1. Remove the PM/AM
                2. Converts whatever number they have to 24 hours clock.

                In this way it is efficient and more reliable.
                This process is done by the Function, getRemainderTime().
                which is in the last line of the addTodoBottomSheet.dart

                BTW,
                and if remainder has nothing, i.e PM/AM then, this is clear person has set remainder from 24 hours clock.
                So setting remianders in this case is easy as eatin Eat Watermelons.
                
                For more Info, Check getRemainderTime() method, which is in the last line of the Notification/setNotification.dart
                */
            if (streak.streakRemainder.contains("PM") == true) {
              // Check the getRemainderTime(), this is really impressive to see these two. they are well commented
              //Check the setStreakRemainderMethod() in the Notification\setNotification.dart
              // use ctrl + click in both setStreakRemainderMethod and getRemainderTime
              setStreakRemainderMethod(
                  getRemainderTime(streak.streakRemainder, context),
                  streak.streakName,
                  streak.streakEmoji,
                  (getRemainderTime(streak.streakRemainder, context).first +
                      getRemainderTime(streak.streakRemainder, context).last +
                      100),
                  context);
            } else if (streak.streakRemainder.contains("AM") == true) {
              // Check the getRemainderTime(), this is really impressive to see these two. they are well commented
              //Check the setStreakRemainderMethod() in the Notification\setNotification.dart
              // use ctrl + click in both setStreakRemainderMethod and getRemainderTime
              setStreakRemainderMethod(
                  getRemainderTime(streak.streakRemainder, context),
                  streak.streakName,
                  streak.streakEmoji,
                  (getRemainderTime(streak.streakRemainder, context).first +
                      getRemainderTime(streak.streakRemainder, context).last +
                      100),
                  context);
            } else if (streak.streakRemainder.contains("AM") == false &&
                streak.streakRemainder.contains("PM") == false) {
              // Check the getRemainderTime(), this is really impressive to see these two. they are well commented
              //Check the setStreakRemainderMethod() in the Notification\setNotification.dart
              // use ctrl + click in both setStreakRemainderMethod and getRemainderTime
              setStreakRemainderMethod(
                  getRemainderTime(streak.streakRemainder, context),
                  streak.streakName,
                  streak.streakEmoji,
                  (getRemainderTime(streak.streakRemainder, context).first +
                      getRemainderTime(streak.streakRemainder, context).last +
                      100),
                  context);
            }
            //play fancy sounds
            player.play(
              'sounds/hero_decorative-celebration-02.wav',
              stayAwake: false,
            );
            // decrement the count, of toodolees as the toodolee is limited to ten.
            decrementCount();
            setState(() {
              // Reset the Bottomsheet so for adding the future Tooodooleees at ease.
              todoName = null;
              titleController.clear();
              todoRemainder = null;
              todoEmoji = null;
              initialselectedPage = 1;
            });
            // Hide the TopSheet. or challenge sheet.
            Navigator.pop(context);
          },
          color: Theme.of(context).accentColor)
    ]);
  }
}

/* One Most beautiful and elegant thing, that seriouslt reduces a good amount of code.

This Method senses the whatever String or more specifically time,
and gives the outputs as according to them.

Like if the Remainder has PM keyword in it. then it will change PM to 24 hour clock timings like 7:00 pm is 19:00
If the Remainder has AM in it, let there be no change, except remiving rhe AM keyword like how we were remving in PM.
If the Remainder is 24 hours. then no need to make good changes.


 */

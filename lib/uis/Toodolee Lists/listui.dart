import 'package:davinci/core/davinci_capture.dart';
import 'package:davinci/core/davinci_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/Notification/NotificationsCancelAndRestart.dart';
import 'package:toodo/main.dart';
import 'package:share/share.dart';
import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'dart:core';
import '../quotes.dart';

/*
When the Toodo is Added it jumps to the TodoCard.
# Whole different UI
# Helps Distinguish between completed Toodolees and Incompleted Ones
# Share the Completed Ones
# Download the Toodolees to Images, because an Image says, More than A Billion Words.
# Delete etc.

*/

Box<TodoModel> box;

/* When the Tooodo is deleted (it is a possibility) 
so it will increase the count of totalTodoCount, 
because the total count is initially 10, 
if you pour it will power efficient things to do, then it will go -1 (less).
hence, lets say, it comes to 6, by decrementing -1, 
now If the Toodo is deleted, 
we will Increase the totalTodoCount as the thing which was added is now deleted (equation cancelled),
So thats why decrementing count is also beneficial as the incrementing count, 
otherwise the tooodolee count or  Remaining count will only decrease not increase.) 
*/
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
  // To Download the Card,
  // We have to make a Global Key,
  // as the Package(Davinci) needs it.

  @override
  void initState() {
    super.initState();
  }

  /*
todoBox is the listenable, so whenever the changes will be done in this box (hive), 
The UI will change itself, and reload itself.
 */

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<TodoModel>(todoBoxname).listenable(),
        // ignore: missing_return
        builder: (context, Box<TodoModel> box, _) {
          // calling the todoBox with "box" as a name
          List<int> keys = box.keys.cast<int>().toList();
// casting the box, aligning it's keys to list.
          if (todoBox.length == todoBox.length) {
            return SingleChildScrollView(
                //Scrool View (Activated)
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                child: ListView.separated(
                    // ListView is added, the length of it is the length of todoBox

                    physics: NeverScrollableScrollPhysics(),
                    itemCount: box.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, index) => Container(),
                    itemBuilder: (_, index) {
                      final int key = keys[index]; //getting the index.
                      final TodoModel todo =
                          box.get(key); // get that key from that index.
                      String completedTodoName = todo
                          .todoName; //shorty-fying the name of the toodo, beside writig the todo.todoName making it simple and understanding to write, but most of the main reason is the for moving this to completed space will help.
                      String completedTodoEmoji =
                          todo.todoEmoji; // same as above
                      String completedTodoReminder = todo.todoReminder; // ..

                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.shortestSide / 35,
                            0,
                            MediaQuery.of(context).size.shortestSide / 35,
                            0),
                        child: Davinci(builder: (imgkey) {
                          // For the Image, the more the widget takes Area, it will take a Phoooto.
                          this.imageKey = imgkey;
                          // it takes the key, (wait, we have it, on top)

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
                                              /*
                                   Whenever the Leading button (radio/circular one) is pressed it will -
                                  # delete the quotes, Check the quotes.dart, in it, it says whenever the quote is deleted the App creates or finds another quote in the mean time. so the main motive of deleting is to get new one. 
                                  The Mechanism is simple the more person will complete Tooodoolees the more quotes will emerge.

                                  #Sounds will be played
                                  # It will cancel the notifications. (because the thing is done, and why need to get addictional Reminders.)
                                  # Check-ing the circular/radio/leading button, this will cause the following to go to the Completed Todo
                                  # As it is adding in the completed Todo or Completed Page then this will also remove the same element from the ship, So the todo will not build-up multiple times in one place.
                                  
                                   */
                                              if (todo.isCompleted == false) {
                                                //It will be pushed to CompletedTodoModel,
                                                // By the same details it have already, asplus, removng the Item from TodoModel
                                                // To Summerize, the TodoModel's Item or Object will be pushed to CompletedTodoModel
                                                //when Leading Icon (radio/Circular Button is Pressed)
                                                // and the Item which was already there in the Incompleted Place or TodoModel (incompleted it is) will be deleted from the index.
                                                CompletedTodoModel
                                                    completedTodo =
                                                    CompletedTodoModel(
                                                  completedTodoName:
                                                      completedTodoName,
                                                  completedTodoEmoji:
                                                      completedTodoEmoji,
                                                  completedTodoReminder:
                                                      completedTodoReminder,
                                                  isCompleted:
                                                      todo.isCompleted = true,
                                                );

                                                completedBox.add(
                                                    completedTodo); // adding the details to CompletedTodoBox
                                                todoBox.deleteAt(
                                                    index); // delete from Index
                                                if (completedTodoReminder !=
                                                    null) {
                                                  cancelReminderNotifications(
                                                      completedTodoReminder,
                                                      context);
                                                }
                                                // Cancelling the Notifications.
                                                //Check the well understanding and commented, cancelStreakNotifications() Method in the Notification/setReminder.dart

                                              }

                                              player.play(
                                                'sounds/notification_simple-02.wav',
                                                stayAwake: false,
                                              );
                                              deleteQuotes(); // reseeting the quotes.
                                            },
                                            icon: Icon(CarbonIcons.radio_button,
                                                color: Colors.blue)),
                                        title: Opacity(
                                          opacity: 0.8,
                                          child: Text(
                                            '${todo.todoName}', // The Name of Tooodo
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
                                      ),
                                      /* Meet ButtonBar,
                                      Dependent upon how much data is passed for this, if
                                      Its on user, user want to set Reminders or not, 
                                      Its on you, if you want to set Emojis or not,

                                      So to Make Toooodooleee for everyone then this Button Bar is configured
                                      
                                      if Reminder is null, except being empty show, "Today" reffering to the whole day,
                                      If Reminder is not null, show the reminder time,

                                      If Emoji is null, Show Nothing, 
                                      If not Null, Show the Emoji.

                                      And if the More Button is pressed the bottom sheet opens up which has features like,
                                      
                                      #Download the Cards
                                      # Share it
                                      # Or Delete the Card.
                                      
                                      */
                                      ButtonBar(
                                        alignment: MainAxisAlignment.end,
                                        children: [
                                          (todo.todoReminder) ==
                                                  null // if the reminder is null, show nothing, if it has reminder, show the timings of it, i.e the reminder
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
                                                      '${todo.todoReminder.toString()}'),
                                                ),
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
                                                  'sounds/navigation_forward-selection-minimal.wav',
                                                  stayAwake: false,
                                                ); // plays the tap sound
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
                                                        // Share Button
                                                        MaterialButton(
                                                          onPressed: () {
                                                            player.play(
                                                              'sounds/navigation_forward-selection-minimal.wav',
                                                              stayAwake: false,
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                            if (todo.todoEmoji ==
                                                                    "null" &&
                                                                todo.todoReminder ==
                                                                    null) {
                                                              //if Emoji and reminder is not set by the use then we use this template for sharing.
                                                              Share.share(
                                                                  "${todo.todoName} \n \n @toodoleeApp",
                                                                  subject:
                                                                      "Today's Toodo");
                                                            } else if (todo
                                                                    .todoReminder ==
                                                                null) {
                                                              // if the Reminder is not provided by user then, use this template for sharing it

                                                              Share.share(
                                                                  "${todo.todoName} \n ${todo.todoEmoji}  \n \n @toodoleeApp",
                                                                  subject:
                                                                      "Today's Toodo");
                                                            } else if (todo
                                                                    .todoEmoji ==
                                                                "null") {
                                                              // if the Emoji is not provided by user then, use this template for sharing it

                                                              Share.share(
                                                                  "${todo.todoReminder}⏰ \n \n @toodoleeApp",
                                                                  subject:
                                                                      "Today's Toodo");
                                                            } else {
                                                              // Everything is provided then, we use this as the template
                                                              Share.share(
                                                                  "${todo.todoName} ${todo.todoEmoji} \n at ${todo.todoReminder} \n \n @toodoleeApp",
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
                                                          // Download the Card
                                                          onPressed: () async {
                                                            await DavinciCapture
                                                                .click(
                                                              imgkey, //key (remember that global key)
                                                              saveToDevice:
                                                                  true,
                                                              fileName:
                                                                  "${DateTime.now().microsecondsSinceEpoch}", // Generated the different and unique name for the image.
                                                              openFilePreview:
                                                                  true,
                                                              albumName:
                                                                  "Toodolees",
                                                              pixelRatio: 2,
                                                            );
                                                            // If the Downloading Takes place,
                                                            //Show the User feedback that what they were doing is done.
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
                                                                          ],
                                                                        )));
                                                          },

                                                          child: ListTile(
                                                            leading: Icon(
                                                                CarbonIcons
                                                                    .download),
                                                            title: Text(
                                                                "Download"),
                                                          ),
                                                        ),
                                                        Divider(),
                                                        /*------------------------------------------------------------------------------------------------*/
                                                        MaterialButton(
                                                          // Delete the Toodo Card
                                                          onPressed: () async {
                                                            // if the reminder is not null then cancel the notification
                                                            //how the Cancellation works?
                                                            //check by cliciking on cancelReminderNotifications() with ctrl + click, there is whole documentation there.
                                                            if (completedTodoReminder !=
                                                                null) {
                                                              cancelReminderNotifications(
                                                                  completedTodoReminder,
                                                                  context);
                                                            }
                                                            //delete it from Index
                                                            await box.deleteAt(
                                                                index);
                                                            /*
                                                            When the Tooodo is deleted,
                                                            so it will increase the count of totalTodoCount, 
                                                            because the total count is initially 10, 
                                                            if you pour it will power efficient things to do, then it will go -1 (less).
                                                            hence, lets say, it comes to 6, by decrementing -1, 
                                                            now If the Toodo is deleted, 
                                                            we will Increase the totalTodoCount as the thing which was added is now deleted (equation cancelled),
                                                            So thats why decrementing count is also beneficial as the incrementing count, 
                                                            otherwise the tooodolee count or  Remaining count will only decrease not increase. 
                                                            */
                                                            incrementCount();

                                                            player.play(
                                                              'sounds/navigation_transition-left.wav',
                                                              stayAwake: false,
                                                            ); // deleting sound effect, plays swooooosh (deleting) sound

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

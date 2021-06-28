import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/Notification/NotificationsCancelAndRestart.dart';
import 'package:toodo/main.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:toodo/models/completed_todo_model.dart';
import 'package:share/share.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:toodo/uis/quotes.dart';
import 'listui.dart';

bool fabScrollingVisibility = true;
// floating action button just goes hide, if the count of all (combined or alone) will become 10,
// So for that time.
// Currently the visibility will be true, hence now is true, when the count exceeds 9 and goes to 10 then the visibility of floating action button will be false
//because At beginning the floating action button should not disappear otherwise,
// You will not be able to add toodolees.dart
// This is the best part, #Really Limited.

/*
When the Toodo is Completed it jumps to the CompletedTodoCard.
# Whole different UI
# Helps Distinguish between completed Toodolees and Incompleted Ones
# Share the Completed Ones
# Delete etc.

*/

class CompletedTodoCard extends StatefulWidget {
  const CompletedTodoCard({
    Key key,
  }) : super(key: key);

  @override
  _CompletedTodoCardState createState() => _CompletedTodoCardState();
}

class _CompletedTodoCardState extends State<CompletedTodoCard> {
  @override
  Widget build(BuildContext context) {
/*
completedTodoBox is the listenable, so whenever the changes will be done in this box (hive), 
The UI will change itself, and reload itself.
 */
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<CompletedTodoModel>(completedtodoBoxname).listenable(),
        // ignore: missing_return
        builder: (context, Box<CompletedTodoModel> cbox, _) {
          // calling the completedTodoBox with "cbox" as a name

          List<int> ckeys = cbox.keys.cast<int>().toList() ??
              []; // casting the cbox, aligning it's keys to list.
          if (completedBox.isEmpty == true && todoBox.isEmpty == false) {
            // when the todoBox is not empty and completed Box is empty, then.
            // just returning "Completing is the new full" in a very big designed way
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
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                ),
              ),
            ]);
          } else if (completedBox.length == completedBox.length) {
            // I don't know How it works, but it works,  :hehe
            return SingleChildScrollView(
                //Scrool View (Activated)
                physics: ScrollPhysics(),
                child: ListView.separated(
                    // ListView is added, the length of it is the length of completedTodoBox
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cbox.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, index) => Container(),
                    itemBuilder: (_, index) {
                      final int ckey = ckeys[index]; //getting the index.
                      final CompletedTodoModel comptodo =
                          cbox.get(ckey); // get that key from that index.

                      //Main Face/ UI that seems.
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
                                      fontFamily: "WorkSans",
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                leading: IconButton(
                                  /*
                                   
                                  #Sounds will be played
                                  # It will restart the notifications. (which was cancelled when the tooodoolee was completed)
                                  # Uncheck the circular/radio/leading button, this will cause the following to go to the Incompleted Todo
                                  # As it is adding in the incompletedTodo or WorkingOn then this will also remove the same element from the ship, So the todo will not build-up multiple times in one place.
                                  
                                   */
                                  onPressed: () {
                                    player.play(
                                      'sounds/notification_simple-01.wav',
                                      stayAwake: false,
                                    );

                                    if (comptodo.isCompleted == true) {
                                      if (comptodo.completedTodoReminder !=
                                          null) {
                                        /* 
                                            We are restarting the notification*/
                                        restartReminderNotifications(
                                            comptodo.completedTodoName,
                                            comptodo.completedTodoReminder,
                                            context);
                                      }

                                      /*
                                      We are adding the Following inside the TodoModel because,
                                       this is what refers to the Working On page or Which holds something like Incompleted Todo .

                                       Then the Model helps add the Tooooodo inside the todoBox.
                                       Then we delete the particular completedTodoBox element from the ListView.separated
                                      
                                       */
                                      TodoModel incompletedTodo = TodoModel(
                                        todoName: comptodo.completedTodoName,
                                        todoEmoji: comptodo.completedTodoEmoji,
                                        todoReminder:
                                            comptodo.completedTodoReminder,
                                        isCompleted: comptodo.isCompleted =
                                            false,
                                      );
                                      completedBox.deleteAt(index);
                                      todoBox.add(incompletedTodo);
                                    }
                                  },
                                  // the icon will be checkmarked so to distinguish it between the working ON lists and completed One Lists.
                                  icon: Icon(CarbonIcons.checkmark_filled,
                                      color: Colors.blue),
                                ),

                                //This is the more button, :more
                                //This will help to unloack more options (as really expected)
                                // .. Like deleting the CompletedTodo from it's position.
                                // .. Like Sharing the Text with Favourite People.
                                trailing: IconButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    // When the Icon is Pressed, the Bottom sheet will Appear.
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
                                        return Wrap(
                                          children: [
                                            // Share Button,
                                            // This will share the Small Little text to the audience or family.
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
                                            /*------------------------------------------------------------------------------------------------*/

                                            // This will delete the completedTodo from it's index.
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

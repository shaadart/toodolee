import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/main.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:share/share.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:dart_random_choice/dart_random_choice.dart';

Box<TodoModel> box;
Box<TodoModel> dbox;

class TodoCard extends StatefulWidget {
  const TodoCard({
    Key key,
  }) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  TodoModel get indexT => null;

  //bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<TodoModel>(todoBoxname).listenable(),
        builder: (context, Box<TodoModel> box, _) {
          List<int> keys = box.keys.cast<int>().toList();

          Map<String, String> imageLists = {
            'assets/bitmojis/battery full.png': "Energy, aaaaaaaa.. Me = Bolt",
            'assets/bitmojis/busy.png': "Get Things done, Nowww...",
            'assets/bitmojis/cat.png':
                "We Belive in Work, goodness comes automatically, do we?",
            'assets/bitmojis/check.png': "Writing it first then check it",
            'assets/bitmojis/coffee.png':
                "Die hard fan of Coffee, but work is priority",
            'assets/bitmojis/dog.png':
                "I turn Dreams to Real, after undertanding, i have to work for it",
            'assets/bitmojis/good.png': "good.. now lift goods..",
            'assets/bitmojis/guitar.png':
                "Energy-ised! Now to break all the odds..",
            'assets/bitmojis/hey 2.png':
                "Hey, How's all going.. I am Sure in the presence of you, nothing go wrong",
            'assets/bitmojis/hey bro.png':
                "Hey Beauty, do You know you work is more beautiful?",
            'assets/bitmojis/hey hi.png':
                "Welcome to the realest world... #Worldofwork",
            'assets/bitmojis/hi 2.png': "Toooooodooooo, hiiiiiiiiiiiis",
            'assets/bitmojis/hi 3.png':
                "if you think, your work is sweeter than any stuff, you are a bolt...",
            'assets/bitmojis/hi 4.png': "Can't Mail you, So i mailed myself..",
            'assets/bitmojis/hi 5.png':
                "hiHiHi... Welcome to the Toodooooolee Squad, BTW.. I know you got Work.. ",
            'assets/bitmojis/hi 6.png':
                "I am going to work on this chicken, you can also join me...",
            'assets/bitmojis/hi 7.png':
                "hewwwwww.. to the 'work'-'shipper', - Who ships work, to its Destrination",
            'assets/bitmojis/hi 8.png':
                "Going to space... to see what stars you will make",
            'assets/bitmojis/ji 9.png':
                "Hey.. hey.. hey.. Today is Blessed to see you.. yes 'today'.",
          };
          var r = imageLists[randomChoice(imageLists.keys)];

          if (todoBox.isEmpty == true) {
            return Column(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.3), BlendMode.colorDodge),
                  child: Container(
                    // width: MediaQuery.of(context).size.width / 1.1,
                    child: Center(
                      child: Image.asset(
                        r[keys],
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                        "r[value]",
                        style: TextStyle(color: Colors.black26, fontSize: 15),
                      ),
                    )),
              ],
            );
          } else if (todoBox.length == todoBox.length) {
            return SingleChildScrollView(
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
                      //todo.isCompleted = false;
                      return Card(
                        color: Colors.white,
                        elevation: 0.7,
                        child: Wrap(
                          children: [
                            ListTile(
                              onLongPress: () {
                                print("object");
                              },
                              leading: IconButton(
                                onPressed: () {
                                  setState(() {
                                    todo.isCompleted = !todo.isCompleted;
                                    if (todo.isCompleted == true) {
                                      TodoModel completedTodo = TodoModel(
                                        todoName: todo.todoName,
                                        todoEmoji: todo.todoEmoji,
                                        todoRemainder: todo.todoRemainder,
                                        isCompleted: todo.isCompleted = true,
                                      );
                                      todoBox.put(key, completedTodo);
                                    } else {
                                      TodoModel incompletedTodo = TodoModel(
                                        todoName: todo.todoName,
                                        todoEmoji: todo.todoEmoji,
                                        todoRemainder: todo.todoRemainder,
                                        isCompleted: todo.isCompleted = false,
                                      );
                                      todoBox.put(key, incompletedTodo);
                                    }
                                  });
                                  // setState(() {
                                  //   todo.isCompleted = !todo.isCompleted;

                                  // });
                                },

                                //   child: ListTile(
                                //       trailing: Text("${completedTodo.todoEmoji}"),
                                //       title: Text("${completedTodo.todoName}"),
                                //       subtitle: Text("${completedTodo.todoRemainder}")),
                                // ););

                                icon: todo.isCompleted == false
                                    ? Icon(CarbonIcons.radio_button,
                                        color: Colors.blue)
                                    : Icon(CarbonIcons.checkmark_filled,
                                        color: Colors.blue),
                                color: Colors.blue,
                              ),

                              title: Text(
                                '${todo.todoName}',
                                style: TextStyle(
                                    fontFamily: "WorkSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                    decoration: todo.isCompleted == true
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: Colors.black54),
                              ),
                              // subtitle: Text("written on morning"),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(66.0, 0, 30, 0),
                            //   // child: Text(
                            //   //   'Greyhound d ',
                            //   //   style:
                            //   //       TextStyle(color: Colors.black.withOpacity(0.6)),
                            //   // ),
                            // ),
                            ButtonBar(
                              children: [
                                (todo.todoRemainder) == null
                                    ? Container()
                                    : Text('${todo.todoRemainder.toString()}'),
                                (todo.todoRemainder) == null
                                    ? Container()
                                    : Text(
                                        "•",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54),
                                      ),
                                (todo.todoEmoji) == "null"
                                    ? Container()
                                    : Text('${todo.todoEmoji}',
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
                                                    """Hey 👋, Todays Todo: 
                                                  ${todo.todoName} ${todo.todoEmoji}
                                                  on  ${todo.todoRemainder}⏰
                                                  
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
                                                await box.deleteAt(index);
                                                setState(() {
                                                  dataToChange += 1;
                                                });
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

//     return Card(
//       color: Colors.white,
//       child: Wrap(
//         children: [
//           ListTile(
//             leading:
//                 IconButton(icon: Icon(CarbonIcons.checkbox), onPressed: () {}),
//             title: Text("Ride the Cycle, wooo!"),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(66.0, 0, 30, 0),
//             child: Text(
//               'Greyhound divisively hello coldly wonderfully marginally far upon excluding. Greyhound divisively hello coldly wonderfully marginally far upon excluding, ',
//               style: TextStyle(color: Colors.black.withOpacity(0.6)),
//             ),
//           ),
//           ButtonBar(
//             children: [
//               Text("4 am"),
//               Text(
//                 "•",
//                 style: TextStyle(fontSize: 20),
//               ),
//               Text(
//                 "😃",
//                 style: TextStyle(fontSize: 20),
//               ),
//               IconButton(
//                 onPressed: () {
//                   listMoreOptions(context);
//                 },
//                 icon: Icon(CarbonIcons.overflow_menu_vertical),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
  }
}

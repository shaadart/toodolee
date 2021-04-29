import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart'; //It is an Icons Library
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/pages/more.dart';
import 'package:share/share.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:toodo/uis/completedListUi.dart';
import 'package:toodo/uis/listui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

//import 'package:camera/camera.dart';
//import 'package:process/process.dart';
import 'package:hive_flutter/hive_flutter.dart';

//Home Page
//Settings

//Todo
//Bottom-Sheet
const String todoBoxname = "todo";

TimeOfDay time;
TimeOfDay picked;

final TextEditingController descriptionController = TextEditingController();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>(todoBoxname);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TodoApp(),
        title: 'To Do App',
        theme: ThemeData(
          fontFamily: "WorkSans",
        ));
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // int index;
  // int indexT;
  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<TodoModel>(todoBoxname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(
                CarbonIcons.menu,
                color: Colors.blue,
              ),
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MorePage()));
              })
        ],
        elevation: 0,
        title: Text("Toodolee 💙",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.blue,
            )),
        backgroundColor: Colors.white24,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showEmojiKeyboard ? emojiSelect() : Container(),
          addTodoBottomSheet(context);
          print("Add it");
        },
        child: Icon(CarbonIcons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        children: [
          Divider(indent: 60, thickness: 0.5),
          TodoCard(),
          //CompletedTodoUI(),
        ],
      ),
    );
  }
}

// class CompletedTodoUI extends StatefulWidget {
//   const CompletedTodoUI({
//     Key key,
//   }) : super(key: key);

//   @override
//   _CompletedTodoUIState createState() => _CompletedTodoUIState();
// }

// class _CompletedTodoUIState extends State<CompletedTodoUI> {
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: Hive.box<TodoModel>(todoBoxname).listenable(),
//         builder: (context, Box<TodoModel> box, _) {
//     List<int> keys = box.keys.cast<int>().toList();

//     if (todoBox.isEmpty == true) {
//       return Align(
//           alignment: Alignment.center,
//           child: Text(
//             'No Data Available',
//             style: TextStyle(color: Colors.black26),
//           ));
//     } else if (todoBox.length == todoBox.length) {
//       return SingleChildScrollView(
//           physics: ScrollPhysics(),
//           child: ListView.separated(
//               physics: NeverScrollableScrollPhysics(),
//               //itemCount: box.length,// editing a bit
//               itemCount: box.length,
//               shrinkWrap: true,
//               separatorBuilder: (_, index) => Container(),
//               itemBuilder: (_, index) {
//                 final int key = keys[index];
//                 final TodoModel todo = box.get(key);
//                 //todo.isCompleted = false;
//                 return Card(
//                   color: Colors.white,
//                   elevation: 0.7,
//                   child: Wrap(
//                     children: [
//                       ListTile(
//                         onLongPress: () {
//                           print("object");
//                         },
//                         leading: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               todo.isCompleted = !todo.isCompleted;

//                               //dbox.add(modifiedtodo);

//                               // box.deleteAt(index);
//                             });

//                             // if (todo.isCompleted == true) {
//                             //   await playLocalAsset();
//                             // }
//                           },
//                           icon: todo.isCompleted == false
//                               ? Icon(CarbonIcons.radio_button,
//                                   color: Colors.blue)
//                               : Icon(CarbonIcons.checkmark_filled,
//                                   color: Colors.blue),
//                           color: Colors.blue,
//                         ),

//                         title: Text(
//                           '${todo.todoName}',
//                           style: TextStyle(
//                               fontFamily: "WorkSans",
//                               fontStyle: FontStyle.normal,
//                               fontSize: 20,
//                               decoration: todo.isCompleted == true
//                                   ? TextDecoration.lineThrough
//                                   : null,
//                               color: Colors.black54),
//                         ),
//                         // subtitle: Text("written on morning"),
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.fromLTRB(66.0, 0, 30, 0),
//                       //   // child: Text(
//                       //   //   'Greyhound d ',
//                       //   //   style:
//                       //   //       TextStyle(color: Colors.black.withOpacity(0.6)),
//                       //   // ),
//                       // ),
//                       ButtonBar(
//                         children: [
//                           (todo.todoRemainder) == null
//                               ? Container()
//                               : Text('${todo.todoRemainder.toString()}'),
//                           (todo.todoRemainder) == null
//                               ? Container()
//                               : Text(
//                                   "•",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black54),
//                                 ),
//                           (todo.todoEmoji) == "null"
//                               ? Container()
//                               : Text('${todo.todoEmoji}',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                   )),
//                           IconButton(
//                             color: Colors.blue,
//                             onPressed: () {
//                               showModalBottomSheet(
//                                 context: context,
//                                 isScrollControlled: false,
//                                 shape: RoundedRectangleBorder(
//                                   // <-- for border radius
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10.0),
//                                     topRight: Radius.circular(10.0),
//                                   ),
//                                 ),
//                                 builder: (context) {
//                                   // Using Wrap makes the bottom sheet height the height of the content.
//                                   // Otherwise, the height will be half the height of the screen.
//                                   return Wrap(
//                                     children: [
//                                       FlatButton(
//                                         onPressed: () {},
//                                         child: ListTile(
//                                           leading: Icon(CarbonIcons.edit),
//                                           title: Text("Edit"),
//                                         ),
//                                       ),
//                                       FlatButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);

//                                           Share.share(
//                                               """Hey 👋, Todays Todo:
//                                             ${todo.todoName} ${todo.todoEmoji}
//                                             on  ${todo.todoRemainder}⏰

//                                             Share your Todoos from(playstore Link) I am really Excited
//                                             🎉🎉🎉""",
//                                               subject: "Today's Toodo");
//                                         },
//                                         child: ListTile(
//                                           leading:
//                                               Icon(CarbonIcons.share),
//                                           title: Text("Share"),
//                                         ),
//                                       ),
//                                       FlatButton(
//                                         onPressed: () {},
//                                         child: ListTile(
//                                           leading:
//                                               Icon(CarbonIcons.download),
//                                           title: Text("Download"),
//                                         ),
//                                       ),
//                                       Divider(),
//                                       FlatButton(
//                                         onPressed: () async {
//                                           totalTodoItem += 1;
//                                           await box.deleteAt(index);
//                                           Navigator.pop(context);
//                                         },
//                                         child: ListTile(
//                                           leading: Icon(
//                                               CarbonIcons.delete,
//                                               color: Colors.redAccent),
//                                           title: Text(
//                                             "Delete",
//                                             style: TextStyle(
//                                                 color: Colors.redAccent),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                             icon: Icon(
//                                 CarbonIcons.overflow_menu_horizontal),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               }));
//     }
//         });
//   }
// }

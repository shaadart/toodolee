import 'dart:ui';

import 'package:easy_gradient_text/easy_gradient_text.dart';
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
// int totalTodoCount = 2;
// int remainingTodosCount = totalTodoCount - todoBox.length;
TimeOfDay time;
TimeOfDay picked;

// final TextEditingController descriptionController = TextEditingController();
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

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

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<TodoModel>(todoBoxname);
    setState(() {});
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
        title: GradientText(
            text: "Toodolee 💙",
            colors: <Color>[Colors.blue.shade600, Colors.blue[100]],
            style: TextStyle(
              fontWeight: FontWeight.w700,
              // color: Colors.blue,
            )),
        backgroundColor: Colors.white24,
      ),
      floatingActionButton: Visibility(
        visible: (dataToChange == 0) ? false : true,
        child: FloatingActionButton(
          onPressed: () {
            // showEmojiKeyboard ? emojiSelect() : Container(),
            addTodoBottomSheet(context);
            print("Add it");
          },
          child: Icon(CarbonIcons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        children: [
          Divider(
            indent: 85,
            thickness: 0.9,
          ),
          TodoCard(),
          // Align(
          //     alignment: Alignment.center,
          //     child: Text(
          //       "You can Add ${dataToChange} Todolees more",
          //       style: TextStyle(
          //           fontStyle: FontStyle.normal, color: Colors.black26),
          //     )),

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
//           List<int> keys = box.keys.cast<int>().toList();

//           if (todoBox.isEmpty == true) {
//             return Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   'No Data Available',
//                   style: TextStyle(color: Colors.black26),
//                 ));
//           } else if (todoBox.length == todoBox.length) {
//             return SingleChildScrollView(
//                 physics: ScrollPhysics(),
//                 child: ListView.separated(
//                     physics: NeverScrollableScrollPhysics(),
//                     //itemCount: box.length,// editing a bit
//                     itemCount: box.length,
//                     shrinkWrap: true,
//                     separatorBuilder: (_, index) => Container(),
//                     itemBuilder: (_, index) {
//                       final int key = keys[index];
//                       final TodoModel completedTodo = box.get(key);

//                       //todo.isCompleted = false;
//                       return Card(
//                         child: ListTile(
//                             trailing: Text("${completedTodo.todoEmoji}"),
//                             title: Text("${completedTodo.todoName}"),
//                             subtitle: Text("${completedTodo.todoRemainder}")),
//                       );
//                     }));
//           }
//         });
//   }
// }

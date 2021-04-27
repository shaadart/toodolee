import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart'; //It is an Icons Library
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/pages/more.dart';
import 'package:share/share.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:toodo/uis/listui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:camera/camera.dart';
//import 'package:process/process.dart';
//import 'package:hive_flutter/hive_flutter.dart';

//Home Page
//Settings

//Todo
//Bottom-Sheet
const String todoBoxname = "todo";
TimeOfDay time;
TimeOfDay picked;
final TextEditingController titleController = TextEditingController();
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
        theme:
            ThemeData(fontFamily: "WorkSans", backgroundColor: Colors.yellow));
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
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
        elevation: 3,
        title: Text("Todo App 💙",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.blue,
            )),
        backgroundColor: Colors.white,
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
          TodoCard(),
        ],
      ),
    );
  }
}

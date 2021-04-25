import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart'; //It is an Icons Library
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/pages/more.dart';

import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:toodo/uis/listui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
//import 'package:hive_flutter/hive_flutter.dart';

//Home Page
//Settings

//Todo
//Bottom-Sheet
const String todoBoxname = "todo";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
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
        theme: ThemeData(fontFamily: "WorkSans"));
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Box<TodoModel> todoBox;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    
    super.initState();
    todoBox = Hive.box<TodoModel>(todoBoxname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                CarbonIcons.menu,
                color: Colors.black87,
              ),
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MorePage()));
              })
        ],
        elevation: 5,
        title: Text("Todo App",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            )),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoBottomSheet(context);
          print("Add it");
        },
        child: Icon(CarbonIcons.add),
      ),
      body: TodoCard(),
    );
  }
}

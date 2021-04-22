import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart'; //It is an Icons Library
import 'package:toodo/uis/addTodoBottomSheet.dart';

//Home Page
//Settings

//Todo
//Bottom-Sheet

void main() {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}

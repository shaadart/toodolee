//import 'dart:ui';

import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart'; //It is an Icons Library
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:toodo/models/todo_model.dart';
//import 'package:toodo/models/todo_model.dart';
import 'package:toodo/models/weather_model.dart';
import 'package:toodo/pages/more.dart';
//import 'package:share/share.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
//import 'package:toodo/uis/completedListUi.dart';
import 'package:toodo/uis/listui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
//import 'package:camera/camera.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:process/process.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'models/todo_model.dart';

//Home Page
//Settings

//Todo
//Bottom-Sheet
const String todoBoxname = "todo";
const String weatherBoxname = "weather";
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
  //Registering Adapters
  Hive.registerAdapter(TodoModelAdapter());
  Hive.registerAdapter(WeatherModelAdapter());
  //Opening Boxes
  await Hive.openBox<WeatherModel>(weatherBoxname);
  await Hive.openBox<TodoModel>(todoBoxname);
//Run Main App
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(home: Splash());
          } else {
            // Loading is done, return the app:
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: TodoApp(),
                title: 'Toodolee',
                theme: ThemeData(
                  fontFamily: "WorkSans",
                ));
          }
        });
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
              duration: Duration(milliseconds: 1200),
              child: Center(
                  child: Icon(CarbonIcons.checkmark,
                      size: 90, color: Colors.black87)),
            ),
            FadeOut(
                duration: Duration(milliseconds: 1100),
                child: Center(child: Text("Made by Proco :love"))),
          ],
        ),
      ),
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  int _currentIndex = 0;
  // int index;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<TodoModel>(todoBoxname);
    weatherBox = Hive.box<WeatherModel>(weatherBoxname);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FadeOut(
      child: Scaffold(
        bottomNavigationBar: FadeInUp(
          delay: Duration(milliseconds: 500),
          duration: Duration(milliseconds: 2000),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            //backgroundColor: Colors.blue,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blue,
            //unselectedItemColor: Colors.white.withOpacity(.6),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            onTap: (value) {
              // Respond to item press.
              setState(() => _currentIndex = value);
            },
            items: [
              BottomNavigationBarItem(
                title: Text('Favorites'),
                icon: Icon(CarbonIcons.grid),
              ),
              BottomNavigationBarItem(
                title: Text('Toodolees'),
                icon: Icon(CarbonIcons.checkmark),
              ),
              BottomNavigationBarItem(
                title: Text('Settings'),
                icon: Icon(CarbonIcons.settings),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: false,
          actions: [
            SlideInDown(
              child: IconButton(
                  icon: Icon(
                    CarbonIcons.menu,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: MorePage(),
                            inheritTheme: true,
                            ctx: context));
                  }),
            )
          ],
          elevation: 0,
          title: FadeInDown(
            child: GradientText(
                text: "Toodolee 💙",
                colors: <Color>[Colors.blue.shade600, Colors.blue[100]],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  // color: Colors.blue,
                )),
            duration: Duration(milliseconds: 1000),
            delay: Duration(milliseconds: 500),
          ),
          backgroundColor: Colors.white24,
        ),
        floatingActionButton: Visibility(
          visible: (dataToChange == 0) ? false : true,
          child: FadeInDown(
            child: FloatingActionButton(
              onPressed: () {
                // showEmojiKeyboard ? emojiSelect() : Container(),
                addTodoBottomSheet(context);
                print("Add it");
              },
              child: Icon(CarbonIcons.add),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: ListView(
          children: [
            FadeInRightBig(
              child: Divider(
                indent: 85,
                thickness: 0.9,
              ),
            ),
            FadeInUp(
              child: TodoCard(),
              duration: Duration(milliseconds: 2000),
              //delay: Duration(milliseconds: 200),
            ),
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

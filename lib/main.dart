//import 'dart:ui';

import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart'; //It is an Icons Library
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/pages/weatherCard.dart';
import 'package:toodo/pages/weatherCard.dart';
import 'package:toodo/processes.dart';
import 'package:toodo/services/notifications.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toodo/uis/completedListUi.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:toodo/models/todo_model.dart';

import 'package:toodo/pages/more.dart';
//import 'package:share/share.dart';
import 'package:toodo/uis/listui.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
//import 'package:toodo/uis/completedListUi.dart';

import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
//import 'package:camera/camera.dart';

//import 'package:process/process.dart';

import 'package:animate_do/animate_do.dart';
import 'models/todo_model.dart';
import 'pages/weatherCard.dart';

//Home Page
//Settings

//Todo
//Bottom-Sheet

Box<CompletedTodoModel> completedBox;
int currentedIndex = 0;
const String todoBoxname = "todo";
const String weatherBoxname = "weather";
const String completedtodoBoxname = "completedtodo";
const String welcomeBoringCardname = "welcomeboringcard";
//var  = ValueNotifier<int>(2);

ValueNotifier<int> totalTodoCount =
    ValueNotifier(10 - (todoBox.length + completedBox.length));

//var remainingTodosCount = ValueNotifier(totalTodoCount - todoBox.length);

TimeOfDay time;

TimeOfDay picked;

// final TextEditingController descriptionController = TextEditingController();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);

  //Registering Adapters
  Hive.registerAdapter(TodoModelAdapter());
  Hive.registerAdapter(CompletedTodoModelAdapter());
  //Opening Boxes
  await Hive.openBox(weatherBoxname);
  await Hive.openBox<TodoModel>(todoBoxname);
  await Hive.openBox(welcomeBoringCardname);
  await Hive.openBox<CompletedTodoModel>(completedtodoBoxname);
  scheduleDeletingofLists();
  deletingWeatherData();
//Run Main App
  runApp(MyApp()); //dekhke he laglaa hai
}

class MyApp extends StatelessWidget {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final player = AudioCache();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 0)),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            player.play(
              'sounds/notification_ambient.wav',
              stayAwake: false,
              mode: PlayerMode.LOW_LATENCY,
            );

            return MaterialApp(home: Splash());
          } else {
//Ghost White: 0xffF6F8FF
//Lemon Glacier :0xffFBFB0E
//Rich Black: 0xff010C13
// Azure: 0xff4785FF

            // Loading is done, return the app:
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: DefaultedApp(),
                title: 'Toodolee',
                theme: ThemeData(
                  primaryColor: Color(0xffFBFB0E),
                  accentColor: Color(0xff1F69FF),
                  backgroundColor: Color(0xffF6F8FF),
                  //checkboxTheme: CheckboxThemeData(checkColor: Color(0xffF6F8FF), fillColor: Color(0xff3377FF)),
                  brightness: Brightness.light,
                  iconTheme: IconThemeData(color: Colors.black54),

                  fontFamily: "WorkSans",
                ));
          }
        });
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInUpBig(
              duration: Duration(milliseconds: 1200),
              child: Center(
                child: Image.asset(
                  "icon/toodoleeicon.png",
                  height: MediaQuery.of(context).size.width / 2,
                ),
              ),
            ),
            FadeInUpBig(
                //duration: Duration(milliseconds: 1000),
                duration: Duration(milliseconds: 1200),
                child: Center(
                    child: GradientText(
                  text: "Toodolee",
                  style: TextStyle(
                      fontFamily: "WorkSans",
                      fontSize: MediaQuery.of(context).size.width / 15,
                      fontWeight: FontWeight.w700),
                  colors: <Color>[
                    Colors.blue,
                    Colors.blue[200],
                    Colors.lightBlue
                  ],
                ))),
          ],
        ),
      ),
    );
  }
}

class DefaultedApp extends StatefulWidget {
  @override
  _DefaultedAppState createState() => _DefaultedAppState();
}

class _DefaultedAppState extends State<DefaultedApp> {
  final player = AudioCache();

  List<Widget> containers = [
    TodoApp(),
    MorePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    //Provider.of<NoticationService>(context, listen: false).initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: [
            SlideInDown(
              child: IconButton(
                  icon: Icon(
                    CarbonIcons.menu,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MorePage()),
                    );
                  }),
            ),
            SlideInDown(
              child: IconButton(
                  icon: Icon(
                    CarbonIcons.search,
                  ),
                  onPressed: () {
                    player.play(
                      'sounds/navigation_forward-selection-minimal.wav',
                      stayAwake: false,
                      mode: PlayerMode.LOW_LATENCY,
                    );
                  }
                  // showSearch(
                  //   context: context,
                  //   delegate: SearchPage<TodoModel>(
                  //     items:
                  //     searchLabel: 'Search people',
                  //     suggestion: Center(
                  //       child: Text('Filter people by name, surname or age'),
                  //     ),
                  //     failure: Center(
                  //       child: Text('No person found :('),
                  //     ),
                  //     filter: (person) => [
                  //       todoBox.todoName,
                  //       todoBox.todoRemainder.String(),

                  //     ],
                  //     builder: (person) => ListTile(
                  //       title: Text(person.name),
                  //       subtitle: Text(person.surname),
                  //       trailing: Text('${person.age} yo'),
                  //     ),
                  //   ),
                  // ),
                  ),
            ),
          ],
          elevation: 4,
          title: FadeInDown(
            duration: Duration(milliseconds: 1000),
            delay: Duration(milliseconds: 500),
            child: Text(
              "Toodolee",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                // color: Colors.blue,
              ),
            ),
          ),
          //backgroundColor: Colors.white,
          bottom: TabBar(tabs: [
            Tab(
                text: "Toodos",
                icon: Icon(
                  CarbonIcons.checkmark,
                  //  color: Colors.black,
                )),
            Tab(
                text: "Grids",
                icon: Icon(
                  CarbonIcons.grid,
                  //color: Colors.black,
                )),
          ]),
        ),
        body: TabBarView(children: containers),
      ),
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // int index;
  final player = AudioCache();

  @override
  void initState() {
    super.initState();
    completedBox = Hive.box<CompletedTodoModel>(completedtodoBoxname);
    todoBox = Hive.box<TodoModel>(todoBoxname);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: totalTodoCount,
        builder: (context, remainingTodoCount, _) {
          return FadeOut(
            child: Scaffold(
              floatingActionButton: Visibility(
                visible:
                    (remainingTodoCount <= 0 || fabScrollingVisibility == false)
                        ? false
                        : true,
                child: FadeInDown(
                  child: FloatingActionButton(
                    onPressed: () {
                      player.play(
                        'sounds/navigation_forward-selection-minimal.wav',
                        stayAwake: false,
                        mode: PlayerMode.LOW_LATENCY,
                      );
                      // showEmojiKeyboard ? emojiSelect() : Container(),
                      addTodoBottomSheet(context);

                      print("Add it");
                    },
                    child: Icon(CarbonIcons.add),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              body: ListView(
                children: [
                  // FadeInRightBig(
                  //   child: Divider(
                  //     indent: 85,
                  //     thickness: 0.9,
                  //   ),
                  // ),
                  FadeInUp(
                    child: TodoCard(),
                    duration: Duration(milliseconds: 2000),
                    //delay: Duration(milliseconds: 200),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 60),
                    child: FadeInUp(
                      duration: Duration(milliseconds: 2000),
                      child: Text(
                          todoBox.isEmpty == true
                              ? ""
                              : "You can add : ${remainingTodoCount} more ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 15,
                          )),
                    ),
                  ),
                  CompletedTodoCard(),
                  Container(
                    height: MediaQuery.of(context).size.width / 4,
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
        });
  }

  Future notificationSelected(String payload) async {}
}

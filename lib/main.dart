//import 'dart:ui';

import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:easy_gradient_text/easy_gradient_text.dart'; // Text To Gradients
import 'package:flutter/foundation.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart'; //It is an Icons Library
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; //Date - Time
import 'package:locally/locally.dart'; // Sends Push Notifications, Amazingly.
import 'package:search_page/search_page.dart';
import 'package:provider/provider.dart';

import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/pages/onboardingScreen.dart';
import 'package:toodo/pages/settingsPage/settingspagedefault.dart';
import 'package:toodo/pages/tommorownotification.dart';
import 'package:toodo/pages/weatherCard.dart';
import 'package:toodo/pages/weatherCard.dart';
import 'package:toodo/processes.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toodo/uis/completedListUi.dart';
import 'package:toodo/models/todo_model.dart';

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
import 'package:workmanager/workmanager.dart';

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
const String quotesCardname = "quotes";
const String dailyRemainderBoxName = "dailyremainder";
const String boringcardName = "boringcard";
//var  = ValueNotifier<int>(2);

ValueNotifier<int> totalTodoCount =
    ValueNotifier(10 - (todoBox.length + completedBox.length));

//var remainingTodosCount = ValueNotifier(totalTodoCount - todoBox.length);

TimeOfDay time;

TimeOfDay picked;

// final TextEditingController descriptionController = TextEditingController();
DateTime now = DateTime.now();

String formattedDate = DateFormat('kk:mm').format(now);

//14:13
String removeunwantedSymbolsfromCurrentTime =
    formattedDate.replaceAll(":", ""); //1413
int currentTime = int.parse(removeunwantedSymbolsfromCurrentTime);

int timeRemaining = 2400 - currentTime;

//

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  await Hive.openBox<CompletedTodoModel>(completedtodoBoxname);
  await Hive.openBox(welcomeBoringCardname);
  await Hive.openBox(quotesCardname);
  await Hive.openBox(dailyRemainderBoxName);
  await Hive.openBox(boringcardName);
  // callbackDispatcher();
  // deletingWeatherData();
  // deletingQuotesData();
//Run Main App
  runApp(MyApp()); //dekhke he laglaa hai
}

class MyApp extends StatelessWidget {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AudioCache player = AudioCache();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            player.play(
              'sounds/notification_ambient.wav',
              mode: PlayerMode.MEDIA_PLAYER,
              // stayAwake: false,
              //// mode: PlayerMode.LOW_LATENCY,
            );

            return MaterialApp(home: Splash());
          } else {
//Ghost White: 0xffF6F8FF
//Lemon Glacier :0xffFBFB0E
//Rich Black: 0xff010C13
// Azure: 0xff4785FF

            // Loading is done, return the app:
            // return MaterialApp(
            //     debugShowCheckedModeBanner: false,
            //     home: MyHomePage(),
            //     title: 'Toodolee',
            //     theme: ThemeData(
            //       primaryColor: Color(0xffFBFB0E),
            //       accentColor: Color(0xff1F69FF),
            //       backgroundColor: Color(0xffF6F8FF),
            //       //checkboxTheme: CheckboxThemeData(checkColor: Color(0xffF6F8FF), fillColor: Color(0xff3377FF)),
            //       brightness: Brightness.light,
            //       iconTheme: IconThemeData(color: Colors.black54),

            //       fontFamily: "WorkSans",
            //     ));
            return AdaptiveTheme(
              light: ThemeData(
                  fontFamily: "WorkSans",
                  brightness: Brightness.light,
                  primaryColor: Color(0xffFBFB0E),
                  accentColor: Color(0xff4785FF),
                  backgroundColor: Color(0xffF6F8FF)

                  //textTheme: TextTheme(
                  //   headline4: TextStyle(color: Colors.black87),
                  //   subtitle: TextStyle(color: Colors.black54, fontSize: 15),
                  //   //subtitle2: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
              dark: ThemeData(
                fontFamily: "WorkSans",
                brightness: Brightness.dark,
                primaryColor: Color(0xff4785FF),
                accentColor: Color(0xffFBFB0E),
                // textTheme: TextTheme(
                //     headline1: TextStyle(
                //         fontSize: 72.0, fontWeight: FontWeight.bold),
                //     headline6: TextStyle(
                //         fontSize: 36.0, fontStyle: FontStyle.italic),
                //     bodyText2: TextStyle(fontSize: 14.0,),
                //     headline4: TextStyle(color: Colors.black87),
                //     subtitle:
                //         TextStyle(color: Colors.white54, fontSize: 15))
              ),
              initial: AdaptiveThemeMode.light,
              builder: (theme, darkTheme) => MaterialApp(
                title: 'Toodolee',
                theme: theme,
                darkTheme: darkTheme,
                home: DefaultedApp(),
              ),
            );
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
  //Name, Reminader Emoji
  // var keys = todoBox.keys.toList();

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
                      MaterialPageRoute(builder: (context) => SettingPage()),
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
                      // mode: PlayerMode.LOW_LATENCY,
                    );
                    // showSearch(
                    //   context: context,
                    //   delegate: SearchPage<TodoModel>(
                    //     onQueryUpdate: (s) => print(s),
                    //     items: keys,
                    //     searchLabel: 'Search Todos',
                    //     suggestion: Center(
                    //       child:
                    //           Text('Filter Todo by name, Remainder or Emoji'),
                    //     ),
                    //     failure: Center(
                    //       child: Text('No person found :('),
                    //     ),
                    //     filter: (keys) => [
                    //       keys.todoName,
                    //       keys.todoRemainder,
                    //       keys.todoEmoji.toString(),
                    //     ],
                    //     builder: (keys) => ListTile(
                    //       title: Text("${keys.todoName}"),
                    //       subtitle: Text("${keys.todoRemainder}"),
                    //       trailing: Text('${keys.todoEmoji.toString()} yo'),
                    //     ),
                    //   ),
                    //);
                  }),
            ),
          ],
          elevation: 4,
          title: SlideInDown(
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
                child: SlideInDown(
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        selectedEmoji == null;
                      });
                      player.play(
                        'sounds/navigation_forward-selection-minimal.wav',
                        stayAwake: false,
                        // mode: PlayerMode.LOW_LATENCY,
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
                  // SlideInRightBig(
                  //   child: Divider(
                  //     indent: 85,
                  //     thickness: 0.9,
                  //   ),
                  // ),

                  SlideInUp(
                    child: TodoCard(),
                    duration: Duration(milliseconds: 2000),
                    //delay: Duration(milliseconds: 200),
                  ),

                  CompletedTodoCard(),

                  FadeInUp(
                    //delay: Duration(milliseconds: 800),
                    duration: Duration(milliseconds: 2000),
                    child: (todoBox.length <= 0 || completedBox.length > 0)
                        ? Container(
                            height: MediaQuery.of(context).size.width / 4)
                        : Center(),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 60),
                    child: SlideInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Opacity(
                          opacity: 0.5,
                          child: Text(
                            todoBox.isEmpty == true
                                ? ""
                                : "You can add : ${remainingTodoCount} more ",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        )),
                    //TextStyle(
                    // color: Colors.black26,
                    //fontSize: 15,
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
}

setRemainderMethod(time, name, context) {
  if (remainderNotifications == true) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('kk:mm').format(now); // 10:43 => "10:43"

    String removeunwantedSymbolsfromRemainderTime =
        time.replaceAll(":", ""); //1413
    String removeunwantedSymbolsfromCurrentTime =
        formattedDate.replaceAll(":", ""); //1044
    int currentTime = int.parse(removeunwantedSymbolsfromCurrentTime);
    int remainderTime = int.parse(removeunwantedSymbolsfromRemainderTime);

    int timeRemaining = remainderTime - currentTime;
    //
    Locally locally = Locally(
      context: context,
      payload: 'test',

      //pageRoute: MaterialPageRoute(builder: (context) => MorePage(title: "Hey Test Notification", message: "You need to Work for allah...")),
      appIcon: 'toodoleeicon',

      pageRoute: MaterialPageRoute(builder: (BuildContext context) {
        return DefaultedApp();
      }),
    );

    locally.schedule(
        channelName: "Remainder Notifications",
        channelID: "RemainderNotifications",
        channelDescription: "Sends you Notifications of the remainders you set",
        title: '${name} ',
        message: "${name}, Remember to Work today",
        androidAllowWhileIdle: true,
        duration: Duration(minutes: timeRemaining));
  } else {
    print(
        "Settings of Remainder Notification is set to the $remainderNotifications");
  }
}

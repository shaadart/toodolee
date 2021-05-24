//import 'dart:ui';
//import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'dart:async';
import 'package:easy_gradient_text/easy_gradient_text.dart'; // Text To Gradients
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart'; //It is an Icons Library
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:intl/intl.dart';

import 'package:search_page/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/pages/adTest.dart';

import 'package:toodo/pages/settingsPage/settingspagedefault.dart';

import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:toodo/uis/completedListUi.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/pages/more.dart';
import 'package:toodo/uis/listui.dart';

import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:animate_do/animate_do.dart';
import 'package:workmanager/workmanager.dart';
import 'models/todo_model.dart';

//import 'pages/weatherCard.dart';

//Home Page
//Settings

//Todo
//Bottom-Sheet

int currentedIndex = 0;
const String todoBoxname = "todo";
const String weatherBoxname = "weather";
const String completedtodoBoxname = "completedtodo";
const String welcomeBoringCardname = "welcomeboringcard";
const String quotesCardname = "quotes";
const String dailyRemainderBoxName = "dailyremainder";
const String boringcardName = "boringcard";
const String settingsName = "settings";

//var  = ValueNotifier<int>(2);

ValueNotifier<int> totalTodoCount = ValueNotifier(10 -
    (todoBox.length +
        completedBox.length)); //limiting the toodolee count to 10.
const refreshQuote = "refreshQuote";

const task1 = "simpleTask";
final player = AudioCache(); //Plays Sounds
Box<CompletedTodoModel> completedBox; //For Box
Box settingsBox;
Box weatherBox;
Box quotesBox;
Box dailyRemainderBox;
String dailyRemainder = "6:30";

int minutesLeftTillTwelveAm() {
  DateTime now = DateTime.now();
  var twelveAmString = "24:00";
  var currentTimeString = DateFormat('kk:mm').format(now);

  String removeunwantedSymbolsfromtwelveAm =
      twelveAmString.replaceAll(":", "."); //24.00
  String removeunwantedSymbolsfromCurrentTime =
      currentTimeString.replaceAll(":", "."); //19.12

  double twelveAm = double.parse(removeunwantedSymbolsfromtwelveAm);
  double currentTime = double.parse(removeunwantedSymbolsfromCurrentTime);

  double remainingTime = twelveAm - currentTime;
  double rawSeconds = (remainingTime * 3600);
  int seconds = rawSeconds.toInt();
  print(seconds);
  return seconds; //
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager.initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  Workmanager.registerPeriodicTask("100", task1,
      frequency: Duration(hours: 24),
      initialDelay: Duration(seconds: minutesLeftTillTwelveAm()));

  Workmanager.registerPeriodicTask("200", refreshQuote,
      frequency: Duration(minutes: 15), initialDelay: Duration(seconds: 2));

  print("In Seconds: ${minutesLeftTillTwelveAm()} we will delete all toodoos");

  // Workmanager.registerOneOffTask("1", task1,
  //     initialDelay: Duration(seconds: 2));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors
        .transparent, //Making Status Bar (battery, time, notifications etc) to Transparent
  ));
  final document =
      await getApplicationDocumentsDirectory(); // Getting the Path of App Directory
  Hive.init(document.path); //Initialization of Hive in it.

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
  await Hive.openBox(settingsName);

  runApp(MyApp()); //dekhke he laglaa hai // Running the App
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Configure Splash Screeeen.
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            player.play(
              'sounds/notification_ambient.wav',
              mode: PlayerMode.MEDIA_PLAYER,
              // stayAwake: false,
              // mode: PlayerMode.LOW_LATENCY,
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
  void initState() {
    // setupWorkManager();
    super.initState();

    completedBox = Hive.box<CompletedTodoModel>(completedtodoBoxname);
    todoBox = Hive.box<TodoModel>(todoBoxname);
    settingsBox = Hive.box(settingsName);
    weatherBox = Hive.box(weatherBoxname);
    quotesBox = Hive.box(quotesCardname);
    dailyRemainderBox = Hive.box(dailyRemainderBoxName);
  }

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
            // FadeInUpBig(
            //     //duration: Duration(milliseconds: 1000),
            //     duration: Duration(milliseconds: 1200),
            //     child: Center(
            //         child: GradientText(
            //       text: "Toodolee",
            //       style: TextStyle(
            //           fontFamily: "WorkSans",
            //           fontSize: MediaQuery.of(context).size.width / 15,
            //           fontWeight: FontWeight.w700),
            //       colors: <Color>[
            //         Colors.blue,
            //         Colors.blue[200],
            //         Colors.lightBlue
            //       ],
            //     ))),
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
  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  //Color selectedColor = Colors.blue;
  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);

  // Color unselectedColor =
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
  ];

  List pages = [
    TodoApp(),
    MorePage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: totalTodoCount,
        builder: (context, remainingTodoCount, _) {
          return Scaffold(
            appBar: AppBar(title: Text("Toodolee")),
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: true,
            extendBody: true,
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
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            //body: AdTest(),
            body: pages[_selectedItemPosition],
            bottomNavigationBar: SnakeNavigationBar.color(
              //Ghost White: 0xffF6F8FF
//Lemon Glacier :0xffFBFB0E
//Rich Black: 0xff010C13
// Azure: 0xff4785FF

              backgroundColor: Theme.of(context).cardColor,
              behaviour: SnakeBarBehaviour.pinned,
              snakeShape: SnakeShape.circle,
              //shape: bottomBarShape,
              //padding: padding,
              elevation: 5.0,

              ///configuration for SnakeNavigationBar.color
              snakeViewColor: Theme.of(context).colorScheme.background,
              selectedItemColor: Theme.of(context).colorScheme.onSurface,
              unselectedItemColor: Theme.of(context).colorScheme.onSurface,

              ///configuration for SnakeNavigationBar.gradient
              //snakeViewGradient: selectedGradient,
              //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
              //unselectedItemGradient: unselectedGradient,

              showUnselectedLabels: showUnselectedLabels,
              showSelectedLabels: showSelectedLabels,

              items: [
                BottomNavigationBarItem(
                    icon: Opacity(opacity: 0.5, child: Icon(CarbonIcons.home)),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: Opacity(opacity: 0.5, child: Icon(CarbonIcons.grid)),
                    label: 'app'),
                BottomNavigationBarItem(
                    icon: Opacity(
                        opacity: 0.5, child: Icon(CarbonIcons.settings)),
                    label: 'settings')
              ],

              currentIndex: _selectedItemPosition,
              onTap: (index) {
                setState(() {
                  _selectedItemPosition = index;
                  player.play(
                    'sounds/navigation_forward-selection-minimal.wav',
                    mode: PlayerMode.MEDIA_PLAYER,
                    // stayAwake: false,
                    // mode: PlayerMode.LOW_LATENCY,
                  );
                });
              },
            ),
          );
        });
  }

  showSearchPage(BuildContext context) async => showSearch(
        context: context,
        delegate: SearchPage(
          items: todoBox.values.toList(),
          searchLabel: 'Search Todoo',
          suggestion: Center(
            child: Text('Filter runnig toodos by\n name, time or emoji'),
          ),
          failure: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'No Running todos found',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.shortestSide / 50),
                  child: Text("it is may be not written or is completed"),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.shortestSide / 30,
                      0,
                      MediaQuery.of(context).size.shortestSide / 30,
                      MediaQuery.of(context).size.shortestSide / 30),
                  child: ElevatedButton(
                      onPressed: () {
                        player.play(
                          'sounds/navigation_forward-selection.wav',
                          stayAwake: false,
                          // mode: PlayerMode.LOW_LATENCY,
                        );
                        Navigator.pop(context);
                        player.play(
                          'sounds/navigation_forward-selection.wav',
                          stayAwake: false,
                          // mode: PlayerMode.LOW_LATENCY,
                        );
                        addTodoBottomSheet(context);
                      },
                      child: Text("Tap to Write it")),
                )
              ],
            ),
          ),
          filter: (todoBox) => [
            todoBox.todoName,
            todoBox.todoRemainder,
            todoBox.todoEmoji.toString(),
          ],
          builder: (todoBox) => FlatButton(
            onPressed: () async {
              player.play(
                'sounds/navigation_forward-selection.wav',
                stayAwake: false,
                // mode: PlayerMode.LOW_LATENCY,
              );
              await Navigator.pop(context);
              player.play(
                'sounds/navigation_forward-selection.wav',
                stayAwake: false,
                // mode: PlayerMode.LOW_LATENCY,
              );
              // mode: PlayerMode.LOW_LATENCY,
            },
            child: ListTile(
              title: Text(todoBox.todoName),
              subtitle: Text("yes it's there, tap to work"),
              leading: todoBox.todoEmoji == "null"
                  ? Icon(CarbonIcons.thumbs_up)
                  : Text('${todoBox.todoEmoji}'),
              trailing: todoBox.todoRemainder == null
                  ? Text("")
                  : Text('${todoBox.todoRemainder}'),
            ),
          ),
        ),
      );
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: totalTodoCount,
        builder: (context, remainingTodoCount, _) {
          return FadeOut(
            child: Scaffold(
              body: ListView(
                children: [
                  // TODO: Display a banner when ready

                  SlideInUp(
                    child: TodoCard(),
                    duration: Duration(milliseconds: 2000),
                    //delay: Duration(milliseconds: 200),
                  ),

                  // ),
                  SlideInUp(
                    child: CompletedTodoCard(),
                    duration: Duration(milliseconds: 2000),
                    //delay: Duration(milliseconds: 2000),
                  ),

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
                        EdgeInsets.all(MediaQuery.of(context).size.width / 80),
                    child: Opacity(
                      opacity: 0.5,
                      child: SlideInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Text(
                          todoBox.isEmpty == true
                              ? ""
                              : "You can add : ${remainingTodoCount} more ",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                    ),

                    // Align(
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //       "You can Add ${dataToChange} Todolees more",
                    //       style: TextStyle(
                    //           fontStyle: FontStyle.normal, color: Colors.black26),
                    //     )),

                    //CompletedTodoUI(),
                  )
                ],
              ),
            ),
          );
        });
  }
}

setRemainderMethod(time, String name, int id, context) {
  List splittingtheTime = time.split(":");
  int hour = int.parse(splittingtheTime.first);
  print(hour);

  int minute = int.parse(splittingtheTime.last);
  print(minute);
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/toodoleeicon',
      [
        NotificationChannel(
          // groupKey: "remainderNotf",
          channelKey: 'remainderNotific',
          channelName: 'Remainder_Notification',
          channelDescription:
              'Sends you notifications of the remainders you set',
          defaultColor: Color(0xff4785FF),
          ledColor: Colors.blue,
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          soundSource: "resource://raw/alert_simple",
        ),
      ]);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // Insert here your friendly dialog box before call the request method
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'remainderNotific',
          title: "$name ${todo.todoEmoji}",
          body: "work is life"),
      actionButtons: [
        NotificationActionButton(
          key: 'COMPLETED',
          label: 'Do it',
          autoCancel: true,
          buttonType: ActionButtonType.Default,
        ),
      ],
      schedule: NotificationCalendar(
        hour: hour,
        minute: minute,
        allowWhileIdle: true,
        timeZone: AwesomeNotifications.localTimeZoneIdentifier,
      ));
}

// void setupWorkManager() async {
//   await Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
//   Workmanager.registerPeriodicTask(taskKontrol, taskKontrol,
//       frequency: Duration(seconds: 10),
//       existingWorkPolicy: ExistingWorkPolicy.append);
// }

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    print("it's doing the task");
    switch (task) {
      case task1:
        todoBox.clear();
        completedBox.clear();
        print(
            "All Box will be Deleting as it is ${minutesLeftTillTwelveAm()}.30");

        break;

      case refreshQuote:

        //Code for Refreshing the Quote
        quotesBox.clear();
        print("Refreshing the Quote");

        break;
      case Workmanager.iOSBackgroundTask:
        print("iOS background fetch delegate ran");
        break;
    }
    return Future.value(true);
  });
}

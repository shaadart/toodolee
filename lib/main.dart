import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/processes.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart'; //It is an Icons Library
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:toodo/models/completed_todo_model.dart';
import 'package:toodo/models/Streak%20Model/streak_model.dart';
import 'package:toodo/pages/onboardingScreen.dart';
import 'package:toodo/uis/Toodolee Lists/WorkingOnPage.dart';
import 'package:toodo/uis/Toodolee Lists/completedListUi.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:toodo/pages/morePage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:animate_do/animate_do.dart';
import 'package:toodo/uis/whiteScreen.dart';
import 'models/todo_model.dart';
import 'pages/settingspage.dart';
import 'uis/Streak/streakPage.dart';
import 'uis/Toodolee Lists/CompletedPage.dart';

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
const String dailyReminderBoxName = "dailyreminder";
const String boringcardName = "boringcard";
const String settingsName = "settings";
const String currentBoxName = "currentDateBox";
const String onboardingScreenBoxName = "onboardingScreenBox";
const String streakBoxName = "streakBox";
const String completedStreakBoxName = "completeStreakBox";

ValueNotifier<int> totalTodoCount = ValueNotifier(
    10 - (todoBox.length + completedBox.length + streakBox.length));

final player = AudioCache(); //Plays Sounds
Box<CompletedTodoModel> completedBox; //For Box
Box settingsBox;
Box weatherBox;
Box quotesBox;
Box onboardingScreenBox;
Box dailyReminderBox;
Box boredBox;
Box currentDateBox;
Box<StreakModel> streakBox;
int initialselectedPage = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  Hive.registerAdapter(StreakModelAdapter());

  //Opening Boxes
  // await Hive.openBox(weatherBoxname);
  await Hive.openBox<TodoModel>(todoBoxname);
  await Hive.openBox<CompletedTodoModel>(completedtodoBoxname);
  await Hive.openBox<StreakModel>(streakBoxName);
  await Hive.openBox(welcomeBoringCardname);
  await Hive.openBox(quotesCardname);
  await Hive.openBox(dailyReminderBoxName);
  await Hive.openBox(boringcardName);
  await Hive.openBox(settingsName);
  await Hive.openBox(onboardingScreenBoxName);
  await Hive.openBox(currentBoxName);

  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    'resource://drawable/res_toodoleeicon',
    [
      NotificationChannel(
        // groupKey: "reminderNotf",

        channelKey: 'dailyNotific',
        channelName: 'Daily Notifications',
        channelDescription:
            'Sends you daily notifications to remind you to write toodolees, to win the day',
        onlyAlertOnce: true,
        defaultColor: Color(0xffFFCC00),
        ledColor: Color(0xffFFCC00),
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Public,
        playSound: true,
        soundSource: "resource://raw/res_alert_simple",
      ),
      NotificationChannel(
        // groupKey: "reminderNotf",
        channelKey: 'reminderNotific',
        channelName: 'Reminder Notifications',
        channelDescription:
            'Sends you notifications of the reminders you set, to win the time.',
        onlyAlertOnce: true,
        defaultColor: Color(0xff4785FF),
        ledColor: Colors.blue,
        importance: NotificationImportance.Max,
        defaultPrivacy: NotificationPrivacy.Public,
        playSound: true,
        soundSource: "resource://raw/res_alert_simple",
      ),
      NotificationChannel(
        // groupKey: "reminderNotf",
        channelKey: 'streakNotific',
        channelName: 'Streak Notifications',
        channelDescription:
            'Reminds you to check the streaks, so you never break them.',
        onlyAlertOnce: true,
        defaultColor: Color(0xff867AE9),
        ledColor: Color(0xff867AE9),
        importance: NotificationImportance.Max,
        defaultPrivacy: NotificationPrivacy.Public,
        playSound: true,
        soundSource: "resource://raw/res_alert_simple",
      ),
    ],
  );

  runApp(MyApp());
}

/* -------------------------------------- 
This is the Main Screen, This Just Checks,
And shows you the Default Screen. That Means, If the user is First to open the App, The App will show them theOnBoarding Screen. 
If the user is not using the App for the First, It will go with the Default App Running, 
*/

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: onboardingScreenBox.listenable(),
      builder: (context, onboard, child) =>
          onboard.get('shownOnBoard', defaultValue: false)
              ? DefaultedApp() // This is the Default App.
              : MyHomePage(), //This is the Onboarding Screen Page.
    );
  }
}

/* ---------------------------------------- 
This is the Splash Screen, This Just Shows the Toodolee Logo at the Starting of the App...
It Animates the Logo,
Plays the Sound,
And stays on the Screen for Bit Seconds.
*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Configure Splash Screeeen.
    return FutureBuilder(
        future: Future.delayed(Duration(
            seconds:
                3)), // how much time the splash screen should show, (for how much sec)
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            player.play(
              'sounds/notification_ambient.wav',
              mode: PlayerMode.MEDIA_PLAYER,
            );

            return MaterialApp(home: Splash(), title: 'Toodolee');
          } else {
//Ghost White: 0xffF6F8FF
//Lemon Glacier :0xffFBFB0E
//Rich Black: 0xff010C13
// Azure: 0xff4785FF

// Adaptive Theme helps to navigate to two modes,
//light or dark with their own custom theme Data set,
//just same like how we use in MaterialApp
            return AdaptiveTheme(
              light: ThemeData(
                // platform: TargetPlatform.iOS,
                fontFamily: "WorkSans",
                brightness: Brightness.light,
                primaryColor: Color(0xffFBFB0E),
                accentColor: Color(0xff0177fb),
                scaffoldBackgroundColor: Color(0xffffffff),
                cardColor: Color(0xfff3f8fb), //f3f8fb
              ),
              dark: ThemeData(
                // platform: TargetPlatform.iOS,
                fontFamily: "WorkSans",
                brightness: Brightness.dark,
                primaryColor: Color(0xff0177fb),
                accentColor: Color(0xffFBFB0E),
                scaffoldBackgroundColor: Color(0xff151515), //000000
                cardColor: Color(0xff252525),
              ),
              initial: AdaptiveThemeMode.light,
              builder: (theme, darkTheme) => MaterialApp(
                title: 'Toodolee',
                theme: theme,
                darkTheme: darkTheme,
                home: MainScreen(),
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
    super.initState();

    completedBox = Hive.box<CompletedTodoModel>(
        completedtodoBoxname); // completed ones are stored locally
    todoBox = Hive.box<TodoModel>(todoBoxname); // Toodos are stored locally
    boredBox = Hive.box(boringcardName); // boring cards are stored locally
    settingsBox = Hive.box(settingsName); // settings are stored locally
    //weatherBox = Hive.box(weatherBoxname);
    dailyReminderBox = Hive.box(dailyReminderBoxName);
    // when to set daily reminders Time are stored in here.
    onboardingScreenBox = Hive.box(onboardingScreenBoxName);
    // onboarding screen is shown or not is stored here
    streakBox = Hive.box<StreakModel>(streakBoxName);
    // Streaks are stored in here locally.

/*
# Clears Toodos Next Day
# Clears Completed Ones Next day
# Resets Quotes
# Reset Boring Card.

This will Reset the Toodolee.
This is kind of better version of background Tasks.

I was litterelly Tired of Seeing WORKMANAGER or any other background service not working.
So, Thanks to the Nature and Lord, this Came to the Head,

This is the Method/Function checks wheather the today's date, month's first day and it predicts weather to reset-up the Toodolee or not 
*/
    resetToodoleeMidNight(context); // this method is in processes.dart

//if notification is not allowed ask for permission of notification, (but i don't know it just does not rings 😤😤😤
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
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
                  "icon/toodoleeicon.png", // the image that is shown in the splash Screeeeeeen
                  height: MediaQuery.of(context).size.shortestSide / 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ----------------------------------------------------------------------------- 
This is the (kind of) Default Screen, Why Kind of ?
Do you noticed?
Here in Toodolee, the Bottom Navigation Bar is constant, In Toodolee, the Floating Action Button is also constant, It means they are presented in every Screen, 
and they all are rendered throughout the screen from this.

Defaulted App, Talks about the Creation of,
Bottom Navigation Bar and the Floating Action Button.
*/

class DefaultedApp extends StatefulWidget {
  @override
  _DefaultedAppState createState() => _DefaultedAppState();
}

class _DefaultedAppState extends State<DefaultedApp> {
  int _selectedItemPosition = 0; //Index of Item (selected)

  bool showSelectedLabels =
      false; // To show Labels with the Item Selected, in the Botttom Nav. bar.
  bool showUnselectedLabels =
      false; // To show Labels with the Item Un-Selected, in the Botttom Nav. bar.

  Color containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
  ];

  List pages = [
    TodoApp(), //the Most Home Page, where we can see the Streaks, Tooodooleess and Completed ones,
    MorePage(), // the Quotes and boring card, resting zone.
    SettingPage(), // Settings Page
  ]; // This is the List of Pages, that will be opened, if each of the Bottom Navi's Element is pressed.
// That is, First Element of the Bottom Navigation Bar will open TodoApp, That is the Home Page,

/* 
This is the Value listenable builder that is known for the building the app again if the total number of toooooodos is changed, like 
in the first the Tooootal number of tooodooleees is 0,
if something is added the total count will be 1, because something is added, 

If something is deleted then count will be Zero (streaks or toodolee whatever added.)
If user have done added 10, then the appp will disable floating action Button, so User can't add more.

So for all of these thing, we have to continuosly check for the totalTodoCount, which looks like this, // ValueNotifier<int> totalTodoCount = ValueNotifier(10 - (todoBox.length + completedBox.length + streakBox.length));
when a value is changed of the totalTodoCount then we will listen to changes of the value and build the app again.

These all things are done in very less time, that we can't see with our eye,
unless you have my most influential phone, which has 1gb ram. 
*/
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: totalTodoCount,
        builder: (context, remainingTodoCount, _) {
          // The App will rebuild/refresh if the total number of of Toodoo count will be changed,
          // like if user will add or subtract the Toooodoolees or streaks then the app will refresh it self elegantly.
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context)
                    .scaffoldBackgroundColor, // Creating Background color of the App to be same as the major color present in the App's Body.
                elevation:
                    0.7, // The App Bar has Elevation or Lift, So To Distinguish the elements more, that this is other bodily Element and this is App-Bar

                // Here, We are Checking, the case, if the Item Selected in the App-Bar is 2 or if it is SettingsPage then change the Title of the App bar to be the "Settings",
                // And else it is not the settingsPage, Let the Title of the Toodolee's App Bar be "Toodolee"
                title: _selectedItemPosition == 2
                    ? Text(
                        "Settings",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context)
                                .accentColor), // if the Settings page is open the title of it will be "Settings"
                      )
                    : Text(
                        "Toodolee",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context)
                                .accentColor), //if the more page is opened or Main Page, i.e where streka , Tooodolee or completed one rests then then the title will be, "Toodolee"
                      )),

            floatingActionButton: Visibility(
              // visibity is when "true" it will show the floating action button,
              // when it is false, it will hide the button, ths is important because,
              // as the use can add only 10 toodooless, not more if the toodolees is 10 then for blocking more items,
              //Hiding the Floating action button.
              visible:
                  (remainingTodoCount <= 0 || fabScrollingVisibility == false)
                      ? false
                      : true,
              child: SlideInDown(
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      showEmojiKeyboard = false;
                    });
                    player.play(
                      'sounds/navigation_forward-selection-minimal.wav',
                      stayAwake: false,
                    );
                    addTodoBottomSheet(
                        context); //Opening the BottomSheet, So that user could add their best things for the day. :love.
                  },
                  child: Icon(CarbonIcons.add),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            //body: AdTest(),
            body: pages[_selectedItemPosition],
            // Whatever Element is selected in the BottomNavBar,
            // As we see in the pages, variable which is a list, there is Three Pages, SettingsPage, TodoApp and MorePage,
            // Which ever Element is clicked, it's index will be the index, and the body will show whatever the element is selcted.
            //Really Simple it is.
            bottomNavigationBar: SnakeNavigationBar.color(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              behaviour: SnakeBarBehaviour.floating,
              snakeShape: SnakeShape.circle,
              //shape: bottomBarShape,
              //padding: padding,
              elevation: 10.0,

              ///configuration for SnakeNavigationBar.color
              snakeViewColor: Theme.of(context).bottomAppBarColor,
              selectedItemColor: Theme.of(context).accentColor,
              unselectedItemColor: Theme.of(context).colorScheme.onSurface,
              showUnselectedLabels: showUnselectedLabels,
              showSelectedLabels: showSelectedLabels,

// Items and Configuration of those Items, which are Present in the Bottom Navigation Bar.
              items: [
                BottomNavigationBarItem(
                    icon: Opacity(opacity: 0.6, child: Icon(CarbonIcons.home)),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: Opacity(opacity: 0.6, child: Icon(CarbonIcons.grid)),
                    label: 'app'),
                BottomNavigationBarItem(
                    icon: Opacity(
                        opacity: 0.6, child: Icon(CarbonIcons.settings)),
                    label: 'settings')
              ],

              currentIndex:
                  _selectedItemPosition, // the index of the page, weather it's 0 , 1 or 2 between the Home page, More page and Settings page
              onTap: (index) {
                setState(() {
                  _selectedItemPosition =
                      index; // on tap of any bottom navigation bar,
                  //if any thing tapped,
                  //the function will take the index
                  // and make the Item positiion variable to be it.
                  // so whatever the value of te item position between the 0,1 or 2 we will open the page according to the index.

                  player.play(
                    'sounds/navigation_forward-selection-minimal.wav',
                    mode: PlayerMode.MEDIA_PLAYER,
                    //Whenver Item is Selected, The Music will be sounded.
                  );
                });
              },
            ),
          );
        });
  }
}

/* ----------------------------------------------------------------------------- 
This is the Home Screen.
This has Functionality Includes,
# Chips that are present at the Top, ex. WorkingOn, Completed and Streaks
# What to show if there is nothing in the screen, i.e whiteScreen
# How much more Toodolees can be Added (limits)
*/

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // multiple choice value
  // list of pages option available for opening, which will open when we click up one of the chips.

  List pages = [WorkingOnPage(), StreakPage(), CompletedPage()];

  @override
  Widget build(BuildContext context) {
    settingsBox.put("selectedChipPage",
        0); //Inititally when the page reloads, the App's Selected Chip will be the First One of the List Pages, i.e WorkingOn() Page.

//This is Value Listenable Builder
// What it does is, It will rebuild the app every entire time when the variable of something like it will be changed,
// or if there will be changes in it,  The will be changed too, (accordingly)
// Here the Variable is totalTodoCount, which refers to the value, how much is the total todo count.
// when something is added to the toodolee or removed etc, totalTodoCund will be affected.
// Take a look at totalTodoCount by clicking on it with control or command Pressed.
// when something is added to the toodolee or removed etc, totalTodoCount will be affected.
// Take a look at totalTodoCount by clicking on it with control or command Pressed.
    return ValueListenableBuilder<int>(
        valueListenable: totalTodoCount,
        builder: (context, remainingTodoCount, _) {
          return FadeOut(
            child: Scaffold(
              body: ListView(
                children: [
                  // Showing the chips,
                  // if all something is there in the Application i.e. Toodo or Completed One or Streak then Chips will be shown
                  if (todoBox.length > 0 ||
                      completedBox.length > 0 ||
                      streakBox.length > 0)
                    //Here we are also using the ValueListenableBuilder, But here we are using the settingsBox as valueListenable.
                    // In settingsBox we will store the value of chip the user has selected, which means if inside the app, there will be naviagation the app does not loose the grip in the chip that user selected lastly,
                    // Which means, If I Navigated to Settings Page, before Navigating I was seeing my Streaks Page, so after the Navigation when I will return, My Streaks Page or streak chip will be stayed activated.

                    ValueListenableBuilder(
                        valueListenable: settingsBox.listenable(),
                        builder: (context, selectedChip, child) {
                          var workingSwitchValue = selectedChip.get(
                              "workingSelectedChip",
                              defaultValue:
                                  true); // at first the workingOn chip will be activated, not streaks, not completed chip.

                          var streakSwitchValue = selectedChip
                              .get("streakSelectedChip", defaultValue: false);
                          var completedSwitchValue = selectedChip.get(
                              "completedSelectedChip",
                              defaultValue: false);
                          return Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // scrollDirection: Axis
                                //     .horizontal, // for smalled screen users, they could navigate or scroll thughout the List.
                                children: [
/* This is the Design and Mechanism of How Chip Works,

So when The Chip is Selected, It will change every other Chip to false value and make them superior by making themselves to true.
The inititalPage will be set to how they needs.
also, the Background, Items, Body, Elements will be of their Choices.

There are exactly Three Chips, as you can see in the Front App.
 */

                                  ChoiceChip(
                                    selectedColor:
                                        Theme.of(context).accentColor,
                                    label: Text("Working on"),
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    selected: workingSwitchValue,
                                    onSelected: (val) {
                                      setState(() {
                                        player.play(
                                          'sounds/ui_tap-variant-01.wav',
                                          stayAwake: false,
                                        );
                                        initialselectedPage =
                                            0; //set the workingOn as the main Index

                                        selectedChip.put("selectedPage",
                                            0); // save it in local.
                                      });
                                      if (val == true) {
                                        player.play(
                                          'sounds/navigation_forward-selection.wav',
                                          stayAwake: false,
                                        );
                                        selectedChip.put(
                                            "workingSelectedChip", true);
                                      }
                                      selectedChip.put(
                                          "workingSelectedChip", true);
                                      selectedChip.put(
                                          "completedSelectedChip", false);

                                      selectedChip.put(
                                          "streakSelectedChip", false);
                                      print(val);
                                    },
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context)
                                                  .size
                                                  .shortestSide /
                                              60,
                                          0,
                                          MediaQuery.of(context)
                                                  .size
                                                  .shortestSide /
                                              60,
                                          0)),
                                  ChoiceChip(
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    selectedColor:
                                        Theme.of(context).accentColor,
                                    label: Text("Streak"),
                                    selected: streakSwitchValue,
                                    onSelected: (val) {
                                      setState(() {
                                        player.play(
                                          'sounds/ui_tap-variant-01.wav',
                                          stayAwake: false,
                                        );
                                        initialselectedPage = 1;

                                        selectedChip.put("selectedPage", 1);
                                      });

                                      if (val == true) {
                                        player.play(
                                          'sounds/navigation_forward-selection.wav',
                                          stayAwake: false,
                                        );
                                        selectedChip.put(
                                            "streakSelectedChip", true);
                                      }
                                      selectedChip.put(
                                          "streakSelectedChip", true);

                                      selectedChip.put(
                                          "workingSelectedChip", false);

                                      selectedChip.put(
                                          "completedSelectedChip", false);

                                      print(val);
                                    },
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context)
                                                  .size
                                                  .shortestSide /
                                              60,
                                          0,
                                          MediaQuery.of(context)
                                                  .size
                                                  .shortestSide /
                                              60,
                                          0)),
                                  ChoiceChip(
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    selectedColor:
                                        Theme.of(context).accentColor,
                                    label: Text("Completed"),
                                    selected: completedSwitchValue,
                                    onSelected: (val) {
                                      print("${streakBox.length} are length");
                                      print("${streakBox.values} are values");
                                      print(
                                          "${streakBox.isEmpty} are emptiness");
                                      print("${streakBox.keys} are keys");
                                      setState(() {
                                        player.play(
                                          'sounds/ui_tap-variant-01.wav',
                                          stayAwake: false,
                                        );
                                        initialselectedPage = 2;

                                        selectedChip.put("selectedPage", 2);
                                      });

                                      if (val == true) {
                                        player.play(
                                          'sounds/navigation_forward-selection.wav',
                                          stayAwake: false,
                                        );
                                        selectedChip.put(
                                            "completedSelectedChip", true);
                                      }
                                      selectedChip.put(
                                          "completedSelectedChip", true);

                                      selectedChip.put(
                                          "workingSelectedChip", false);
                                      selectedChip.put(
                                          "streakSelectedChip", false);

                                      print(val);
                                    },
                                  ),
                                ]),
                          );
                        })
                  else
                    Container(),

                  // If count of toodo, count of completed Toodo, and cound of streaks is combinely 0 (zero)
                  // White screen Page will be shown,
                  // It is that Fancy page, at the start that encorouges you to add Toodolee for the Today,
                  // Yes that one, ("Press + to Start") :hehe

                  if (todoBox.length <= 0 &&
                      completedBox.length <= 0 &&
                      streakBox.length <= 0)
                    whiteScreen(context)
                  else
                    Container(),

                  SlideInUp(
                    child: settingsBox.get("selectedPage") == null
                        ? pages[initialselectedPage]
                        : pages[settingsBox.get("selectedPage")],
                    duration: Duration(milliseconds: 2000),
                    //delay: Duration(milliseconds: 200),
                  ),

/*
if the remaining count is 10, then hide the counter which shows how much tooodoolee is remaining now!
Like if the Toodolee remaining is 10 hide the counter,
if not show the counter that shows how much tooodoleee is remaining today
 */
                  if (remainingTodoCount ==
                      10) // if the tooodoolee adding count is 10,
                    Container() // show an empty container
                  else // show the remaining count, if it is less than 10 is there
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Opacity(
                        opacity: 0.5,
                        child: FadeInUp(
                          duration: Duration(milliseconds: 2000),
                          child: Text(
                            "You can add : $remainingTodoCount more",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ),
                    ),
                  // This is extra space,
                  //from the bottom,
                  //so if You need to remove the last Toodo which can be hidden behind the floating action button,
                  //so the user will get room so that he could scroll and remove the last Tooodo.
                  Container(
                      height: MediaQuery.of(context).size.shortestSide / 3),
                ],
              ),
            ),
          );
        });
  }
}

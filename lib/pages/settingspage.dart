import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_settings/app_settings.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_group/flutter_radio_group.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share/share.dart';
import 'package:toodo/Notification/setNotification.dart';
import 'package:toodo/main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

/* 

This is the Settings Page, here the Settings like,
🔔 Notification Settings - Daily, Remainder, Local Phone etc.
🎨 Theme Settings - Light or Dark Theme
☕ You can Support the Toodolee Financially to help it grow more.
📷 Instagram etc. Settings are configured here.
*/
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var listVertical = [
    // this List is for the themes Section of the App, Weather to choose the Ligt Theme or dark
    "Light",
    "Dark",
  ];

  var indexVertical =
      0; // Inititally the index will be, 0 of the List Vertical we are talking above (just above)
  var keyVertical = GlobalKey<
      FlutterRadioGroupState>(); // this is the Key for the Flutter Radio Group Plugin.
  @override
  void initState() {
    /// Call out to intialize platform state.
    initPlatformState(); // Mentioned just below. // this is also for the Flutter Radio Group Plugin
    super.initState();
  }

  /// Initialize platform state.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    Future<TimeOfDay> openTimePickerDaily(BuildContext context) async {
      final TimeOfDay t =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (t != null) {
        setState(() {
          settingsBox.put("dailyNotifications", true);
          dailyRemainder = t.format(context);
          dailyRemainderBox.put("remainderTime", dailyRemainder);
          /* Many of the people use AM/PM things and many of them use 24 hour mode, 
                so the toodolee is for everyone, 
                so we had to set remainders for both of the every group. 
                so we are doing - 
                
                if remainder has PM, then Remove PM from the game, whatever left set that as the remainder. 
                If remainder has AM in it, then Remove AM from the game, whatever left set that as the remainder. 
                The errors preceds for this group,
                Suppose one of the hero, woke up at 6:00 and set the remainder of "Create Quadcopter 🚁 at 8 pm", 
                then the Notification can set Remainders for 8:00 am and won't ring at 8:00 night! 
                (Grave errrrror Right).
                That's they are using something, 
                1. Remove the PM/AM
                2. Converts whatever number they have to 24 hours clock.

                In this way it is efficient and more reliable.
                This process is done by the Function, getRemainderTime().
                which is in the last line of the setNotifications.dart

                BTW,
                and if remainder has nothing, i.e PM/AM then, this is clear person has set remainder from 24 hours clock.
                So setting remianders in this case is easy as eatin Eat Watermelons.
                
                For more Info, Check getRemainderTime() method, which is in the last line of the Notification/setNotification.dart
                */

          // Set Daily Remainder takes only One Parameter, Which is the Time, And it must be list.

          if (dailyRemainderBox.get("remainderTime").contains("PM") == true) {
            // We are getting the remainder Time from the most popular method for getting the tie in List format of Int, that we are using in many places,
            // occurrence: [addTodoBottomSheet.dart, line: 623 and 173] & setNotification.dart Last Line.
            setDailyRemainderMethod(
                getRemainderTime(
                    dailyRemainderBox.get("remainderTime"), context),
                context);

            // Next Thing they are doing is the, putting the hour and minute in the list also in the memory or local Storage
            // so to show it in UI, when the Notifications will be ringing,
            // so in the remainder Time  they are saving in the terms of list,
            // we are taking the Time with the help of most popluar method for getting the remainder Time, yeps, The getRemainderTime(), check it using ctrl + click on the method.
            dailyRemainderBox.put("remainderTime", [
              getRemainderTime(dailyRemainderBox.get("remainderTime"), context)
                  .first,
              getRemainderTime(dailyRemainderBox.get("remainderTime"), context)
                  .last,
            ]);
          } else if (dailyRemainderBox.get("remainderTime").contains("AM") ==
              true) {
            // If the Time has AM in it, then No need to convert it to the 24 hr clock, as Am is less than 12, so we are just putting the block Directly
            setDailyRemainderMethod(
                getRemainderTime(
                    dailyRemainderBox.get("remainderTime"), context),
                context);
            // Next Thing they are doing is the, putting the hour and minute in the list also in the memory or local Storage
            // so to show it in UI, when the Notifications will be ringing,
            // so in the remainder Time  they are saving in the terms of list,
            // we are taking the Time with the help of most popluar method for getting the remainder Time, yeps, The getRemainderTime(), check it using ctrl + click on the method.

            dailyRemainderBox.put("remainderTime", [
              getRemainderTime(dailyRemainderBox.get("remainderTime"), context)
                  .first,
              getRemainderTime(dailyRemainderBox.get("remainderTime"), context)
                  .last,
            ]);
          } else if (dailyRemainderBox.get("remainderTime").contains("AM") ==
                  false &&
              dailyRemainderBox.get("remainderTime").contains("PM") == false) {
            // if the time set has not PM, not nor AM in it, then set the Remainder Directly

            setDailyRemainderMethod(
                getRemainderTime(
                    dailyRemainderBox.get("remainderTime"), context),
                context);
            // Next Thing they are doing is the, putting the hour and minute in the list also in the memory or local Storage
            // so to show it in UI, when the Notifications will be ringing,
            // so in the remainder Time  they are saving in the terms of list,
            // we are taking the Time with the help of most popluar method for getting the remainder Time, yeps, The getRemainderTime(), check it using ctrl + click on the method.

            dailyRemainderBox.put("remainderTime", [
              getRemainderTime(dailyRemainderBox.get("remainderTime"), context)
                  .first,
              getRemainderTime(dailyRemainderBox.get("remainderTime"), context)
                  .last,
            ]);
          }
        });
      }
    }

// The Body
    return Scaffold(
      body: ListView(
        children: [
          ExpansionCard(
            title: Text(
              "Invite People",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            leading: Icon(
              CarbonIcons.share, color: Theme.of(context).colorScheme.onSurface,
              // color: Theme.of(context).primaryColor,
            ),
            children: <Widget>[
              Column(children: [
                // <-- Collapses when tapped on
                MaterialButton(
                  // Invite People/Instant Invite button
                  onPressed: () {
                    Share.share(
                        "\n\nLife is All About Limiting the things to get unlimited things and results...\n Download Up Toodolee, it's all about being limitlesss.");
                  },
                  child: ListTile(
                    leading: Icon(CarbonIcons.user_follow),
                    title: Text("Send Instant Invites"),
                  ),
                ),

                MaterialButton(
                  // Copy the App Link
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(CarbonIcons.copy),
                    title: Text("Copy the Link"),
                  ),
                ),
                MaterialButton(
                  //Rate the App
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(CarbonIcons.star),
                    title: Text("Rate the App"),
                  ),
                ),
              ]),
            ],
          ),
          Divider(),
          /*------------------------------------------------------------------------------------------------*/

          ExpansionCard(
            title: Text(
              "Notifications",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            leading: Icon(
              CarbonIcons.notification,
              color: Theme.of(context).colorScheme.onSurface,
              // color: Theme.of(context).primaryColor,
            ),
            children: <Widget>[
              Column(children: [
                // <-- Collapses when tapped on
                Column(
                  children: [
                    // Shows when to set Remainders (daily ones)
                    // Also the Whole List Tile becomes clickeble, when tapped on it will open the Time Picker, so to set the Remainders for the Next Day,
                    GestureDetector(
                      onTap: () {
                        openTimePickerDaily(context); // opens the Time Picker
                      },
                      child: ListTile(
                        title: Opacity(
                          opacity: 0.6,
                          child: Text("Tommorow, Start Journey at"),
                        ),

                        // When the Time is Clicked, then New Time Picker will be opened.
                        // This will help users to set the Time for the Day. or next Day
                        trailing: Text(
                            //If the dailyRemainder is null, when app is newly installed the most likely is that it would be null, then the app will show in the text,
                            // dailyRemainder or 6:30 which is default Time, You can Check OnBording Screeen for it.
                            dailyRemainderBox.get("remainderTime") == null
                                ? "$dailyRemainder"
                                /* If the daily Remainder is not null, 
                               then this will also serve a problem, the problem is,
                    
                                The problem Comes, when the Body looks like when the Notification poooops down,
                                Tap and write toodo, 4:0, now it should be looking 4:00, It looks, 4:0 which is looking like one of the verse of the Holy Book. :hehe, 
                                also minute part does not creates trouble-ing, when the minute is like 45, 11, etc, (two digited)
                                it troubles when the minute is like 01, 05, 08... etc. ex, 4:09 will be written by the notification as 4:9,
                                So What we are doing is, getting the length of the minute,
                                if the length of minute is One, we are adding Zero at the start of the minute and
                                if the minute is two digited then we are doing nothing. (showing as it is.)
                                
                              */
                                : dailyRemainderBox
                                            .get('remainderTime')[1]
                                            .toString()
                                            .length ==
                                        1 //getting the length of the minute, and checking if it is 1
                                    ? "${dailyRemainderBox.get("remainderTime")[0]}:0${dailyRemainderBox.get('remainderTime')[1]}" // if it is One, we are adding Zero at the start of the minute and
                                    : "${dailyRemainderBox.get("remainderTime")[0]}:${dailyRemainderBox.get('remainderTime')[1]}", //if the minute is two digited then we are doing nothing. (showing as it is.)
                            style: TextStyle(
                              color: Colors.blue,
                            )),
                      ),
                    ),
                    Divider(),
                    /*------------------------------------------------------------------------------------------------*/

// This ValueListenableBuilder is created for the daily Notifications,
// It saves the Value of Notification On or Off of Switch, because the problem with switch is that they do not save their value locally, which maeans every reload of the app the switch will come to the false and you dont want to set the daily remainder daily and ask app to set "yes" or "on" to the show daily Remainder Notifications, no!
// So we are saving everything inside the box, so to save yes as yes no as no and every bit of thing which user want to set, in the app.
// The new value listenable is build for every switch (on or off one)
                    ValueListenableBuilder(
                      valueListenable: settingsBox.listenable(),
                      builder: (context, dailyNotification, child) {
                        var switchValue =
                            dailyNotification.get("dailyNotifications");
                        // in the onboarding Screen we had set the value of it to be true,
                        //so default value will be set to the true,
                        //So this following line is checking and storing the value of the dailyNotification,
                        //if it is true then the value of switchValue will be true and if it is false and the value of switch will also be false.
                        return SwitchListTile(
                          title: Text("Daily Notifications"),
                          value:
                              switchValue, // sets value true/false in the context of what is in the, local Storage, if the local storage says, the value is true, (shows true) else (shows false)
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val) {
                            /* 
                            These Following Lines Do,


                            1. 
                            When the you tap the switch button, if it is true, 
                            in the local storage we will pass the value to be true, in this way the switch won't loose the data
                            and will not go "off" when the app rebuild.
                            Also if the the switch is set to true, it will set/start the notifications.
                            
                            
                            2.
                            IF the switch Button is set to false,
                            in the local storage we will pass the value to be false,
                            in this way the switch won't loose the data and will not go "off" when the app rebuild.
                            Also there will be the cancelling of notification, so it will not ring up in the future.
                            // The ID of the Following Notification is 5000,
                            //of Daily Notifications.
                            //so we will use Awesome Notification plugin which is AwesomeNotifications().cancel to cancel the notifications
                            
                            */
                            if (val == false) {
                              player.play(
                                'sounds/state-change_confirm-down.wav',
                                stayAwake: false,
                              );

                              AwesomeNotifications().cancel(
                                  5000); // the Id of the daily notification is 5000, so, the notification will be cancelled.
                              dailyNotification.put("dailyNotifications",
                                  false); // set the value of the switch be false, also in the local.
                            } else {
                              player.play(
                                'sounds/state-change_confirm-up.wav',
                                stayAwake: false,
                              );
                              dailyNotification.put("dailyNotifications",
                                  true); // set the value of the switch be true, also in the local.
                            }

                            setDailyRemainderMethod(
                                dailyRemainderBox.get('remainderTime'),
                                context); // setting the notification and starting it.
                          },
                        );
                      },
                    ),

                    // This ValueListenableBuilder is created for the remainder Notifications,
// It saves the Value of Notification On or Off of Switch, because the problem with switch is that they do not save their value locally, which maeans every reload of the app the switch will come to the false and you dont want to set the daily remainder daily and ask app to set "yes" or "on" to the show daily Remainder Notifications, no!
// So we are saving everything inside the box, so to save yes as yes no as no and every bit of thing which user want to set, in the app.
// The new value listenable is build for every switch (on or off one)

                    ValueListenableBuilder(
                      valueListenable: Hive.box(settingsName).listenable(),
                      builder: (context, remainderNotification, child) {
                        // in the onboarding Screen we had set the value of it to be true,
                        //so default value will be set to the true,
                        //So this following line is checking and storing the value of the dailyNotification,
                        //if it is true then the value of switchValue will be true and if it is false and the value of switch will also be false.

                        var switchValue =
                            remainderNotification.get("remainderNotifications");
                        return SwitchListTile(
                          title: Text("Remainder Notifications"),
                          value: switchValue,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val) {
                            /* 
                            These Following Lines Do,
                              Save on or Off value in local so if App reloads the value will not be changed,
                */
                            if (val == false) {
                              player.play(
                                'sounds/state-change_confirm-down.wav',
                                stayAwake: false,
                              );
                            } else {
                              player.play(
                                'sounds/state-change_confirm-up.wav',
                                stayAwake: false,
                              );
                            }
                            remainderNotification.put("remainderNotifications",
                                !switchValue); // set the value of the switch be false, also in the local.

                            /* 
                            You may be wondering, why is the remaindder are not cancelling or the older one if the value goeas false,
                            In the setRemainderMethod() in the lib\Notification\setNotification.dart there, 
                            it sets remainder if the dailyNotification is set to true, so all of it goes with the future toodos that are going to be written, not previous ones, hence the previous one will ring.
                            
                              */
                          },
                        );
                      },
                    ),
                  ],
                ),
              ]),

              // This will be opening the local OS settings for Notification so user can see additional Notification settings.
              GestureDetector(
                onTap: () {
                  AppSettings.openNotificationSettings(); // opens App Settings.
                },
                child: ListTile(
                  trailing: IconButton(
                      icon: Icon(CarbonIcons.launch),
                      onPressed: () {
                        AppSettings.openNotificationSettings();
                      }),
                  title: Text("Check Notifications Settings"),
                ),
              )
            ],
          ),
          Divider(),
          /*------------------------------------------------------------------------------------------------*/

          //Theme Setting.
          ExpansionCard(
            title: Text(
              "Themes",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            leading: Icon(
              CarbonIcons.paint_brush,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            children: <Widget>[
              Column(children: [
                // <-- Collapses when tapped on
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.shortestSide / 10,
                          0,
                          MediaQuery.of(context).size.shortestSide / 10,
                          0),
                      /*
                          This is the ValueListenableBuilder of the Theme, the Two Options that you see in your setttings Page, 
                          1. Light
                          2. Dark

                          This helps in changing the themes, 

                          */
                      child: ValueListenableBuilder(
                          valueListenable: settingsBox.listenable(),
                          builder: (context, isLightMode, _) {
                            var switchValue = isLightMode.get("isLightMode",
                                defaultValue:
                                    true); // default value of the theme mode is light, so when the app opens we will see light mode as our default
                            return FlutterRadioGroup(
                                // This plugin helps in making the Radio Buttons.
                                key: keyVertical, // this is key
                                titles:
                                    listVertical, // this is the list on the most top we wrote [light, dark] ones
                                defaultSelected:
                                    switchValue == true ? indexVertical : 1,
                                // (indexVertical value is 0, check line: 37 above.)
                                // this line says, if the switchValue is true which means if the light mode is true,
                                //then set the index to be zero of list [light, dark]
                                //and if it is false then make it 1, and 1 is dark of list [light, dark];
                                onChanged: (index) {
                                  setState(() {
                                    indexVertical = index;
                                    if (listVertical[indexVertical] ==
                                        "Light") {
                                      // if the tapped value is "Light"
                                      // then set the isLightMode = true and set the mode to Light via AdaptiveTheme Plugin
                                      player.play(
                                        'sounds/state-change_confirm-down.wav',
                                        stayAwake: false,
                                      );
                                      settingsBox.put("isLightMode",
                                          true); // locally store the value to be light,
                                      AdaptiveTheme.of(context)
                                          .setLight(); // set the mode to light.
                                    } else if (listVertical[indexVertical] ==
                                        "Dark") {
                                      // if the tapped value is "Dark"
                                      // then set the isLightMode = true and set the mode to Dark via AdaptiveTheme Plugin
                                      player.play(
                                        'sounds/state-change_confirm-up.wav',
                                        stayAwake: false,
                                      );
                                      settingsBox.put("isLightMode",
                                          false); // set (locally) the value of dark mode to be true,
                                      AdaptiveTheme.of(context)
                                          .setDark(); // sets the mode to dark
                                    }
                                  });
                                });
                          }),
                    ),
                  ],
                ),
              ]),
            ],
          ),
          Divider(),
          /*------------------------------------------------------------------------------------------------*/

// This is a setting that you can do in their lives, the users, the world. the humanity,
/*

Toodoleee is a revolt Against All Tooodo apps, 
Because they worsen your creatvity and productivitiness. 
This is a simple introduction of most simplest app, 
Toodolee Toodolee wants to revolutionarize the whole Toodo App World, 
There are Pretty much lot of apps in this world,
but Toodolee is certainly not among them,
it focuses on Limited-ness and focuses on writing up most important Toodos for the Day.
People tend to write really unrelated things like,
Bathing,
Sleeping,
etc. for the whole day, 
which is really really unproductive,
Toodolee focuses for you maximally limited things,
because, when the days are limited why are not your works?
Toodoleee is a revolt Against All Tooodo apps,
Because they worsen your creatvity and productivitiness.

To Sustain it, 
To make a change for the people around us,
the people who leave their world who wanted to do world changing something but didn't able to do,
ones who were crazy for their dreams.

As a Human what we can't do together, (from starting, Hunting, Gathering and now biggest World Innovations like Toodolee)
So, If you can contribute to the upcomming generations, most happiliy contribute what you have abundant-ly (me = grateful)


Tap and Give the Coooofffee to all of them, who made possible this Toodolee and doing unlimited efforts to sustain it.
Wake them up with the coffee, so they never sleep, and make the best of Toodolee. (amen)
 */
          GestureDetector(
            onTap: () async {
              player.play(
                'sounds/navigation_forward-selection-minimal.wav',
                stayAwake: false,
              );
              String texturl =
                  "https://www.buymeacoffee.com/toodolee"; //link of buy me a coffee ☕

              await canLaunch(texturl)
                  // checks if the link can be launched or not, if can be launched then it launches the link inside the default browser (Chrome/Firefox).
                  ? await launch(
                      texturl) // launch the URL inside the default browser.
                  : throw 'Could not launch $texturl'; // If now Throw an error/exception
            },
            child: ListTile(
              title: Text(
                "Love",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              leading: Icon(
                CarbonIcons.thumbs_up,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Divider(),
          /*------------------------------------------------------------------------------------------------*/
          Column(
            children: [
              Row(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: IconButton(
                        icon: Icon(CarbonIcons.logo_instagram),
                        onPressed: () async {
                          String texturl = "https://www.instagram.com/toodolee";

                          await canLaunch(texturl)
                              ? await launch(texturl)
                              : throw 'Could not launch $texturl';
                          //https://www.instagram.com/project_coded/
                        }),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: IconButton(
                        icon: Icon(CarbonIcons.favorite),
                        onPressed: () async {
                          String texturl =
                              "https://www.buymeacoffee.com/toodolee";

                          await canLaunch(texturl)
                              ? await launch(texturl)
                              : throw 'Could not launch $texturl';
                          //https://www.instagram.com/project_coded/
                        }),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: IconButton(
                        icon: Icon(CarbonIcons.delete),
                        onPressed: () async {
                          onboardingScreenBox.put("shownOnBoard", false);
                          settingsBox.clear();
                          // https://toodolee.blogspot.com/p/meeeet-you-tooodoleee-i-am-giving-you.html
                          //https://www.instagram.com/project_coded/
                        }),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: IconButton(
                        icon: Icon(CarbonIcons.overflow_menu_horizontal),
                        onPressed: () async {
                          String texturl =
                              "https://toodolee.blogspot.com/p/meeeet-you-tooodoleee-i-am-giving-you.html";

                          await canLaunch(texturl)
                              ? await launch(texturl)
                              : throw 'Could not launch $texturl';
                          //https://www.instagram.com/project_coded/
                        }),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

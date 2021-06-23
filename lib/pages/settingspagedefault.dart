import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_settings/app_settings.dart';
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

// bool dailyNotifications = true;

var listVertical = [
  "Light",
  "Dark",
];

Map convertTimetotwentyFourHourClock = {
  1: 13,
  2: 14,
  3: 15,
  4: 16,
  5: 17,
  6: 18,
  7: 19,
  8: 20,
  9: 21,
  10: 22,
  11: 23,
  12: 12,
};

var suffix = "";
var indexVertical = 0;
var keyVertical = GlobalKey<FlutterRadioGroupState>();

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    /// Call out to intialize platform state.
    initPlatformState();
    super.initState();
  }

  /// Initialize platform state.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  Future<void> _launched;

  Future<void> _launchBoringWorkinWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: true,
          forceWebView: true,
          headers: <String, String>{'my_header_key': 'my_value_key'});
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<TimeOfDay> openTimePickerDaily(BuildContext context) async {
      final TimeOfDay t =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (t != null) {
        setState(() {
          settingsBox.put("dailyNotifications", true);
          dailyRemainder = t.format(context);
          dailyRemainderBox.put("remainderTime", dailyRemainder);

          if (dailyRemainderBox.get("remainderTime").contains("PM") == true) {
            setState(() {
              suffix = "PM";
            });
            var splittingSpace =
                dailyRemainderBox.get("remainderTime").split(" ");
            var removePM = splittingSpace.removeAt(0);

            var removeUnwantedSymbol = removePM.split(":");

            var hourToBeChanged = int.parse(removeUnwantedSymbol.first);

            var hour = convertTimetotwentyFourHourClock[hourToBeChanged];
            var minute = removeUnwantedSymbol.last;

            var remainderTime = [hour.toString(), minute.toString()];
            dailyRemainderBox.put("remainderTime", remainderTime);
            print(remainderTime);
            print(hour);
            print(minute);
            setDailyRemainderMethod(
                dailyRemainderBox.get("remainderTime"), context);
          } else if (dailyRemainderBox.get("remainderTime").contains("AM") ==
              true) {
            setState(() {
              suffix = "AM";
            });
            var splittingSpace =
                dailyRemainderBox.get("remainderTime").split(" ");
            var removeAM = splittingSpace.removeAt(0);

            var remainderTime = removeAM.split(":");
            dailyRemainderBox.put("remainderTime", remainderTime);
            setDailyRemainderMethod(
                dailyRemainderBox.get("remainderTime"), context);
          } else if (dailyRemainderBox.get("remainderTime").contains("AM") ==
                  false &&
              dailyRemainderBox.get("remainderTime").contains("PM") == false) {
            setState(() {
              suffix = "";
            });
            var remainderTime =
                dailyRemainderBox.get("remainderTime").split(":");
            dailyRemainderBox.put("remainderTime", remainderTime);
            setDailyRemainderMethod(
                dailyRemainderBox.get("remainderTime"), context);
          }
        });
      }
    }

    // var hourofRemainder = convertTimetotwentyFourHourClock[
    //     dailyRemainderBox.get("remainderTime")[0]];

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
                  onPressed: () {
                    Share.share(
                        "\n\nLife is All About Limiting the things to get unlimited things and results...\n Download Up Toodolee, it's all about being limitlesss.");
                  },
                  child: ListTile(
                    leading: Icon(CarbonIcons.user_follow),
                    title: Text("Send Instant Invites"),
                  ),
                ),
                // MaterialButton(
                //   onPressed: () {
                //     Share.share(
                //         "If your Days are Limited, Your Time is Limited, Why are not your Things?\n\nLife is All About Limiting the things to get unlimited things and results...\n Download Up Toodolee, it's all about being limitlesss.");
                //   },
                //   child: ListTile(
                //     leading: Icon(CarbonIcons.phone),
                //     title: Text("Invite by Call"),
                //   ),
                // ),

                MaterialButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(CarbonIcons.copy),
                    title: Text("Copy the Link"),
                  ),
                ),
                MaterialButton(
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
                    ListTile(
                      title: Opacity(
                        opacity: 0.6,
                        child: Text("Tommorow, Start Journey at"),
                      ),
                      trailing: MaterialButton(
                          onPressed: () {
                            openTimePickerDaily(context);
                          },
                          child: Text(
                              dailyRemainderBox.get("remainderTime") == null
                                  ? "$dailyRemainder"
                                  : "${dailyRemainderBox.get("remainderTime")[0]}:${dailyRemainderBox.get('remainderTime')[1]} $suffix",
                              style: TextStyle(
                                  color: Colors.blue, fontFamily: "WorkSans"))),
                    ),
                    Divider(),
                    ValueListenableBuilder(
                      valueListenable: settingsBox.listenable(),
                      builder: (context, dailyNotification, child) {
                        var switchValue =
                            dailyNotification.get("dailyNotifications");
                        return SwitchListTile(
                          title: Text("Daily Notifications"),
                          value: switchValue,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val) {
                            print("$dailyRemainderBox.get('remainderTime')");
                            //boredNotifications = value;
                            //dailyNotifications = value;
                            if (val == false) {
                              player.play(
                                'sounds/state-change_confirm-down.wav',
                                stayAwake: false,
                                // mode: PlayerMode.LOW_LATENCY,
                              );
                              dailyNotification.put(
                                  "dailyNotifications", false);
                            } else {
                              player.play(
                                'sounds/state-change_confirm-up.wav',
                                stayAwake: false,
                                // mode: PlayerMode.LOW_LATENCY,
                              );
                              dailyNotification.put("dailyNotifications", true);
                            }

                            if (settingsBox.get("dailyNotifications") == true) {
                              setDailyRemainderMethod(
                                  dailyRemainderBox.get('remainderTime'),
                                  context);
                            }
                            //dailyNotification = !dailyNotification;
                            print(val);

                            print(
                                "$dailyNotification is value of dailyNotification");

                            //print(settingsBox.get("dailyNotifications"));
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: Hive.box(settingsName).listenable(),
                      builder: (context, remainderNotification, child) {
                        var switchValue =
                            remainderNotification.get("remainderNotifications");
                        return SwitchListTile(
                          title: Text("Remainder Notifications"),
                          value: switchValue,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val) {
                            if (val == false) {
                              player.play(
                                'sounds/state-change_confirm-down.wav',
                                stayAwake: false,
                                // mode: PlayerMode.LOW_LATENCY,
                              );
                            } else {
                              player.play(
                                'sounds/state-change_confirm-up.wav',
                                stayAwake: false,
                                // mode: PlayerMode.LOW_LATENCY,
                              );
                            }
                            remainderNotification.put(
                                "remainderNotifications", !switchValue);

                            print(val);
                          },
                        );
                      },
                    ),
                    // ValueListenableBuilder(
                    //   valueListenable: Hive.box(settingsName).listenable(),
                    //   builder: (context, quotesNotification, child) {
                    //     var switchValue = quotesNotification
                    //         .get("quotesNotifications", defaultValue: false);
                    //     return SwitchListTile(
                    //       title: Text("Quotes Notifications"),
                    //       value: switchValue,
                    //       activeColor: Theme.of(context).primaryColor,
                    //       onChanged: (val) {
                    //         //  showperiodicallyQuotesNotification(context);

                    //         if (val == false) {
                    //           player.play(
                    //             'sounds/state-change_confirm-down.wav',
                    //             stayAwake: false,
                    //             // mode: PlayerMode.LOW_LATENCY,
                    //           );
                    //         } else {
                    //           player.play(
                    //             'sounds/state-change_confirm-up.wav',
                    //             stayAwake: false,
                    //           );
                    //         }
                    //         quotesNotification.put(
                    //             "quotesNotifications", !switchValue);

                    //         print(val);
                    //       },
                    //     );
                    //   },
                    // ),
                    // ValueListenableBuilder(
                    //   valueListenable: Hive.box(settingsName).listenable(),
                    //   builder: (context, boredNotification, child) {
                    //     var switchValue = boredNotification
                    //         .get("boredNotifications", defaultValue: false);
                    //     return SwitchListTile(
                    //       title: Text("Bored Card Notifications"),
                    //       value: switchValue,
                    //       activeColor: Theme.of(context).primaryColor,
                    //       onChanged: (val) {
                    //         if (val == false) {
                    //           player.play(
                    //             'sounds/state-change_confirm-down.wav',
                    //             stayAwake: false,
                    //             // mode: PlayerMode.LOW_LATENCY,
                    //           );
                    //         } else {
                    //           player.play(
                    //             'sounds/state-change_confirm-up.wav',
                    //             stayAwake: false,
                    //             // mode: PlayerMode.LOW_LATENCY,
                    //           );
                    //         }
                    //         boredNotification.put(
                    //             "boredNotifications", !switchValue);

                    //         print(val);
                    //       },
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ]),
              GestureDetector(
                onTap: () {
                  AppSettings.openNotificationSettings();
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
                    // Text(
                    //   "Vertical -> index selected $indexVertical - ${listVertical[indexVertical]}",
                    //   style: TextStyle(fontSize: 16),
                    // ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.shortestSide / 10,
                          0,
                          MediaQuery.of(context).size.shortestSide / 10,
                          0),
                      child: ValueListenableBuilder(
                          valueListenable: settingsBox.listenable(),
                          builder: (context, isLightMode, _) {
                            var switchValue = isLightMode.get("isLightMode",
                                defaultValue: true);
                            return FlutterRadioGroup(
                                key: keyVertical,
                                titles: listVertical,
                                defaultSelected:
                                    switchValue == true ? indexVertical : 1,
                                onChanged: (index) {
                                  setState(() {
                                    indexVertical = index;
                                    if (listVertical[indexVertical] ==
                                        "Light") {
                                      player.play(
                                        'sounds/state-change_confirm-down.wav',
                                        stayAwake: false,
                                        // mode: PlayerMode.LOW_LATENCY,
                                      );
                                      settingsBox.put("isLightMode", true);
                                      AdaptiveTheme.of(context).setLight();
                                    } else if (listVertical[indexVertical] ==
                                        "Dark") {
                                      player.play(
                                        'sounds/state-change_confirm-up.wav',
                                        stayAwake: false,
                                        // mode: PlayerMode.LOW_LATENCY,
                                      );
                                      settingsBox.put("isLightMode", false);
                                      AdaptiveTheme.of(context).setDark();
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
          GestureDetector(
            onTap: () async {
              player.play(
                'sounds/navigation_forward-selection-minimal.wav',
                stayAwake: false,
                // mode: PlayerMode.LOW_LATENCY,
              );
              String texturl = "https://www.buymeacoffee.com/toodolee";

              await canLaunch(texturl)
                  ? await launch(texturl)
                  : throw 'Could not launch $texturl';
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
              // trailing: Icon(CarbonIcons.gift,
              //     color: Theme.of(context).backgroundColor),
            ),
          ),
          Divider(),
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

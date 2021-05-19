import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/main.dart';

import '../adTest.dart';

// bool dailyNotifications = true;
bool remainderNotifications = true;
bool quotesNotifications = false;
bool boredNotifications = false;

var settingsBox = Hive.box(settingsName);

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    // settingsBox.put("dailyNotifications", dailyNotifications);

    // settingsBox.put("remainderNotifications", true);
    // settingsBox.put("quotesNotifications", false);
    //settingsBox.put("boredNotifications", false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Page"),
      ),
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
                FlatButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(CarbonIcons.user_follow),
                    title: Text("Send Instant Invites"),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(CarbonIcons.copy),
                    title: Text("Copy the Link"),
                  ),
                ),
                FlatButton(
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
                    ValueListenableBuilder(
                      valueListenable: Hive.box(settingsName).listenable(),
                      builder: (context, dailyNotification, child) {
                        var switchValue = dailyNotification
                            .get("dailyNotifications", defaultValue: true);
                        return SwitchListTile(
                          title: Text("Daily Notifications"),
                          value: switchValue,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val) {
                            //boredNotifications = value;
                            //dailyNotifications = value;

                            dailyNotification.put(
                                "dailyNotifications", !switchValue);
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
                        var switchValue = remainderNotification
                            .get("remainderNotifications", defaultValue: true);
                        return SwitchListTile(
                          title: Text("Remainder Notifications"),
                          value: switchValue,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val) {
                            //boredNotifications = value;
                            //dailyNotifications = value;

                            remainderNotification.put(
                                "remainderNotifications", !switchValue);
                            //dailyNotification = !dailyNotification;
                            print(val);

                            //print(settingsBox.get("dailyNotifications"));
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: Hive.box(settingsName).listenable(),
                      builder: (context, quotesNotification, child) {
                        var switchValue = quotesNotification
                            .get("quotesNotifications", defaultValue: false);
                        return SwitchListTile(
                          title: Text("Quotes Notifications"),
                          value: switchValue,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val) {
                            //boredNotifications = value;
                            //dailyNotifications = value;

                            quotesNotification.put(
                                "quotesNotifications", !switchValue);
                            //dailyNotification = !dailyNotification;
                            print(val);

                            //print(settingsBox.get("dailyNotifications"));
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: Hive.box(settingsName).listenable(),
                      builder: (context, boredNotification, child) {
                        var switchValue = boredNotification
                            .get("boredNotifications", defaultValue: false);
                        return SwitchListTile(
                          title: Text("Bored Card Notifications"),
                          value: switchValue,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val) {
                            //boredNotifications = value;
                            //dailyNotifications = value;

                            boredNotification.put(
                                "boredNotifications", !switchValue);
                            //dailyNotification = !dailyNotification;
                            print(val);

                            //print(settingsBox.get("dailyNotifications"));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ]),
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
                    RadioListTile(
                      title: Text("MikSon Mode"),
                      value: false,
                      onChanged: (bool value) {
                        setState(() {
                          AdaptiveTheme.of(context).setDark();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Mahumli Mode"),
                      value: false,
                      onChanged: (bool value) {
                        setState(() {
                          AdaptiveTheme.of(context).setLight();
                        });
                      },
                    ),
                  ],
                ),
              ]),
            ],
          ),
          Divider(),
          FlatButton(
            onPressed: () {},
            child: ExpansionCard(
              onExpansionChanged: (bool value) {
                
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => AdTest(),
                  ),
                );
              },
              title: Text(
                "Ads - You May like",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              leading: Icon(
                CarbonIcons.thumbs_up,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              trailing: Icon(Icons.expand_more),
            ),
          ),
          Divider(),
          Card(
              child: Column(
            children: [
              ListTile(
                  leading: IconButton(
                      icon: Icon(CarbonIcons.logo_instagram),
                      onPressed: () {
                        //https://www.instagram.com/project_coded/
                      })),
              ListTile(title: Text("Social Links")),
            ],
          ))
        ],
      ),
    );
  }
}

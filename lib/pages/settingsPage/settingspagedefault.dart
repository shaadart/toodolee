import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';

import 'package:toodo/main.dart';

bool dailyNotifications = true;
bool remainderNotifications = true;
bool quotesNotifications = false;
bool boredNotifications = false;

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
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
                ListTile(
                  title: Text("Send Instant Invites"),
                ),
                ListTile(
                  title: Text("Copy the Link"),
                ),
                ListTile(
                  title: Text("Rate the App"),
                ),

                Divider(),
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
                    SwitchListTile(
                      title: Text("Daily Notifications"),
                      value: dailyNotifications,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          dailyNotifications = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: Text("Remainder Notifications"),
                      value: remainderNotifications,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          remainderNotifications = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: Text("Quotes Notifications"),
                      value: quotesNotifications,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          quotesNotifications = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: Text("Bored Card Notifications"),
                      value: boredNotifications,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          boredNotifications = value;
                        });
                      },
                    ),
                  ],
                ),
                Divider()
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
                    Divider()
                  ],
                ),
              ]),
            ],
          ),
          Divider(),
          ExpansionCard(
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

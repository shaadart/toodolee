import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
//import "package:permission_handler/permission_handler.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:toodo/main.dart';
import 'package:toodo/pages/more.dart';
import 'package:toodo/processes.dart';

String dailyRemainder = "6:30";
var dailyRemainderBox = Hive.box(dailyRemainderBoxName);

class TommorowNotification extends StatefulWidget {
  const TommorowNotification({
    Key key,
  }) : super(key: key);

  @override
  _TommorowNotificationState createState() => _TommorowNotificationState();
}

class _TommorowNotificationState extends State<TommorowNotification> {
  Future<TimeOfDay> openTimePickerDaily(BuildContext context) async {
    final TimeOfDay t =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t != null) {
      setState(() {
        dailyRemainder = t.format(context);
        dailyRemainderBox.put("remainderTime", dailyRemainder);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          title: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 30,
                  MediaQuery.of(context).size.width / 30,
                  MediaQuery.of(context).size.width / 30,
                  0),
              child: Text('Hey 😃, Tommorow, Remind me to Write Toodolees at ',
                  style: TextStyle(fontFamily: "WorkSans")),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 25, 0, 0, 0),
          child: FlatButton(
              onPressed: () {
                openTimePickerDaily(context);
                //setDailyRemainderMethod(dailyRemainder, context);
              },
              child: Text(
                  dailyRemainderBox.get("remainderTime") == null
                      ? "$dailyRemainder"
                      : "${dailyRemainderBox.get('remainderTime')}",
                  style:
                      TextStyle(color: Colors.blue, fontFamily: "WorkSans"))),
        ),
      ],
    );
  }
}

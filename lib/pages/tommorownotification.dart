import 'package:audioplayers/audioplayers.dart';
import 'package:extended_image/extended_image.dart';
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

String dailyRemainder = "6:30";

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: ElevatedButton.icon(
                icon: Icon(CarbonIcons.time),
                onPressed: () {
                  openTimePickerDaily(context);
                },
                label: Text("$dailyRemainder"))),
       
      ],
    );
  }
}

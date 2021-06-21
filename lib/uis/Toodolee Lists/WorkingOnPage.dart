import 'package:flutter/material.dart';
import 'package:toodo/uis/Completed%20Lists/completedListUi.dart';
import 'package:toodo/uis/Streak/streakListUi.dart';
import 'package:toodo/uis/bored.dart';
import 'package:toodo/uis/quotes.dart';

import '../progressbar.dart';
import 'listui.dart';

class WorkingOnPage extends StatefulWidget {
  @override
  _WorkingOnPageState createState() => _WorkingOnPageState();
}

class _WorkingOnPageState extends State<WorkingOnPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ProgressBar(), TodoCard()],
    );
  }
}

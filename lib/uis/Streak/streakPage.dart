import 'package:flutter/material.dart';
import 'package:toodo/uis/Completed%20Lists/completedListUi.dart';
import 'package:toodo/uis/Streak/streakListUi.dart';
import 'package:toodo/uis/bored.dart';
import 'package:toodo/uis/quotes.dart';

import '../progressbar.dart';

class StreakPage extends StatefulWidget {
  @override
  _StreakPageState createState() => _StreakPageState();
}

class _StreakPageState extends State<StreakPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ProgressBar(), StreakCard()],
    );
  }
}

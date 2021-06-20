import 'package:flutter/material.dart';
import 'package:toodo/uis/Completed%20Lists/completedListUi.dart';
import 'package:toodo/uis/Streak/streakCompletedUi.dart';
import 'package:toodo/uis/Streak/streakListUi.dart';
import 'package:toodo/uis/bored.dart';
import 'package:toodo/uis/quotes.dart';

import '../progressbar.dart';

class CompletedPage extends StatefulWidget {
  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ProgressBar(), CompletedTodoCard(), CompletedStreakCard()],
    );
  }
}

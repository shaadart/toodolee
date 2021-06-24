import 'package:flutter/material.dart';
import 'package:toodo/uis/Streak/streakListUi.dart';

import '../../main.dart';
import '../addTodoBottomSheet.dart';
import '../progressbar.dart';

/* 
Shows when the chip is clicked of streaks, 
This is the Page of Streaks, 
Whenever something is done related to streaks, it is shown in this page, 
This has the PRogressBar (shows Only when everything is less than or equal to zero) i.e StreakBox, CompletedTodoBox and TodoBox.
*/

class StreakPage extends StatefulWidget {
  @override
  _StreakPageState createState() => _StreakPageState();
}

class _StreakPageState extends State<StreakPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (streakBox.length <= 0 &&
            completedBox.length <= 0 &&
            todoBox.length <= 0)
          Container()
        else
          ProgressBar(),
        StreakCard() // showing the Streaks that are there in the box, (completed or incompleted, anything)
      ],
    );
  }
}

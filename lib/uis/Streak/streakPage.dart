import 'package:flutter/material.dart';
import 'package:toodo/uis/Streak/streakListUi.dart';


import '../../main.dart';
import '../addTodoBottomSheet.dart';
import '../progressbar.dart';

class StreakPage extends StatefulWidget {
  @override
  _StreakPageState createState() => _StreakPageState();
}

class _StreakPageState extends State<StreakPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        streakBox.length <= 0 && completedBox.length <= 0 && todoBox.length <= 0
            ? Container()
            : ProgressBar(),
        StreakCard()
      ],
    );
  }
}

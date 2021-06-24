import 'package:flutter/material.dart';
import '../../main.dart';
import '../addTodoBottomSheet.dart';
import '../progressbar.dart';
import 'listui.dart';

/* 
Shows when the chip is clicked of working on, 
This is the Page of WorkingOnPage, 
This has the PRogressBar (shows Only when everything is less than or equal to zero) i.e StreakBox, CompletedTodoBox and TodoBox.
*/
class WorkingOnPage extends StatefulWidget {
  @override
  _WorkingOnPageState createState() => _WorkingOnPageState();
}

class _WorkingOnPageState extends State<WorkingOnPage> {
  @override
  Widget build(BuildContext context) {
    var streakBox2 = streakBox;
    return Column(
      children: [
        if (streakBox2.length <= 0 &&
            completedBox.length <= 0 &&
            todoBox.length <= 0)
          Container()
        else
          ProgressBar(), 
        TodoCard() // We are showing all the Todos In this Page (incompleted Ones)
      ],
    );
  }
}

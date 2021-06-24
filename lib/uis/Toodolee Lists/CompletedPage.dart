import 'package:flutter/material.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import '../../main.dart';
import '../progressbar.dart';
import 'completedListUi.dart';

/* 
Shows when the chip is clicked of completed, 
This is the Page of CompletedPage, 
Whenever something is done, it is shown in this page, 
This has the PRogressBar (shows Only when everything is less than or equal to zero) i.e StreakBox, CompletedTodoBox and TodoBox.
*/
class CompletedPage extends StatefulWidget {
  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // if the body has no streaks, completed items or incompleted items then show no ProgressBar, 
          //progressbar is the circular chart that shows how much is completed or incompleted at the top, you have seen it) 
          //(check progress bar #WellCommented with ctrl + click)
          child: streakBox.length <= 0 &&
                  completedBox.length <= 0 &&
                  todoBox.length <= 0
              ? Container()
              : ProgressBar(),
        ),
        CompletedTodoCard() // We are showing all the Todos In this Page (completed Ones)
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../main.dart';
import '../addTodoBottomSheet.dart';
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
      children: [
        streakBox.length <= 0 && completedBox.length <= 0 && todoBox.length <= 0
            ? Container()
            : ProgressBar(),
        TodoCard()
      ],
    );
  }
}

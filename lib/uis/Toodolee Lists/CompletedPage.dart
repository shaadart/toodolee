import 'package:flutter/material.dart';

import 'package:toodo/uis/Streak/streakListUi.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:toodo/uis/bored.dart';
import 'package:toodo/uis/quotes.dart';

import '../../main.dart';
import '../progressbar.dart';
import 'completedListUi.dart';

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
          child: streakBox.length <= 0 &&
                  completedBox.length <= 0 &&
                  todoBox.length <= 0
              ? Container()
              : ProgressBar(),
        ),
        CompletedTodoCard()
      ],
    );
  }
}

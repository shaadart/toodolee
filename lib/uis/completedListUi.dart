import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toodo/main.dart';
import 'package:toodo/models/todo_model.dart';
import 'package:share/share.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:carbon_icons/carbon_icons.dart';

class CompletedTodoCard extends StatefulWidget {
  const CompletedTodoCard({
    Key key,
  }) : super(key: key);

  @override
  _CompletedTodoCard createState() => _CompletedTodoCard();
}

class _CompletedTodoCard extends State<CompletedTodoCard> {
  //bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<TodoModel>(todoBoxname).listenable(),
        builder: (context, Box<TodoModel> box, _) {
          List<int> keys = box.keys.cast<int>().toList();

          if (todoBox.isEmpty == true) {
            return Align(
                alignment: Alignment.center,
                child: Text(
                  'No Todo Completed',
                  style: TextStyle(color: Colors.black26),
                ));
          } else {
            return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    //itemCount: box.length,// editing a bit
                    itemCount: box.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, index) => Container(),
                    itemBuilder: (_, index) {
                      final int key = keys[index];
                      final TodoModel modifiedtodo = box.get(key);
                      //todo.isCompleted = false;
                      return Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {},
                            icon: Icon(CarbonIcons.checkbox_checked_filled),
                          ),
                          title: Text("${modifiedtodo.todoName}"),
                        ),
                      );
                    }));
          }
        });
  }
}

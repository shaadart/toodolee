import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:toodo/uis/more_options_lists.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Wrap(
        children: [
          ListTile(
            leading:
                IconButton(icon: Icon(CarbonIcons.checkbox), onPressed: () {}),
            title: Text("Ride the Cycle, wooo!"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(66.0, 0, 30, 0),
            child: Text(
              'Greyhound divisively hello coldly wonderfully marginally far upon excluding. Greyhound divisively hello coldly wonderfully marginally far upon excluding, ',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            children: [
              Text("4 am"),
              Text(
                "•",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "😃",
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: () {
                  listMoreOptions(context);
                },
                icon: Icon(CarbonIcons.overflow_menu_vertical),
              ),
            ],
          )
        ],
      ),
    );
  }
}

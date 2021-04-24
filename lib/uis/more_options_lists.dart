import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';

void listMoreOptions(context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    shape: RoundedRectangleBorder(
      // <-- for border radius
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    builder: (context) {
      // Using Wrap makes the bottom sheet height the height of the content.
      // Otherwise, the height will be half the height of the screen.
      return Wrap(
        children: [
          FlatButton(
            onPressed: () {},
            child: ListTile(
              leading: Icon(CarbonIcons.edit),
              title: Text("Edit"),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              leading: Icon(CarbonIcons.share),
              title: Text("Share"),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              leading: Icon(CarbonIcons.download),
              title: Text("Download"),
            ),
          ),
          Divider(),
          FlatButton(
            onPressed: () {},
            child: ListTile(
              leading: Icon(CarbonIcons.delete, color: Colors.redAccent),
              title: Text(
                "Delete",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      );
    },
  );
}

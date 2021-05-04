import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:toodo/pages/more.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackGroundTile(
        backgroundColor: Colors.orangeAccent.withOpacity(0.6),
        icondata: Icons.check);
  }
}

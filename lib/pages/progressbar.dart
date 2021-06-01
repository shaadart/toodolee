import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';

import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toodo/main.dart';

import 'package:toodo/uis/addTodoBottomSheet.dart';
import 'package:toodo/uis/completedListUi.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    Key key,
  }) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double runningTodoCount = todoBox.length.toDouble();
    double completedTodoCount = completedBox.length.toDouble();

    final List<ChartData> chartData = [
      ChartData(
        'Completed Todo',
        completedTodoCount,
      ),
      ChartData(
        'Incompleted Todo',
        runningTodoCount,
      ),
    ];
    return Container(
      margin: EdgeInsets.all(0),
      height: MediaQuery.of(context).size.width / 2.5,
      child: SfCircularChart(
          legend: Legend(
            isVisible: false,
            // Legend title
            title: LegendTitle(
                text: "...",
                alignment: ChartAlignment.near,
                textStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 1,
                )),
          ),
          palette: [Colors.blueAccent[100], Colors.blue[100]],
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
                enableTooltip: true,
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                // Explode the segments on tap
                explode: true,
                explodeIndex: 2)
          ]),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}

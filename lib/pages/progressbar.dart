import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';

import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toodo/main.dart';

import 'package:toodo/uis/addTodoBottomSheet.dart';

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
    if (runningTodoCount == 0 && completedTodoCount == 0) {
      return Card(
        child: Wrap(
          children: [
            ListTile(
              leading: IconButton(
                  icon: Icon(CarbonIcons.hashtag, color: Colors.green),
                  onPressed: () {}),
            ),
            ListTile(title: Text("Write Toodoos to see Your Progress"))
          ],
        ),
      );
    } else {
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
      return Center(
        child: Card(
          child: GradientCard(
            gradient:
                Gradients.buildGradient(Alignment.topRight, Alignment.topLeft, [
              Colors.blue[50],
              Colors.white,
              Colors.blue[50],
              Colors.blue[100],
            ]),
            child: SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  // Legend title
                  title: LegendTitle(
                      text: "Today's Build-up..",
                      alignment: ChartAlignment.center,
                      textStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: MediaQuery.of(context).size.width / 22,
                      )),
                ),
                palette: <Color>[
                  // Colors.amber,
                  Colors.blue,
                  Colors.blueAccent[100],
                ],
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                      enableTooltip: true,
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      // Explode the segments on tap
                      explode: true,
                      explodeIndex: 1)
                ]),
          ),
        ),
      );
    }
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toodo/main.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';

TooltipBehavior _tooltipBehavior;

ValueNotifier<int> todoBoxLength = ValueNotifier(todoBox.length);

ValueNotifier<int> completedtodoBoxLength =
    ValueNotifier((completedBox.length));

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    Key key,
  }) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("this is completed todoBox value ${completedtodoBoxLength.value}");
    // print("this is todoBox value ${todoBoxLength.value}");

    return MultiValueListenableBuider(
        valueListenables: [todoBox.listenable(), completedBox.listenable()],
        builder: (context, value, child) => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Opacity(
                    opacity: 0.7,
                    child: Text(
                      'My Progress',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize:
                              MediaQuery.of(context).size.shortestSide / 25),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.shortestSide / 35,
                      0,
                      MediaQuery.of(context).size.shortestSide / 35,
                      0),
                  child: Card(
                    elevation: 0.3,
                    //  color: Theme.of(context).colorScheme.onBackground,
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: progressBar(context),
                        ),
                        Container(
                            height: 60,
                            child: VerticalDivider(
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
                        Expanded(
                            flex: 2,
                            child: Center(
                                child: Opacity(
                              opacity: 0.8,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Today's\n",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: "Progress\n \n",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            '${completedBox.length + completedStreakBox.length}/${todoBox.length + completedBox.length + streakBox.length}',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).accentColor,
                                        )),
                                    TextSpan(
                                        text: ' is completed',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          color: Theme.of(context).accentColor,
                                        )),
                                  ],
                                ),
                              ),
                            ))),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}

progressBar(context) {
  double runningTodoCount =
      todoBox.length.toDouble() + streakBox.length.toDouble();
  double completedTodoCount = completedBox.length.toDouble();

  final List<ChartData> chartData = [
    ChartData('Completed Todo', completedTodoCount),
    ChartData('Incompleted Todo', runningTodoCount),
  ];

  return Container(
    margin: EdgeInsets.all(0),
    height: MediaQuery.of(context).size.shortestSide / 2.5,
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

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}

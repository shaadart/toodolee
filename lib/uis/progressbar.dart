import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toodo/main.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:toodo/uis/addTodoBottomSheet.dart';

/*
This is the place where ProgressBar Abides, 
So, It has features like,
# Shows Your RealTime Progress.
# Shows Your Completed Counts
# Real-Animations

*/
  TooltipBehavior _tooltipBehavior; //SF_flutter_charts needs this to activate Tooltip for the charts, (circular or any)

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
// Listening to multiple property at once, so# example listening to toodo count, completed toodo count, streak count,
// This is necessary for building the page in real time as these things will receive some numbers.
// when there will be changes in these components the screen will build again and show real time results.
    return MultiValueListenableBuider(
        valueListenables: [
          todoBox.listenable(),
          completedBox.listenable(),
          streakBox.listenable()
        ],
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
                   
                    child: Row(
                
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: progressBar(context), 
                          // the circular chart, that is rotates to show the profgress in a charti-cal way, 
                          //ctrl + tap the progressbar(context)
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
                                      // Text which is necessary to see, how is your progress going in, in real time.
                                        text:
                                            '${completedBox.length + streakBox.values.where((streak) => streak.isCompleted).toList().length}/${todoBox.length + streakBox.length + completedBox.length}',
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


// This is the Chart, (circular one) it's design and mechannics is provided in here.
progressBar(context) {
  double runningTodoCount =
      todoBox.length.toDouble() + streakBox.length.toDouble();
  double completedTodoCount = completedBox.length.toDouble();

  final List<ChartData> chartData = [
    ChartData('Completed', completedTodoCount),
    ChartData('Incompleted', runningTodoCount),
  ];

  return Container(
    margin: EdgeInsets.all(0),
    height: MediaQuery.of(context).size.shortestSide / 2.5,
    child: SfCircularChart(
       
        palette: [Colors.blueAccent[100], Colors.blue[100]], // Whatever color is added here, shows the colors that are important in the charts?
        tooltipBehavior: _tooltipBehavior, // tooooooltip
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
              enableTooltip: true,
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x, // Don't know :hehe
              yValueMapper: (ChartData data, _) => data.y, // Don't know :hehe
              // Explode the segments on tap
              explode: true,
              explodeIndex: 2)
        ]),
  );
}

class ChartData { // class of chartData.
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}

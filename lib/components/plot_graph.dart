import 'package:jane_ui/components/jane_status.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExPlot extends StatefulWidget {
  ExPlot({Key? key}) : super(key: key);

  @override
  _ExPlotState createState() => _ExPlotState();
}

class _ExPlotState extends State<ExPlot> {
  @override
  Widget build(BuildContext context) {
    final janeStatus = context.watch<JaneStatus>();
    double a = janeStatus.exData[0][0];

    return Container(
      child: LineChart(
        LineChartData(
              minX: -3,
              maxX: 3,
              minY: -3,
              maxY: 3,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(1, 1),
                    FlSpot(0, 0),
                    FlSpot(a, -2)]

                )
              ]
        )
      )
    );
  }
  
}



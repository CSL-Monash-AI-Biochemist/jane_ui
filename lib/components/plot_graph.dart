import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartW extends StatelessWidget {
  const LineChartW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LineChart(
    LineChartData(
      minX: -3,
      maxX: 3,
      minY: -3,
      maxY: 3,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, 1),
            FlSpot(0, 0)]

        )
      ]
    )
    
  );
}
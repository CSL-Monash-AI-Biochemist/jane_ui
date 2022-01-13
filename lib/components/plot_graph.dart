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
    
    List<FlSpot> plotData = array2FlSpot(janeStatus.exData);

    return Container(
      child: LineChart(
        LineChartData(
              minX: 0,
              maxX: 25,
              // minY: 0,
              // maxY: 1,
              lineBarsData: [
                LineChartBarData(
                  spots: plotData,
                  isCurved: true
                )
              ]
              
        )
      )
    );
  }
  
}

List<FlSpot> array2FlSpot(var array)
{
  List<double> ts = [];
  List<double> edata = [];
  List<FlSpot> flspot = [];
  array.asMap().forEach((i, row){
    row.asMap().forEach((j, val){
      if (i == 0) ts.add(val);
      else        edata.add(val);
    });
  });

  for (var i=0; i<ts.length; i++)
  {
    flspot.add(FlSpot(ts[i], edata[i]));
  }

  return flspot;
}


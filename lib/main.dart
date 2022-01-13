import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jane_ui/components/jane_status.dart';
import 'package:jane_ui/components/message_box.dart';
import 'package:jane_ui/components/control_bar.dart';
import 'package:jane_ui/components/plot_graph.dart';
import 'package:provider/provider.dart';

void main() => runApp(const JaneUI());

class JaneUI extends StatelessWidget {
  const JaneUI({Key? key}) : super(key: key);

  final String value = 'hihihihihihi';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Jane Command Centre'),
            ),
        body: JaneParent()
        )
    );
  }
}

class JaneParent extends StatelessWidget {
  JaneParent({Key? key}) : super(key: key);

  String value = 'oh yes';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JaneStatus('idle', [[0, 0], [1, 1]]),
      child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // buttons and dropdown menu
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: ControlBar(),
                    ),
                  ),

                  // display experiment status
                  Expanded(
                    flex: 1,
                    child: Text(value),
                  ),

                  // terminal-like message box
                  msgBox(value: value),
                ],
              )
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(50),
                child: ExPlot()
                )
              
            )
          ],
        ),
    );
  }
}
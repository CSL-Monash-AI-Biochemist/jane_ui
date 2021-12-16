import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jane_ui/components/message_box.dart';
import 'package:jane_ui/components/control_bar.dart';

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
        body: Row(
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
                      child: controlBar(),
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
            const Expanded(
              flex: 3,
              child: Text('plot here')
            )
          ],
        )
        )
    );
  }
}

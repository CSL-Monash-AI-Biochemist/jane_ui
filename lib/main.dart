import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jane_ui/components/message_box.dart';

void main() => runApp(const JaneUI());

class JaneUI extends StatelessWidget {
  const JaneUI({Key? key}) : super(key: key);

  final String value = 'hihihihihihi';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Jane UI'),
            ),
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('hello word'),
                    ),
                  ),
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

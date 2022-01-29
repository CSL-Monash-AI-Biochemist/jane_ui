import 'package:flutter/material.dart';
import 'package:jane_ui/components/jane_status.dart';
import 'package:jane_ui/components/message_box.dart';
import 'package:jane_ui/components/control_bar.dart';
import 'package:jane_ui/components/plot_graph.dart';
import 'package:provider/provider.dart';
import 'package:jane_ui/components/plot_selector.dart';

void main() => runApp(JaneUI());

class JaneUI extends StatelessWidget {
  JaneUI({Key? key}) : super(key: key);

  final String value = 'hihihihihihi';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Jane Command Centre', 
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
            ),
        ),
        body: JaneParent()
      )
    );
  }
}

class JaneParent extends StatelessWidget {
  JaneParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JaneStatus('idle', [[0.0, 0.0], [1.2, 1.0]], {1: [[0.0, 0.0], [1.2, 1.0]]}),
      
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
            
                  MsgBox(), // terminal-like message box
                ],
              )
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    const Text("Sample standard",
                      style: TextStyle(fontSize: 20),),
                    const Padding(padding: EdgeInsets.all(5)),
                    Expanded(
                      flex: 5,
                      child: ExPlot(dataSrc: 'ref')),

                    const Padding(padding: EdgeInsets.all(10)),
                    const Text("Time [min]"),
                    const Padding(padding: EdgeInsets.all(20)),

                    Expanded(
                      flex: 1,
                      child: PlotSelector()),

                    Expanded(
                      flex: 5,
                      child: ExPlot(dataSrc: 'src')),
                    const Padding(padding: EdgeInsets.all(10)),
                    const Text("Time [min]")
                  ],
                )
              )
            )
          ],
        ),
    );
  }
}
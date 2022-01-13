import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jane_ui/backend.dart';
import 'package:jane_ui/components/jane_status.dart';
import 'package:provider/provider.dart';

class ControlBar extends StatefulWidget {
  ControlBar({Key? key}) : super(key: key);

  @override
  _ControlBarState createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  String dropdownItem = 'Experiment A';
  double counter = 0;

  @override
  Widget build(BuildContext context) {

    final janeStatus = context.watch<JaneStatus>();

    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(left: 20)),
        
        FloatingActionButton.extended(
          onPressed: () async {
            await updateExperimentState();
            
            janeStatus.updateExState(janeStatusJSON['experiment']!['state'].toString());

            var receivedData = await getExperimentData();
            var experimentData = jsonDecode(receivedData);

            // testing only, will remove later
            counter += 0.1;
            experimentData[0][0] += counter;
            janeStatus.updateExData(experimentData);
            janeStatus.updateConsoleMsg('adding more msg');
          },
          label: const Text(
            'Start',
            style: TextStyle(
              fontSize: 22
            ),),
        ),
        
        const Padding(padding: EdgeInsets.only(left: 40)),

        DropdownButton<String>(
          value: dropdownItem,
          items: <String>['Experiment A', 'Experiment B']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownItem = newValue!;
            });
          },
        ),

        const Padding(padding: EdgeInsets.only(left: 40)),

        Text(
          'Status: ' + janeStatus.exState,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green[400]
          ),
        )
      ],
    );
  }
}

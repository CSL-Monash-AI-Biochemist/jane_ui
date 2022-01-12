import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jane_ui/backend.dart';

class controlBar extends StatefulWidget {
  controlBar({Key? key}) : super(key: key);

  @override
  _controlBarState createState() => _controlBarState();
}

class _controlBarState extends State<controlBar> {
  String dropdownItem = 'Experiment A';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(left: 20)),
        
        FloatingActionButton.extended(
          onPressed: () async {
            await updateExperimentState();
            
            var receivedData = await getExperimentData();
            var experimentData = jsonDecode(receivedData);
            
          },
          label: const Text('start'),
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
      ],
    );
  }
}

import 'package:flutter/material.dart';

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
        FloatingActionButton.extended(
          onPressed: ()
          {

          },
          label: const Text('start'),
        ),

        DropdownButton<String>(
          value: dropdownItem,
          items: <String>['Experiment A', 'Experiment B']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue)
          {
            setState(() {
              dropdownItem = newValue!;
            });
          }, 
        ),

        Text('2'),
      ],
    );
  }
}


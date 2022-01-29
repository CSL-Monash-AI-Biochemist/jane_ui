import 'package:flutter/material.dart';

class plotSelector extends StatefulWidget {
  plotSelector({Key? key}) : super(key: key);

  @override
  State<plotSelector> createState() => _plotSelectorState();
}

class _plotSelectorState extends State<plotSelector> {
  String dropdownItem = 'No sample data yet';
  String sampleQuality = 'N/A';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: dropdownItem,
          items: <String>['Experiment A', 'Experiment B', 'No sample data yet']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 20),),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownItem = newValue!;
            });
          },
        ),
        const Padding(padding: EdgeInsets.all(5)),
        Text(': ' + sampleQuality, 
          style: const TextStyle(
            fontSize: 20,
            color: Colors.redAccent,
          ),
          )
      ],
    );
  }
}
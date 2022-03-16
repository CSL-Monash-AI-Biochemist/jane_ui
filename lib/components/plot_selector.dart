import 'package:flutter/material.dart';
import 'package:jane_ui/components/jane_status.dart';
import 'package:provider/provider.dart';

class PlotSelector extends StatefulWidget {
  PlotSelector({Key? key}) : super(key: key);

  @override
  State<PlotSelector> createState() => _PlotSelectorState();
}

class _PlotSelectorState extends State<PlotSelector> {
  String dropdownItem = 'No';
  String sampleQuality = 'N/A';

  @override
  Widget build(BuildContext context) {
    final janeStatus = context.watch<JaneStatus>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: janeStatus.selectedSample[0],
          items: janeStatus.sampleSelectList
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 20),),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              // janeStatus.updateSelectedSample(int.parse(newValue!.substring(7)));
              janeStatus.selectSampleToPlot(newValue!);
            });
          },
        ),
        const Padding(padding: EdgeInsets.all(5)),
        Text(': ' + janeStatus.selectedSample[1], 
          style: const TextStyle(
            fontSize: 20,
            color: Colors.redAccent,
          ),
          )
      ],
    );
  }
}
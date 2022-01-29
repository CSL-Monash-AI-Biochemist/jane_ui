import 'dart:async';
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
    int nSamplePrev = -1;

    // update GUI - interface with backend server 
    void _updateGUI() async {
      if (janeStatus.exState == 'idle') {
        janeStatus.updateExState('starting');
        await updateExperimentState('starting');
        janeStatus.updateConsoleMsg('Started experiment');
      }

      Timer.periodic(const Duration(seconds: 1), (_timer) async {
        int nSample = await getNoOfSample();
        janeStatus.updateNumOfSample(nSample);
        var state = await getExperimentState();
        janeStatus.updateExState(state);

        if (nSample == 0) {
          var refData = await getReferenceData();
          janeStatus.updateRefData(refData);
        }
        else if (nSample > 0 && nSample != nSamplePrev) {
          var exData = await getExperimentData();
          String sampleQuality = await getSampleQuality();      
          
          janeStatus.updateExData(nSample, exData);
          janeStatus.updateSampleQuality(nSample, sampleQuality);
          janeStatus.updateConsoleMsg(
            'Finished testing Sample ' + nSample.toString() + '. Sample quality: ' + sampleQuality);
        }

        janeStatus.updateConsoleMsg('nSample: ' + nSample.toString() + ' prev: ' + nSamplePrev.toString() + ' state:' + state);


        nSamplePrev = nSample;
        // if (nSample == 3) {
        //   _timer.cancel();
        // }
        
      });

    }
    



    // return widgets
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(left: 20)),
        FloatingActionButton.extended(
          onPressed: () async {
            _updateGUI();
          },
          label: const Text(
            'Start',
            style: TextStyle(fontSize: 22),
          ),
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
          'Status: ' + _getStatusDisplay(janeStatus.exState),
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green[400]),
        )
      ],
    );
  }

  String _getStatusDisplay(String state)
  {
    String output = '';
    if (state == 'idle') {
      output = 'idle';
    }
    else if (state == 'starting') {
      output = 'starting';
    }
    else if (state == 'standard') {
      output = 'running standard';
    }
    else if (state == 'sample') {
      output = 'running samples';
    }
    else if (state == 'complete') {
      output = 'complete';
    }

    return output;
  }
}

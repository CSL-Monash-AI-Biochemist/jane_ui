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
    bool printed = false;

    // update GUI - interface with backend server 
    void _updateGUI() async {
      bool showTimeHeader = false;
      String msgTimeHeader = showTimeHeader ? '[' + DateTime.now().toString() + '] ' : '';

      if (janeStatus.exState == 'idle') {
        janeStatus.updateExState('jane_moving');
        await updateExperimentState('jane_moving');
        janeStatus.updateConsoleMsg(msgTimeHeader +'Started experiment');
        janeStatus.updateConsoleMsg(msgTimeHeader +'Jane is transferring sample to the Spinnaker');
      }

      Timer.periodic(const Duration(milliseconds: 500), (_timer) async {
        int nSample = await getNoOfSample();
        janeStatus.updateNumOfSample(nSample);
        var state = await getExperimentState();
        janeStatus.updateExState(state);

        if (nSample != nSamplePrev) {
          if (nSample == 0) {
            var refData = await getReferenceData();
            janeStatus.updateRefData(refData);
            janeStatus.updateConsoleMsg(msgTimeHeader +'Received data for test standard');
            printed = false;
          }
          else if (nSample == 1) {
            var exData = await getExperimentData();
            String sampleQuality = await getSampleQuality();      
            
            janeStatus.updateExData(nSample, exData);
            janeStatus.updateSampleQuality(nSample, sampleQuality);
            janeStatus.updateSelectedSample(nSample);
            janeStatus.updateConsoleMsg(msgTimeHeader +
              'Finished testing sample ===> quality: ' + sampleQuality);
            printed = false;
          }
          else if (nSample == 2) {  // retest sample
            var exData = await getExperimentData();
            String sampleQuality = await getSampleQuality();      
            
            janeStatus.updateExData(nSample, exData);
            janeStatus.updateSampleQuality(nSample, sampleQuality);
            janeStatus.updateSelectedSample(nSample);
            janeStatus.updateConsoleMsg(msgTimeHeader +
              'Finished retesting sample ===> quality: ' + sampleQuality);
            
            printed = false;
          }
          else if (nSample == 3) {  // retest standard
            var exData = await getExperimentData();
            String sampleQuality = await getSampleQuality();      
            
            janeStatus.updateExData(nSample, exData);
            janeStatus.updateSampleQuality(nSample, sampleQuality);
            janeStatus.updateSelectedSample(nSample);

            if (sampleQuality == 'Good IgG') {
              janeStatus.updateConsoleMsg(msgTimeHeader +
                'Finished retesting standard\nTest standard quality is normal\nAbnormality confirmed');
                janeStatus.updateConsoleMsg(msgTimeHeader + 'Jane has completed test sequence!');
                janeStatus.updateConsoleMsg(msgTimeHeader + 'Transferring plate back to storage');
            }
            else {
              janeStatus.updateConsoleMsg(msgTimeHeader +
                'Finished retesting standard. Test standard quality is abnormal, please check the quality of the column!');              
            }
            printed = false;
          }

          
        }

        nSamplePrev = nSample;

        if (state == 'jane_idle' && !printed) {
          janeStatus.updateConsoleMsg(msgTimeHeader + 'Spinnaker is transferring sample to the Vanquish HPLC');
          printed = true;
        }
        else if (state == 'standard' && !printed) {
          janeStatus.updateConsoleMsg(msgTimeHeader + 'Running test standard...');
          printed = true;
        }
        // else if (state == 'sample_retest' && !printed) {
        //   janeStatus.updateConsoleMsg(msgTimeHeader + 'Retesting sample...');
        //   printed = true;
        // }
        // else if (state == 'standard_retest' && !printed) {
        //   janeStatus.updateConsoleMsg(msgTimeHeader + 'Retesting standard...');
        //   printed = true;
        // }
        else if (state == 'complete' && !printed) {
          await updateExperimentState('idle');

          printed = true;
          //_timer.cancel();
        }
        
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
            style: TextStyle(fontSize: 30),
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
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.green[400]),
        ),

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
    else if (state == 'jane_moving') {
      output = 'plate transfer - Jane';
    }
    else if (state == 'jane_idle') {
      output = 'plate transfer - Spinnaker';
    }
    else if (state == 'standard') {
      output = 'running standard';
    }
    else if (state == 'sample') {
      output = 'testing sample';
    }
    else if (state == 'sample_retest') {
      output = 'retesting sample';
    }
    else if (state == 'standard_retest') {
      output = 'retesting standard';
    }
    else if (state == 'complete') {
      output = 'complete';
    }

    return output;
  }
}

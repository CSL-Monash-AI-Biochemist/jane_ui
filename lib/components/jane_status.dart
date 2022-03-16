import 'package:flutter/material.dart';

class JaneStatus extends ChangeNotifier {
  // class variables
  String _experimentState = '';
  var _experimentData = {1:[]};
  List<dynamic> _experimentData2Plot = [];
  List<dynamic> _referenceData = [];
  String _consoleMsg = '';
  List<String> _prevConsoleMsg = [''];
  List<String> _sampleQuality = ['']; // sample no starts from one 
  int _nSample = -1;
  List<String> _sampleSelectList = ['No sample data yet'];
  List<String> _selectedSample = ['No sample data yet', 'N/A'];

  // getter
  String get exState => _experimentState;
  // exData(int sampleNo) => _experimentData[sampleNo];
  List<dynamic> get exData2Plot => _experimentData2Plot;
  List<dynamic> get refData => _referenceData;
  String get consoleMsg => _consoleMsg;
  sampleQuality(int sampleNo) => _sampleQuality[sampleNo + 1];  
  int get nSample => _nSample;
  List<String> get sampleSelectList => _sampleSelectList;
  List<String> get selectedSample => _selectedSample;

  // constructor
  JaneStatus(this._experimentState, this._referenceData, this._experimentData2Plot);

  void selectSampleToPlot(String sample) {
    _selectedSample[0] = sample;

    int sampleNo = 0;

    if (sample == "Sample") {
      sampleNo = 0;
    }
    else if (sample == "Retested sample") {
      sampleNo = 1;
    }
    else if (sample == "Retested standard") {
      sampleNo = 2;
    }

    _experimentData2Plot = _experimentData[sampleNo]!;
    _selectedSample[1] = _sampleQuality[sampleNo];
    notifyListeners();
  }

  void updateSelectedSample(int sampleNo) {
    // _selectedSample: 0 => sample name, 1 => sample quality 
    String sampleName = '';

    if (sampleNo == 1) {
      _sampleSelectList[0] = 'Sample';
      _selectedSample[0] = 'Sample';
    }
    else if (sampleNo > _sampleSelectList.length) {
      if (sampleNo == 2) {
        sampleName = 'Retested sample';
      }
      else if (sampleNo == 3) {
        sampleName = 'Retested standard';
      }
      _sampleSelectList.add(sampleName);
      _selectedSample[0] = sampleName;

    }
    else {
      if (sampleNo == 1) {
        sampleName = 'Sample';
      }
      else if (sampleNo == 2) {
        sampleName = 'Retested sample';
      }
      else if (sampleNo == 3) {
        sampleName = 'Retested standard';
      }  
      _selectedSample[0] = sampleName;

    }

    _experimentData2Plot = _experimentData[sampleNo]!;
    _selectedSample[1] = _sampleQuality[sampleNo - 1];

    notifyListeners();
  }

  void updateConsoleMsg(String msg) {

    bool alreadyHasMsg = false;
    for (var prevMsg in _prevConsoleMsg) {
      if (msg == prevMsg) {
        alreadyHasMsg = true;
      }      
    }

    if (!alreadyHasMsg) {
      _consoleMsg += '\n' + msg;
    }

    _prevConsoleMsg.add(msg);
    notifyListeners();
  }

  void updateExState(String state) {
    _experimentState = state;
    notifyListeners();
  }

  void updateExData(int sampleNo, List<dynamic> data) {
    _experimentData[sampleNo] = data;
    notifyListeners();
  }

  void updateRefData(List<dynamic> data) {
    _referenceData = data;
    notifyListeners();
  }

  void updateSampleQuality(int sampleNo, String quality) {
    if (_nSample == 1) {
      _sampleQuality[0] = quality;
    }
    else if (sampleNo > _sampleQuality.length) {
      _sampleQuality.add(quality);
    }
    else {
      _sampleQuality[sampleNo - 1] = quality;
    }
    notifyListeners();
  }

  void updateNumOfSample(int nSample) {
    _nSample = nSample;
    notifyListeners();
  }
}

// useful tutorial on ChangeNotifier
// https://www.youtube.com/watch?v=NeAMD0lQ5jw&ab_channel=FunwithFlutter
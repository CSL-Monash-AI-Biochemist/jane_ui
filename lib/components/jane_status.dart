import 'package:flutter/material.dart';

class JaneStatus extends ChangeNotifier {
  // class variables
  String _experimentState = '';
  var _experimentData = {1:[]};
  List<dynamic> _referenceData = [];
  String _consoleMsg = '';
  List<String> _sampleQuality = ['']; // sample no starts from one 
  int _nSample = -1;

  // getter
  String get exState => _experimentState;
  exData(int sampleNo) => _experimentData[sampleNo];
  List<dynamic> get refData => _referenceData;
  String get consoleMsg => _consoleMsg;
  sampleQuality(int sampleNo) => _sampleQuality[sampleNo + 1];  
  int get nSample => _nSample;

  // constructor
  JaneStatus(this._experimentState, this._referenceData, this._experimentData);

  void updateConsoleMsg(String msg) {
    _consoleMsg += '\n' + msg;
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
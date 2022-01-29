import 'package:flutter/material.dart';

class JaneStatus extends ChangeNotifier {
  // class variables
  String _experimentState = '';
  var _experimentData = {1:[]};
  List<dynamic> _referenceData = [];
  String _consoleMsg = '';
  String _sampleQuality = '';

  // getter
  String get exState => _experimentState;
  exData(int sampleNo) => _experimentData[sampleNo];
  List<dynamic> get refData => _referenceData;
  String get consoleMsg => _consoleMsg;
  String get sampleQuality => _sampleQuality;

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

  void updateSampleQuality(String quality) {
    _sampleQuality = quality;
    notifyListeners();
  }
}

// useful tutorial on ChangeNotifier
// https://www.youtube.com/watch?v=NeAMD0lQ5jw&ab_channel=FunwithFlutter
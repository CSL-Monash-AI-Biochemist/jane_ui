import 'package:flutter/material.dart';

class JaneStatus extends ChangeNotifier {
  String _experimentState = 'Hello World';
  List<dynamic> _experimentData = [
    [0, 0],
    [1, 1]
  ];
  List<dynamic> _referenceData = [
    [0, 0],
    [1, 1]
  ];
  String _consoleMsg = 'Hello World';
  String _sampleQuality = 'N/A';

  // getter
  String get exState => _experimentState;
  List<dynamic> get refData => _referenceData;
  List<dynamic> get exData => _experimentData;
  String get consoleMsg => _consoleMsg;
  String get sampleQuality => _sampleQuality;

  JaneStatus(this._experimentState, this._experimentData, this._referenceData);

  void updateConsoleMsg(String msg) {
    _consoleMsg += '\n' + msg;
  }

  void updateExState(String state) {
    _experimentState = state;
    notifyListeners();
  }

  void updateExData(List<dynamic> data) {
    _experimentData = data;
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
import 'package:flutter/material.dart';

class JaneStatus extends ChangeNotifier {
  String _experimentState = 'Hello World';
  List<dynamic> _experimentData = []; 

  // getter
  String get exState => _experimentState;
  List<dynamic> get exData => _experimentData;

  JaneStatus(this._experimentState, this._experimentData);

  void updateExState(String state) {
    _experimentState = state;
    notifyListeners();
  }

  void updateExData(List<dynamic> data) {
    _experimentData = data;
    notifyListeners();
  }
}

// useful tutorial on ChangeNotifier
// https://www.youtube.com/watch?v=NeAMD0lQ5jw&ab_channel=FunwithFlutter
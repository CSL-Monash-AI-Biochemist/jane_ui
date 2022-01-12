import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'http://127.0.0.1:5000/';
var janeStatus = {
  'experiment': {'state': 'idle', 'data': []}
};

updateExperimentState() async {
  if (janeStatus['experiment']!['state'] == 'idle') {
    janeStatus['experiment']!['state'] = 'running1';
  }

  http.Response response = await http.post(
    Uri.parse(baseUrl + 'experiment'),
    body: json.encode(janeStatus['experiment']!['state']));
    
  return response.body;
}

getExperimentData() async {
  http.Response response = await http.get(
    Uri.parse(baseUrl + 'experiment/data')
  );

  return response.body;
}
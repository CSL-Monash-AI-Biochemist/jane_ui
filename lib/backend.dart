import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'http://127.0.0.1:5000/';
var janeStatus = {
  'experiment': {'state': 'idle', 'data': []}
};

updateExperimentStatus() async {
  if (janeStatus['experiment']!['state'] == 'idle') {
    janeStatus['experiment']!['state'] = 'running';
  }

  http.Response response = await http.post(
    Uri.parse(baseUrl + 'experiment'),
    body: json.encode(janeStatus['experiment']));
    
  return response.body;
}

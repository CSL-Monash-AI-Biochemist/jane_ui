import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'http://127.0.0.1:5000/';
var janeStatusJSON = {
  'experiment': {
    'state': 'idle', 
    'data_ref': [],
    'data_src': []}
};

updateExperimentState() async {
  if (janeStatusJSON['experiment']!['state'] == 'idle') {
    janeStatusJSON['experiment']!['state'] = 'running';
  }

  http.Response response = await http.post(
    Uri.parse(baseUrl + 'experiment/state'),
    body: json.encode(janeStatusJSON['experiment']!['state']));
    
  return response.body;
}

getExperimentState() async {
  http.Response response = await http.get(
    Uri.parse(baseUrl + 'experiment/state')
  );

  return response.body;
}

getExperimentData() async {
  http.Response response = await http.get(
    Uri.parse(baseUrl + 'experiment/data/src')
  );

  return jsonDecode(response.body);
}

getReferenceData() async {
  http.Response response = await http.get(
    Uri.parse(baseUrl + 'experiment/data/ref')
  );

  return jsonDecode(response.body);
}
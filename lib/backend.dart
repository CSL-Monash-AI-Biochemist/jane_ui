import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'http://127.0.0.1:5000/';

updateExperimentState(String state) async {
  http.Response response = await http.post(
    Uri.parse(baseUrl + 'experiment/state'),
    body: json.encode(state));
    
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

getSampleQuality() async {
  http.Response response = await http.get(
    Uri.parse(baseUrl + 'experiment/data/quality')
  );

  return response.body;
}

getNoOfSample() async {
  http.Response response = await http.get(
    Uri.parse(baseUrl + 'experiment/n_sample')
  );

  return int.parse(response.body);
}
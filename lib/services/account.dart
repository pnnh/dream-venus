import 'dart:convert';

import 'package:http/http.dart' as http;

void doLogin(String account, String token) async {
  var url = Uri.parse('http://localhost:8080/account/login');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'account': account, 'token': token}));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  var access_token = decodedResponse['access_token'];
  print('status: $access_token');
}

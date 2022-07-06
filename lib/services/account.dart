import 'dart:convert';

import 'package:dream/services/store/isar.dart';
import 'package:http/http.dart' as http;

Future<bool> doLogin(String account, String token) async {
  var url = Uri.parse('http://localhost:8080/account/login');
  var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'account': account, 'code': token}));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  var accessToken = decodedResponse['access_token'];
  print('status: $accessToken');
  await IsarStore.insertAuthorization(accessToken);
  return true;
}

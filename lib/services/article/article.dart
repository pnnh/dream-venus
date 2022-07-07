import 'dart:convert';

import 'package:dream/services/store/isar.dart';
import 'package:http/http.dart' as http;

Future<bool> postArticleCreate(String title, String body,
    {bool publish = false}) async {
  var auth = await IsarStore.findAuthorization();
  if (auth == null) {
    return false;
  }
  var url = Uri.parse('http://localhost:8080/article/create');
  var response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "${auth.tokenType} ${auth.accessToken}"
      },
      body: jsonEncode({'title': title, 'body': body, "publish": publish}));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  var pk = decodedResponse['pk'];
  print('status: $pk');
  return true;
}

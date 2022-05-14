import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class Article {
  String content = '';
  int created = 0; // 创建时间，毫秒时间戳

  Article() {
    content = "";
    created = 0;
  }

  Article.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() => {'content': content, 'created': created};
}

Future<List<Article>> loadArticles(int created) async {
  var queryMap = <String, dynamic>{};
  queryMap["created"] = created;

  var queryJsonStr = json.encode(queryMap);

  debugPrint("queryJson $queryJsonStr");

  var config = loadConfig();
  debugPrint("jjjj22 ${config.loadArticlesUrl}");
  var loadUri = Uri.dataFromString(config.loadArticlesUrl);
  var resp = await http.post(loadUri, body: queryJsonStr);

  List<dynamic> data = json.decode(resp.body);
  var result = List.filled(data.length, Article());
  if (resp.statusCode != 200) {
    debugPrint("loadArticles返回错误 ${resp.statusCode}");
    return result;
  }

  for (var element in data) {
    var info = Article();
    info.content = element['data']['content'];
    info.created = element['created'];
    result.add(info);
    debugPrint("jjjj2 ${info.content} ${info.created}");
  }
  return result;
}

Future<void> saveArticle(String content) async {
  if (content == "") return;

  var config = loadConfig();
  debugPrint("jjjj33 ${config.loadArticlesUrl}");

  var article = Article();
  article.content = content;

  var artJson = json.encode(article);

  debugPrint("jjj $artJson");

  var loadUri = Uri.dataFromString(config.saveArticleUrl);
  var resp = await http.post(loadUri, body: artJson);

  debugPrint("cccc $resp");
}

// 将纳秒时间戳转换为友好格式
String formatDateTime(int nanoseconds) {
  var timeStr =
      DateTime.fromMicrosecondsSinceEpoch((nanoseconds / 1000).round())
          .toString();
  return timeStr.substring(0, 16);
}

import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;

class AppConfig {
  String loadArticlesUrl = "/api/query";
  String saveArticleUrl = "/api/add";
  String hostUrl;

  AppConfig({required this.hostUrl}) {
    loadArticlesUrl = hostUrl + loadArticlesUrl;
    saveArticleUrl = hostUrl + saveArticleUrl;
  }
}

var productConfig = AppConfig(hostUrl: "");
var debugConfig = AppConfig(
  hostUrl: "http://localhost:8080",
);

AppConfig loadConfig() {
  const bool inProduction = bool.fromEnvironment("dart.vm.product");
  if (!inProduction) {
    return debugConfig;
  }
  return productConfig;
}

String getResUrl() {
  if (kDebugMode) {
    return "http://127.0.0.1:3000/src/index.tsx";
  }
  return "https://res.sfx.xyz/index.js?v=1";
}

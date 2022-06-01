import 'package:dream/application/web/pages/home.dart';
import 'package:dream/application/web/route.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class WebPage extends Page {
  final WebRoutePath routePath;

  WebPage(
    this.routePath,
  ) : super(name: routePath.uri.toString(), key: ValueKey(routePath));

  @override
  Route createRoute(BuildContext context) {
    return CustomPageRoute(
      (BuildContext context) {
        debugPrint("createRoute ${routePath.uri}");
        return Scaffold(
          body: selectPage(routePath.uri),
        );
      },
      settings: this,
    );
  }
}

Widget selectPage(Uri uri) {
  debugPrint("uri_path ${uri.path}");
  switch (uri.path) {
    case "/login":
      return const LoginWidget();
    default:
      return const HomePageWidget();
  }
}

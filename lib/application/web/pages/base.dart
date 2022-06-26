import 'dart:math';

import 'package:dream/application/web/pages/home/home.dart';
import 'package:dream/application/web/pages/random.dart';
import 'package:dream/application/web/pages/read.dart';
import 'package:dream/application/web/route.dart';
import 'package:flutter/material.dart';

import 'account/login.dart';

class WebPage extends Page {
  final WebRoutePath routePath;

  WebPage(
    this.routePath,
  ) : super(name: routePath.uri.path.toString(), key: ValueKey(routePath));

  @override
  Route createRoute(BuildContext context) {
    return CustomPageRoute(
      (BuildContext context) {
        debugPrint("createRoute ${routePath.uri}");
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  height: max(500, constraints.maxHeight)),
              child: Scaffold(body: selectPage(routePath.uri)), // your column
            );
          },
        );
      },
      settings: this,
    );
  }
}

Widget selectPage(Uri uri) {
  debugPrint("uri_path ${uri.path}");
  switch (uri.path) {
    case "/account/login":
      return const LoginWidget();
    case "/read":
      return const ReadPage();
    case "/random":
      return const RandomPage();
    default:
      return const HomePage();
  }
}

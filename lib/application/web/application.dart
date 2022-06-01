import 'package:flutter/material.dart';

import 'route.dart';

class WebApplication extends StatefulWidget {
  const WebApplication({Key? key}) : super(key: key);

  @override
  _WebApplicationState createState() => _WebApplicationState();
}

class _WebApplicationState extends State<WebApplication> {
  final WebRouterDelegate _routerDelegate = WebRouterDelegate();
  final WebRouteInformationParser _routeInformationParser =
      WebRouteInformationParser();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '网页应用',
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //fontFamily: "WqyMicroHeiLite", // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
        fontFamily: "WqyMicroHeiLite", // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

Future<Widget> initApp() async {
  return WebApplication();
}

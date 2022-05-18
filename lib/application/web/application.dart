import 'package:dream/application/web/pages/home.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '网页应用',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //fontFamily: "WqyMicroHeiLite", // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
        fontFamily: "WqyMicroHeiLite", // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: const HomePageWidget()),
    );
  }
}

Future<void> initApp() async {}

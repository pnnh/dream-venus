import 'package:dream/application/web/pages/home.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '网页应用',
      theme: ThemeData(
        //fontFamily: 'Raleway',
//         textTheme: GoogleFonts.latoTextTheme(
//           Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
//         ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Roboto", // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HomePageWidget()),
    );
  }
}

Future<void> initApp() async {}

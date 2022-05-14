import 'package:dream/application/web/pages/home.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '网页应用',
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HomePageWidget()),
    );
  }
}

Future<void> initApp() async {}



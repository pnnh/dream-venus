import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text(
        "sfx.xyz",
        style: TextStyle(
            color: Colors.black,
            fontFamily: "Cookie",
            fontWeight: FontWeight.w700,
            fontSize: 36),
      ),
      style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
      onPressed: () async {
        const url = "https://www.baidu.com";
        if (await canLaunch(url)) {
          launch(url);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 1024,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () async {
                        const url = "http://127.0.0.1:5500";
                        if (await canLaunch(url)) {
                          launch(url);
                        }
                      },
                      child: const Text(
                        "sfx.xyz",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Cookie",
                            fontWeight: FontWeight.w700,
                            fontSize: 36),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () async {
                        const url = "http://127.0.0.1:5500";
                        if (await canLaunch(url)) {
                          launch(url);
                        }
                      },
                      child: const Text(
                        "文章",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () async {
                        const url = "http://127.0.0.1:1234";
                        if (await canLaunch(url)) {
                          launch(url);
                        }
                      },
                      child: const Text(
                        "实用工具",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () async {
                        const url = "https://www.baidu.com";
                        if (await canLaunch(url)) {
                          launch(url);
                        }
                      },
                      child: const Text(
                        "随机值",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 1024,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [Text("Home")],
              ),
            )
          ],
        )
      ],
    );
  }
}

import 'package:dream/application/web/route.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routerDelegate = WebRouterDelegate.of(context);
    return Container(
        color: Colors.white,
        height: 80,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 1024,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () async {
                        routerDelegate.go("/");
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
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          TextButton(
                            style: ButtonStyle(
                                splashFactory: NoSplash.splashFactory,
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () async {
                              routerDelegate.go("/");
                            },
                            child: const Text(
                              "文章",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                                splashFactory: NoSplash.splashFactory,
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () async {
                              routerDelegate.go("/");
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
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () async {
                              routerDelegate.go("/");
                            },
                            child: const Text(
                              "随机值",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ])),
                    TextButton(
                      style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () async {
                        routerDelegate.go("/login");
                      },
                      child: const Text(
                        "登录",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ]));
  }
}

import 'package:dream/application/web/route.dart';
import 'package:flutter/material.dart';

import 'toolbar.dart';

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
                              routerDelegate.go("/random");
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
                    const ToolbarWidget()
                  ],
                ),
              ),
            ]));
  }
}

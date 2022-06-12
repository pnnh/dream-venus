import 'package:dream/application/web/route.dart';
import 'package:flutter/material.dart';

class ArticleItemWidget extends StatelessWidget {
  final String title;

  const ArticleItemWidget({Key? key, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routerDelegate = WebRouterDelegate.of(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: TextButton(
                style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () async {
                  routerDelegate.go("/read");
                },
                child: Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16))),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                  "$title 本篇将基于Python 3.7+Django 3.0结合Vue.js前端框架，为大家介绍如何基于这三者的技术栈来实现一个前端后离的Web开发项目。为了简化，方便读者理解，本文将以开发一个单体页面应用作为实战演示。",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500))),
          Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text("Larry 2022年2月16号 14:28",
                      style: TextStyle(fontSize: 13, color: Color(0xFF86909C))),
                ],
              ))
        ]);
  }
}

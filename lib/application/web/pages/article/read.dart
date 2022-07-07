import 'package:flutter/material.dart';

import '../partial/header.dart';

class ArticleReadPage extends StatefulWidget {
  const ArticleReadPage({Key? key}) : super(key: key);

  @override
  State<ArticleReadPage> createState() => _ArticleReadPageState();
}

class _ArticleReadPageState extends State<ArticleReadPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const HeaderWidget(),
            const SizedBox(height: 16),
            Container(
                width: 1024,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Text("文章正文"))
          ],
        ));
  }
}

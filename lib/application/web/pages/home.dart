import 'package:dream/application/web/pages/partial/header.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ArticleItemWidget extends StatelessWidget {
  String title;

  ArticleItemWidget({Key? key, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(8),
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16))),
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

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String readRepositories = """
  query ReadRepositories {
    articles {
        title
    }
}
""";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const HeaderWidget(),
        const SizedBox(height: 16),
        Expanded(
            child: Container(
                width: 1024,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     ArticleItemWidget(),
                //     Container(
                //         margin: EdgeInsets.all(8),
                //         height: 1,
                //         color: Color(0xFFE5E6EC)),
                //     ArticleItemWidget(),
                //     Container(
                //         margin: EdgeInsets.all(8),
                //         height: 1,
                //         color: Color(0xFFE5E6EC)),
                //     ArticleItemWidget(),
                //     Container(
                //         margin: EdgeInsets.all(8),
                //         height: 1,
                //         color: Color(0xFFE5E6EC)),
                //     ArticleItemWidget()
                //   ],
                // ),
                child: Query(
                  options: QueryOptions(
                    document: gql(readRepositories),
                    // this is the query string you just created
                    variables: const {
                      'nRepositories': 50,
                    },
                    //pollInterval: const Duration(seconds: 10),
                  ),
                  builder: (QueryResult result,
                      {VoidCallback? refetch, FetchMore? fetchMore}) {
                    if (result.hasException) {
                      return Text(result.exception.toString());
                    }

                    if (result.isLoading) {
                      return const Text('Loading');
                    }

                    List? repositories = result.data?['articles'];

                    if (repositories == null) {
                      return const Text('No repositories');
                    }

                    return ListView.builder(
                        itemCount: repositories.length,
                        itemBuilder: (context, index) {
                          final repository = repositories[index];

                          //return Text(repository['title'] ?? '');
                          return Column(children: [
                            ArticleItemWidget(title: repository['title'] ?? ''),
                            Container(
                                margin: const EdgeInsets.all(8),
                                height: 1,
                                color: const Color(0xFFE5E6EC)),
                          ]);
                        });
                  },
                )))
      ],
    );
  }
}

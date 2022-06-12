import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'partial/header.dart';

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

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final int INDEX_PAGE_SIZE = 10;
  int currentPage = 1;

  Widget renderPagination(
      BuildContext context, int articlesCount, void Function(int) callback) {
    int maxPage = articlesCount ~/ INDEX_PAGE_SIZE;
    if (articlesCount % INDEX_PAGE_SIZE != 0) {
      maxPage += 1;
    }
    if (currentPage > maxPage) {
      currentPage = maxPage;
    }
    int startPage = currentPage - 5;
    int endPage = currentPage + 5;

    if (startPage < 1) {
      startPage = 1;
    }
    if (endPage > maxPage) {
      endPage = maxPage;
    }
    int prevPage = currentPage - 1;
    int nextPage = currentPage + 1;
    debugPrint("pages $currentPage $prevPage $nextPage $maxPage");

    return Row(
      children: [
        if (prevPage >= 1)
          TextButton(
              child: Text("«"),
              onPressed: () {
                debugPrint("prevPage $prevPage");
                callback(prevPage);
              }),
        for (int n = startPage; n <= endPage; ++n)
          TextButton(
              child: Text(n.toString()),
              onPressed: () {
                debugPrint("currentPage $n");
                callback(n);
              }),
        if (nextPage <= maxPage)
          TextButton(
              child: Text("»"),
              onPressed: () {
                debugPrint("nextPage $nextPage");
                callback(nextPage);
              })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String readRepositories = """
  query index(\$offset: Int!, \$limit: Int!) {
    articles(offset: \$offset, limit: \$limit) {
        title
    }
    count
}
""";

    return SingleChildScrollView(
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
            child: Query(
              options: QueryOptions(
                  document: gql(readRepositories),
                  variables: {"offset": 0, "limit": INDEX_PAGE_SIZE},
                  cacheRereadPolicy: CacheRereadPolicy.ignoreAll),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return const Text('Loading');
                }
                debugPrint("result ${result.data}");
                final int count = result.data?['count'];

                List? repositories = result.data?['articles'];

                if (repositories == null) {
                  return const Text('No repositories');
                }

                return Column(
                    children: List.generate(repositories.length + 1, (index) {
                  if (index < repositories.length) {
                    final repository = repositories[index];
                    //return Text(repository['title'] ?? '');
                    return Column(children: [
                      ArticleItemWidget(title: repository['title'] ?? ''),
                      Container(
                          margin: const EdgeInsets.all(8),
                          height: 1,
                          color: const Color(0xFFE5E6EC)),
                    ]);
                  } else if (fetchMore != null) {
                    return Column(children: [
                      Container(
                          child: renderPagination(context, count, (page) {
                        setState(() {
                          currentPage = page;
                        });

                        int offset = (page - 1) * INDEX_PAGE_SIZE;
                        FetchMoreOptions opts = FetchMoreOptions(
                          variables: {
                            "offset": offset,
                            "limit": INDEX_PAGE_SIZE
                          },
                          updateQuery:
                              (previousResultData, fetchMoreResultData) {
                            return fetchMoreResultData;
                          },
                        );
                        fetchMore(opts);
                      }))
                    ]);
                  }
                  return Column(children: []);
                }));
              },
            ))
      ],
    ));
  }
}

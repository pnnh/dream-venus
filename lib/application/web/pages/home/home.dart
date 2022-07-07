import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../partial/header.dart';
import 'item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int indexPageSize = 10;
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    String readRepositories = """
  query index(\$offset: Int!, \$limit: Int!) {
    articles(offset: \$offset, limit: \$limit) {
        title
    }
    articlesCount
}
""";

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
                child: Query(
                  options: QueryOptions(
                      document: gql(readRepositories),
                      variables: {"offset": 0, "limit": indexPageSize},
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
                    final int count = result.data?['articlesCount'];

                    List? repositories = result.data?['articles'];

                    if (repositories == null) {
                      return const Text('No repositories');
                    }

                    return Column(
                        children:
                            List.generate(repositories.length + 1, (index) {
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

                            int offset = (page - 1) * indexPageSize;
                            FetchMoreOptions opts = FetchMoreOptions(
                              variables: {
                                "offset": offset,
                                "limit": indexPageSize
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

  Widget renderPagination(
      BuildContext context, int articlesCount, void Function(int) callback) {
    int maxPage = articlesCount ~/ indexPageSize;
    if (articlesCount % indexPageSize != 0) {
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
}

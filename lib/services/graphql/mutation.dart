import 'package:dream/services/store/isar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlMutationClient {
  static GraphQLClient? _instance;

  // 私有的命名构造函数
  GraphqlMutationClient._internal();

  static Future<GraphQLClient?> getInstance() async {
    if (_instance == null) {
      var auth = await IsarStore.findAuthorization();
      final HttpLink httpLink = HttpLink(
        'http://127.0.0.1:8080/graphql/mutation',
      );

      final AuthLink authLink = AuthLink(
          getToken: () =>
              auth != null ? "${auth.tokenType} ${auth.accessToken}" : "");

      final Link link = authLink.concat(httpLink);

      var instance = GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
        //cache: GraphQLCache(store: InMemoryStore()),
      );

      _instance = instance;
    }
    return _instance!;
  }
}

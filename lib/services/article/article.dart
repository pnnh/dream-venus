import 'package:dream/services/store/isar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphql/mutation.dart';

Future<bool> postArticleCreate(String title, String body,
    {bool publish = false}) async {
  var auth = await IsarStore.findAuthorization();
  if (auth == null) {
    return false;
  }
  String readRepositories = """
mutation createArticle(\$patch: CreateArticleInput!) {
  createArticle(input: \$patch) {
    pk
  }
}
""";

  var client = await GraphqlMutationClient.getInstance();
  if (client == null) {
    throw Exception("获取Graphql客户端出错2");
  }

  final MutationOptions options = MutationOptions(
    document: gql(readRepositories),
    variables: <String, dynamic>{
      'patch': <String, dynamic>{
        "title": "title3",
        "body": "body3",
        "publish": true
      },
    },
  );
  final QueryResult result = await client.mutate(options);

  if (result == null) {
    return false;
  }
  if (result.hasException) {
    print(result.exception.toString());
  }

  print("result ${result.data}");

  return true;
  //
  // var url = Uri.parse('http://localhost:8080/article/create');
  // var response = await http.post(url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': "${auth.tokenType} ${auth.accessToken}"
  //     },
  //     body: jsonEncode({'title': title, 'body': body, "publish": publish}));
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
  //
  // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  // var pk = decodedResponse['pk'];
  // print('status: $pk');
  // return true;
}

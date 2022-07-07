import 'package:dream/services/graphql/mutation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'route.dart';

class WebApplication extends StatefulWidget {
  final GraphQLClient client;
  const WebApplication({Key? key, required this.client}) : super(key: key);

  @override
  State<WebApplication> createState() => _WebApplicationState();
}

class _WebApplicationState extends State<WebApplication> {
  final WebRouterDelegate _routerDelegate = WebRouterDelegate();
  final WebRouteInformationParser _routeInformationParser =
      WebRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    ValueNotifier<GraphQLClient> client = ValueNotifier(widget.client);

    return GraphQLProvider(
      client: client,
      child: MaterialApp.router(
        title: '网页应用',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          //fontFamily: "WqyMicroHeiLite", // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
          fontFamily: "WqyMicroHeiLite",
          // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black, //<-- SEE HERE
                displayColor: Colors.black, //<-- SEE HERE
              ),
        ),
        debugShowCheckedModeBanner: false,
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
      ),
    );
  }
}

Future<Widget> initApp() async {
  await initHiveForFlutter();
  var client = await GraphqlMutationClient.getInstance();
  if (client == null) {
    throw Exception("获取Graphql客户端出错");
  }
  return WebApplication(
    client: client,
  );
}

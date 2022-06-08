import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'route.dart';

class WebApplication extends StatefulWidget {
  const WebApplication({Key? key}) : super(key: key);

  @override
  State<WebApplication> createState() => _WebApplicationState();
}

class _WebApplicationState extends State<WebApplication> {
  final WebRouterDelegate _routerDelegate = WebRouterDelegate();
  final WebRouteInformationParser _routeInformationParser =
      WebRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'http://127.0.0.1:5500/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
      // OR
      // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    );

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp.router(
        title: '网页应用',
        theme: ThemeData(
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          //fontFamily: "WqyMicroHeiLite", // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
          fontFamily: "WqyMicroHeiLite", // 全局默认字体，CanvasKit下需要设置否则会加载许多谷歌字体
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
  return const WebApplication();
}

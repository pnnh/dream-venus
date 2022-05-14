import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream/application/desktop/provider/body.dart';
import 'package:dream/application/desktop/provider/home.dart';
import 'package:dream/application/desktop/provider/todo.dart';
import 'package:dream/application/desktop/route.dart';
import 'package:dream/services/store/hive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final BookRouterDelegate _routerDelegate = BookRouterDelegate();
  final BookRouteInformationParser _routeInformationParser =
  BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => TodoProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => HomeProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => BodyProvider(),
          )
        ],
        child: MaterialApp.router(
          title: 'Books App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.white),
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeInformationParser,
        ));
  }
}

Future<void> initApp() async {
  await HiveStore.init();
  doWhenWindowReady(() {
    appWindow.minSize = const Size(640, 480);
    appWindow.size = const Size(1280, 900);
    appWindow.maxSize = const Size(2560, 1920);
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

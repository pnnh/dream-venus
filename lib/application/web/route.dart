import 'package:dream/application/web/pages/base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute(WidgetBuilder builder, {RouteSettings? settings})
      : super(settings: settings, builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class WebRoutePath {
  late Uri uri;

  WebRoutePath(String location) {
    uri = Uri.parse(location);
  }

  WebRoutePath.home() : this("/");

  WebRoutePath.login() : this("/login");
}

class WebRouteInformationParser extends RouteInformationParser<WebRoutePath> {
  @override
  Future<WebRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    debugPrint('BookRouteInformationParser ${routeInformation.location}');
    return routeInformation.location != null
        ? WebRoutePath(routeInformation.location!)
        : WebRoutePath.home();
  }

  @override
  RouteInformation restoreRouteInformation(WebRoutePath configuration) {
    return RouteInformation(location: configuration.uri.toString());
  }
}

class WebRouterDelegate extends RouterDelegate<WebRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<WebRoutePath> {
  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _stack = <WebRoutePath>[WebRoutePath.home()];
  int _currentIndex = 0;

  List<String> get stack => List.unmodifiable(_stack);

  WebRouterDelegate();

  static WebRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is WebRouterDelegate, 'Delegate type must match');
    return delegate as WebRouterDelegate;
  }

  @override
  WebRoutePath get currentConfiguration {
    debugPrint("currentConfiguration $_currentIndex");
    return _stack.last;
  }

  // bool isFirst() {
  //   return _currentIndex == 0;
  // }
  //
  // bool isLast() {
  //   return _currentIndex == _stack.length - 1;
  // }

  void go(String location) {
    debugPrint("go $location $_currentIndex");
    var newRoute = WebRoutePath(location);
    // for (var i = _currentIndex + 1; i < _stack.length; i++) {
    //   _stack.removeAt(i);
    // }
    _stack.add(newRoute);
    _currentIndex++;
    notifyListeners();
  }

  // void back() {
  //   debugPrint("back $_currentIndex");
  //   if (_stack.length > 1 && _currentIndex > 0) {
  //     _currentIndex--;
  //   }
  //   notifyListeners();
  // }
  //
  // void forward() {
  //   debugPrint("forward $_currentIndex");
  //   if (_currentIndex < _stack.length - 1) {
  //     _currentIndex++;
  //   }
  //   notifyListeners();
  // }

  @override
  Future<void> setInitialRoutePath(WebRoutePath configuration) {
    return setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(WebRoutePath configuration) async {
    debugPrint('setNewRoutePath ${configuration.uri}');
    _stack
      ..clear()
      ..add(configuration);
    return SynchronousFuture<void>(null);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    debugPrint('_onPopPage ${route.settings}');
    if (_stack.length > 1) {
      _stack.removeLast();
      notifyListeners();
    }
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    List<Page<dynamic>> pages = [];
    for (var i = 0; i < _stack.length; i++) {
      if (i <= _currentIndex) {
        pages.add(WebPage(_stack[i]));
      }
    }
    return Navigator(
      key: navigatorKey,
      pages: pages,
      //pages: [MyPage(_stack[_currentIndex])],
      onPopPage: _onPopPage,
    );
  }
}

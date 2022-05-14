import 'package:dream/application/desktop/pages/base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute(WidgetBuilder builder, {RouteSettings? settings})
      : super(settings: settings, builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class BookRoutePath {
  late Uri uri;

  BookRoutePath(String location) {
    uri = Uri.parse(location);
  }

  BookRoutePath.home() : this("/");

  BookRoutePath.calendar() : this("/calendar");

  BookRoutePath.other() : this("/other");
}

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    debugPrint('BookRouteInformationParser ${routeInformation.location}');
    return routeInformation.location != null
        ? BookRoutePath(routeInformation.location!)
        : BookRoutePath.home();
  }

  @override
  RouteInformation restoreRouteInformation(BookRoutePath configuration) {
    return RouteInformation(location: configuration.uri.toString());
  }
}

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final _stack = <BookRoutePath>[BookRoutePath.home()];
  int _currentIndex = 0;

  List<String> get stack => List.unmodifiable(_stack);

  BookRouterDelegate();

  static BookRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is BookRouterDelegate, 'Delegate type must match');
    return delegate as BookRouterDelegate;
  }

  @override
  BookRoutePath get currentConfiguration => _stack[_currentIndex];

  bool isFirst() {
    return _currentIndex == 0;
  }

  bool isLast() {
    return _currentIndex == _stack.length - 1;
  }

  void go(String location) {
    var newRoute = BookRoutePath(location);
    for (var i = _currentIndex + 1; i < _stack.length; i++) {
      _stack.removeAt(i);
    }
    _stack.add(newRoute);
    _currentIndex++;
    notifyListeners();
  }

  void back() {
    if (_stack.length > 1 && _currentIndex > 0) {
      _currentIndex--;
    }
    notifyListeners();
  }

  void forward() {
    if (_currentIndex < _stack.length - 1) {
      _currentIndex++;
    }
    notifyListeners();
  }

  @override
  Future<void> setInitialRoutePath(BookRoutePath configuration) {
    return setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {
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
        pages.add(MyPage(_stack[i]));
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

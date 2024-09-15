import 'package:flutter_test/flutter_test.dart';

RouteMatcher isRoute({required String routeName, dynamic arguments}) =>
    RouteMatcher(routeName: routeName, arguments: arguments);

class RouteMatcher extends Matcher {
  final String routeName;
  final dynamic arguments;

  RouteMatcher({
    required this.routeName,
    this.arguments,
  });

  @override
  Description describe(Description description) {
    return description.add("route name: $routeName, arguments: $arguments");
  }

  @override
  bool matches(item, Map matchState) {
    return item.settings.name == routeName &&
        item.settings.arguments == arguments;
  }
}

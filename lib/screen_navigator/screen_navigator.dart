import 'package:demo1/router/app_router.dart';
import 'package:flutter/material.dart';

class ScreenNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;

  const ScreenNavigator({
    super.key,
    required this.navigatorKey,
    this.onGenerateRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: onGenerateRoute,
    );
  }
}

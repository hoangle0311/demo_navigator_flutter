import 'package:demo1/dummy/dummy_bottom_nav.dart';
import 'package:demo1/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterEndPoint.screen1:
        return _materialRoute(
          Screen1(),
        );
      case AppRouterEndPoint.main:
      default:
        return _materialRoute(
          HomeScreen(),
        );
      // case AppRouterEndPoint.screen1:
      //   return _materialRoute(
      //     Screen1(),
      //   );
      // case AppRouterEndPoint.screen2:
      //   return _materialRoute(
      //     Screen2(),
      //   );
      // default:
      //   return _materialRoute(
      //     Screen1(),
      //   );
    }
  }

  static Route onGenerateRoutesPage1(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterEndPoint.screen2:
        return _materialRoute(
          Screen2(),
        );
      case AppRouterEndPoint.screen1:
      default:
        return _materialRoute(
          Screen1(
            argument: settings.arguments as Screen1Argument<DummyBottomNav>?,
          ),
        );
    }
  }

  static Route onGenerateRoutesPage2(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterEndPoint.screen1:
        return _materialRoute(
          Screen1(
            argument: settings.arguments as Screen1Argument<DummyBottomNav>?,
          ),
        );
      case AppRouterEndPoint.screen2:
      default:
        return _materialRoute(
          Screen2(),
        );
    }
  }

  // static Route onGenerateRoutesPage1(RouteSettings settings) {
  //   switch (settings.name) {
  //     case AppRouterEndPoint.screen2:
  //       return _materialRoute(
  //         Screen2(),
  //       );
  //     case AppRouterEndPoint.screen1:
  //     default:
  //       return _materialRoute(
  //         Screen1(),
  //       );
  //   }
  // }

  static Route<dynamic> _materialRoute(
    Widget view, {
    AxisDirection? direction,
  }) {
    return CustomPageRoute(
      child: view,
      direction: direction,
    );
  }
}

abstract class AppRouterEndPoint {
  static const String main = '/main';
  static const String screen1 = '/screen1';
  static const String screen2 = '/screen2';
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection? direction;

  CustomPageRoute({
    required this.child,
    this.direction = AxisDirection.left,
  }) : super(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return super.buildTransitions(
      context,
      animation,
      secondaryAnimation,
      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(
          animation,
        ),
        child: child,
      ),
    );
  }

  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
      default:
        return const Offset(1, 0);
    }
  }
}

abstract class AppRouterArgument<T> {
  final bool hasBack;
  final T? data;

  const AppRouterArgument({
    required this.hasBack,
    this.data,
  });
}

class Screen1Argument<T> extends AppRouterArgument {
  Screen1Argument({
    required bool hasBack,
    T? data,
  }) : super(
          hasBack: hasBack,
          data: data,
        );
}

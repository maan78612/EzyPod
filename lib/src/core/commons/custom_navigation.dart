import 'package:ezy_pod/src/core/constants/globals.dart';
import 'package:flutter/material.dart';

class CustomNavigation {
  static final CustomNavigation _instance = CustomNavigation._internal();

  factory CustomNavigation() {
    return _instance;
  }

  CustomNavigation._internal();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void push(Widget page) {
    Navigator.of(_navigatorKey.currentContext!).push(
      RoutingAnimation(
        child: page,
      ),
    );
  }

  void pushReplacement(Widget page) {
    Navigator.of(_navigatorKey.currentContext!).pushReplacement(
      RoutingAnimation(
        child: page,
      ),
    );
  }

  void pushAndRemoveUntil(Widget page) {
    Navigator.of(_navigatorKey.currentContext!).pushAndRemoveUntil(
      RoutingAnimation(child: page),
      (Route<dynamic> route) => false,
    );
  }

  void pop<T extends Object>([T? result]) {
    Navigator.of(_navigatorKey.currentContext!).pop<T>(result);
  }

  void popUntil(Widget page) {
    Navigator.of(_navigatorKey.currentContext!).popUntil(
        (route) => route.settings.name == page.runtimeType.toString());
  }
}

class RoutingAnimation extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;

  RoutingAnimation({this.direction = AxisDirection.left, required this.child})
      : super(
            transitionDuration: const Duration(milliseconds: routingDuration),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(begin: getBeginOffset(), end: Offset.zero)
            .animate(animation),
        // scale: animation,
        child: child,
      );

  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
      default:
        return const Offset(-1, 0);
    }
  }
}

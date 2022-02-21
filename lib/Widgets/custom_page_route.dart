import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  CustomPageRoute(
      {required this.child,
        required this.direction,
        RouteSettings? settings})
      : super(
    transitionDuration: Duration(milliseconds: 350),
    reverseTransitionDuration: Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
            begin: direction == AxisDirection.up
                ? Offset(0, 1)
                : direction == AxisDirection.down
                ? Offset(0, -1)
                : direction == AxisDirection.right
                ? Offset(-1, 0)
                : Offset(1, 0),
            end: Offset.zero)
            .animate(animation),
        child: child,
      );
    },
    settings: settings,
  );
}

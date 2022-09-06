import 'package:flutter/material.dart';

class ShakeTransition extends StatelessWidget {
  const ShakeTransition({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.offset = 140.0,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        child: child,
        tween: axis == Axis.horizontal
            ? Tween(begin: 1.0, end: 0.0)
            : Tween(begin: 0.0, end: 1.0),
        duration: duration,
        curve: Curves.bounceOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: axis == Axis.horizontal
                ? Offset(value * offset, 0.0)
                : Offset(0.0, value * offset),
            child: child,
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:poetlum/core/constants/animation_constants.dart';

class RightAnimation extends StatelessWidget {
  const RightAnimation({
    super.key, 
    required this.child, 
    required this.animationField,
    required this.positionInitialValue, 
  });
  
  final Widget child;
  final bool animationField;
  final double positionInitialValue;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder(
    tween: Tween<double>(begin: 0.0, end: animationField ? 1.0 : 0.0),
    duration: animationDuration,
    curve: animationCurve,
    builder: (context, value, child) => Opacity(
      opacity: value,
      child: Transform.translate(
        offset: Offset(-positionInitialValue * (1 - value), 0),
        child: child,
      ),
    ),
    child: child,
  );
}

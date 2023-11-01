import 'package:flutter/material.dart';

mixin RotatingButtonMixin on TickerProvider {
  late AnimationController rotationController;
  late Animation<double> rotationAnimation;

  void playAnimation() => rotationController..reset()..forward();

  @mustCallSuper
  void initState() {
    rotationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    rotationAnimation = CurvedAnimation(
      parent: rotationController,
      curve: Curves.easeOutCubic,
    );
  }

  @mustCallSuper
  void dispose() {
    rotationController.dispose();
  }
}

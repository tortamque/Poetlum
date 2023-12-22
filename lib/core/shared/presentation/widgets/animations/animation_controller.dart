import 'package:flutter/material.dart';

class AnimationControllerWithDelays {
  AnimationControllerWithDelays({
    required this.initialDelay,
    required this.delayBetweenAnimations,
    required this.numberOfAnimations,
  }) {
    animationStates = List.filled(numberOfAnimations, false);
  }

  final Duration initialDelay;
  final Duration delayBetweenAnimations;
  final int numberOfAnimations;
  late List<bool> animationStates;

  Future<void> startAnimations(VoidCallback setStateCallback) async {
    await Future.delayed(initialDelay);
    for (var i = 0; i < numberOfAnimations; i++) {
      await Future.delayed(delayBetweenAnimations);
      animationStates[i] = true;
      setStateCallback();
    }
  }
}

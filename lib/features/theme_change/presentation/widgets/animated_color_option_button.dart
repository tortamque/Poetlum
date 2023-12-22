import 'package:flutter/material.dart';
import 'package:poetlum/features/theme_change/presentation/widgets/color_option_button.dart';

class AnimatedColorOptionButton extends StatefulWidget {
  const AnimatedColorOptionButton({
    super.key,
    required this.button,
    required this.delay, 
    required this.positionInitialValue,
  });
  
  final ColorOptionButton button;
  final Duration delay;
  final double positionInitialValue;

  @override
  State<AnimatedColorOptionButton> createState() => _AnimatedColorOptionButtonState();
}

class _AnimatedColorOptionButtonState extends State<AnimatedColorOptionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(widget.delay).then((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _animation,
    builder: (context, child) => Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, widget.positionInitialValue * (1 - _animation.value)),
        child: child,
      ),
    ),
    child: widget.button,
  );
}

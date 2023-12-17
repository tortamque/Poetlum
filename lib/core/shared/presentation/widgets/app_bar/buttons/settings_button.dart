// ignore_for_file: avoid_positional_boolean_parameters

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/animation_controller.dart';
import 'package:poetlum/core/shared/presentation/widgets/animations/right_animation.dart';
import 'package:poetlum/core/shared/presentation/widgets/rotating_button_mixin.dart';
import 'package:poetlum/features/theme_change/presentation/widgets/animated_color_option_button.dart';
import 'package:poetlum/features/theme_change/presentation/widgets/color_options.dart';

class SettingsButton extends StatefulWidget {
  const SettingsButton({super.key});

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> with TickerProviderStateMixin, RotatingButtonMixin {
  late AnimationControllerWithDelays animationController;
  final Duration animationDelay = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(
      name: 'theme',
      parameters: {
        'opened': 'true',
      },
    );
    super.initState();
    animationController = AnimationControllerWithDelays(
      initialDelay: Duration.zero,
      delayBetweenAnimations: animationDelay,
      numberOfAnimations: 1,
    );
    animationController.startAnimations(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) => RightAnimation(
    animationField: animationController.animationStates[0],
    positionInitialValue: MediaQuery.of(context).size.width/6,
    child: RotationTransition(
      turns: rotationAnimation,
      child: IconButton(
        tooltip: 'Settings',
        onPressed: () async{
          playAnimation();
          
          await showModalBottomSheet(
            context: context, 
            builder: (context) => const _BottomSheetContent(),
          );
        },
        icon: const Icon(Icons.settings),
      ),
    ),
  );

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class _BottomSheetContent extends StatefulWidget {
  const _BottomSheetContent();

  @override
  State<_BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<_BottomSheetContent> {
  bool isHeaderAnimated = false;
  final Duration animationDelay = const Duration(milliseconds: 125);

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() {
    final setters = <Function(bool)>[
      (val) => isHeaderAnimated = val,
    ];

    for (var i = 0; i < setters.length; i++) {
      Future.delayed(animationDelay * (i + 1)).then(
        (_) => setState(() => setters[i](true)),
      );
    }
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      children: [
        RightAnimation(
          animationField: isHeaderAnimated,
          positionInitialValue: MediaQuery.of(context).size.width/6,
          child: const _Title(text: 'Choose your theme'),
        ),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          children: List.generate(
            ColorOptions.colors.length,
            (index) => AnimatedColorOptionButton(
              button: ColorOptions.colors[index],
              delay: Duration(milliseconds: animationDelay.inMilliseconds * index),
              positionInitialValue: MediaQuery.of(context).size.height/15,
            ),
          ),
        ),
      ],
    ),
  );
}

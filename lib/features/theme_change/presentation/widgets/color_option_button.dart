import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/shared/presentation/widgets/rotating_button_mixin.dart';
import 'package:poetlum/features/theme_change/presentation/bloc/change_theme_cubit.dart';

class ColorOptionButton extends StatefulWidget {
  const ColorOptionButton({
    required this.themeColor,
    super.key,
  });

  final Color themeColor;

  @override
  State<ColorOptionButton> createState() => _ColorOptionButtonState();
}

class _ColorOptionButtonState extends State<ColorOptionButton>  with TickerProviderStateMixin, RotatingButtonMixin {
  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(30),
    child: RotationTransition(
      turns: rotationAnimation,
      child: GestureDetector(
        onTap: () async {
          playAnimation();

          unawaited(
            FirebaseAnalytics.instance.logEvent(
              name: 'theme',
              parameters: {
                'color': 'R: ${widget.themeColor.red}, G: ${widget.themeColor.green}, B: ${widget.themeColor.blue}',
              },
            ),
          );
          
          await context.read<ThemeCubit>().setThemeColor(themeColor: widget.themeColor, needSave: true);
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.themeColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                offset: Offset(5, 5),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/buttons/rotating_button_mixin.dart';

class SettingsButton extends StatefulWidget {
  const SettingsButton({super.key});

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> with TickerProviderStateMixin, RotatingButtonMixin {
  @override
  Widget build(BuildContext context) => RotationTransition(
    turns: rotationAnimation,
    child: IconButton(
      tooltip: 'Settings',
      onPressed: (){
        playAnimation();
        // ...
      },
      icon: const Icon(Icons.settings),
    ),
  );

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }
}

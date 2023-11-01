import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/buttons/rotating_button_mixin.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> with TickerProviderStateMixin, RotatingButtonMixin {
  @override
  Widget build(BuildContext context) => RotationTransition(
    turns: rotationAnimation,
    child: IconButton(
      onPressed: (){
        playAnimation();
        // ...
      },
      icon: const Icon(Icons.menu),
    ),
  );
}

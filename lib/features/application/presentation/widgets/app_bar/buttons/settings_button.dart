import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/buttons/rotating_button_mixin.dart';
import 'package:poetlum/features/theme_change/presentation/widgets/color_options.dart';

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
      onPressed: () async{
        playAnimation();
        
        await showModalBottomSheet(
          context: context, 
          builder: (context) => _buildBottomSheetContent(),
        );
      },
      icon: const Icon(Icons.settings),
    ),
  );

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  Widget _buildBottomSheetContent() => SizedBox(
    child: Column(
      children: [
        const Text('Choose your theme'),
        Expanded( 
          child: GridView.count(
            crossAxisCount: 3,
            children: ColorOptions.colors,
          ),
        ),
      ],
    ),
  );
}

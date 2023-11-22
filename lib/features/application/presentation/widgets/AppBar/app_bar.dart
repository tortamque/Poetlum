import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/buttons/settings_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => AppBar(
    actions: const [
      SettingsButton(),
    ],
    title: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

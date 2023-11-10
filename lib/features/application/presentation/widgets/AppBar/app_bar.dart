import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/buttons/menu_buton.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/buttons/settings_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => AppBar(
    leading: const MenuButton(),
    actions: const [
      SettingsButton(),
    ],
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

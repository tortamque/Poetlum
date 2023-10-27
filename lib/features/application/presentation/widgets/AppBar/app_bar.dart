import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.backgroundColor});

  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: backgroundColor,
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

import 'package:flutter/material.dart';

class PoemTitle extends StatelessWidget {
  const PoemTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
}

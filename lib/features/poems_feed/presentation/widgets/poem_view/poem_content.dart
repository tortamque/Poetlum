import 'package:flutter/material.dart';

class PoemContent extends StatelessWidget {
  const PoemContent({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
      text,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
}
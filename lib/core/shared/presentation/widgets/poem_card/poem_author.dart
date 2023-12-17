import 'package:flutter/material.dart';

class PoemAuthor extends StatelessWidget {
  const PoemAuthor({super.key, required this.author});

  final String author;

  @override
  Widget build(BuildContext context) => Text(
      author,
      style: const TextStyle(
        fontSize: 22,
        fontStyle: FontStyle.italic,
      ),
    );
}

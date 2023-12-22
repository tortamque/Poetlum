import 'package:flutter/material.dart';

class PoemLineCount extends StatelessWidget {
  const PoemLineCount({super.key, required this.lineCount});

  final int lineCount;

  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerRight,
      child: Text(
        '$lineCount lines',
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
}

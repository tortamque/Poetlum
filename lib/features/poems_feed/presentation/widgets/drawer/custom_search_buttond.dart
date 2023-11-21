import 'package:flutter/material.dart';

class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth / 1.35;

      return Align(
        child: SizedBox(
          width: width,
          child: FilledButton(
            onPressed: onPressed, 
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.5),
              child: Text(
                'Search',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:poetlum/features/poems_feed/presentation/pages/home/poems_feed.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    children: [
      CustomSpacer(heightFactor: 0.04),
      Center(
        child: Text(
          'Search settings',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      CustomSpacer(heightFactor: 0.04),
    ],
  );
}

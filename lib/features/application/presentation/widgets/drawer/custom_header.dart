import 'package:flutter/material.dart';
import 'package:poetlum/core/shared/presentation/widgets/custom_spacer.dart';
import 'package:poetlum/features/poems_feed/data/models/firebase_user.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key, required this.user});

  final FirebaserUserModel user;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const CustomSpacer(heightFactor: 0.02),

      Text(
        'Hello, ${user.username}',
        style: const TextStyle(fontSize: 20),
      ),

      const CustomSpacer(heightFactor: 0.02),

      const Text(
        'Search settings',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),

      const CustomSpacer(heightFactor: 0.04),
    ],
  );
}

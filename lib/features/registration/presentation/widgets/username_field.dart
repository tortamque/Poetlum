import 'package:flutter/material.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width/1.5,
    child: TextField(
      controller: controller,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Username',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    ),
  );
}

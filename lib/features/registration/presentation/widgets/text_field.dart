import 'package:flutter/material.dart';

class RegistrationTextField extends StatelessWidget {
  const RegistrationTextField({super.key, required this.controller, required this.hintText, required this.isPassword});

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width/1.5,
    child: TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    ),
  );
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width/1.5,
    child: Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        controller: controller,
        validator: (value) => EmailValidator.validate(value!) ? null : 'Please enter a valid email',
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Email',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}

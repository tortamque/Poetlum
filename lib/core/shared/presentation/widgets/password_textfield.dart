import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({super.key, required this.controller, required this.widthFactor, required this.hintText});

  final TextEditingController controller;
  final double widthFactor;
  final String hintText;

  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width/widget.widthFactor,
    child: TextField(
      controller: widget.controller,
      obscureText: !_isPasswordVisible,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        errorMaxLines: 3,
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
        icon: Icon(
            _isPasswordVisible
            ? Icons.visibility
            : Icons.visibility_off,
          ),
          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
      ),
    ),
  );
}

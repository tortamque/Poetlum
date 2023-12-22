import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, 
    required this.hintText,
    this.isNumberInput = false, 
    required this.controller,
  });

  final String hintText;
  final bool isNumberInput;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth / 1.35;

      return Align(
        child: SizedBox(
          width: width,  
          child: TextField(
            controller: controller,
            keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
            inputFormatters: isNumberInput ? [FilteringTextInputFormatter.digitsOnly] : null,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    },
  );
}

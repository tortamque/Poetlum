import 'package:flutter/material.dart';

class CustomCheckboxTile extends StatelessWidget {
  const CustomCheckboxTile({super.key, required this.value, required this.onChanged});

  final bool? value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) => CheckboxListTile(
    value: value, 
    onChanged: onChanged,
    title: const Text('Return random poems?'),
    controlAffinity: ListTileControlAffinity.leading,
  );
}

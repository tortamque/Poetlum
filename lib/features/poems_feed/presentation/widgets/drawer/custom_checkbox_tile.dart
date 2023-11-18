import 'package:flutter/material.dart';

class CustomCheckboxTile extends StatelessWidget {
  const CustomCheckboxTile({super.key});

  @override
  Widget build(BuildContext context) => CheckboxListTile(
    value: true, 
    onChanged: (value){},
    title: const Text('Return random poems?'),
    controlAffinity: ListTileControlAffinity.leading,
  );
}

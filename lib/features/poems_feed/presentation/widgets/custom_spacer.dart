import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({super.key, required this.heightFactor});
  final double heightFactor;


  @override
  Widget build(BuildContext context) => SizedBox(height: MediaQuery.of(context).size.height * heightFactor);
}
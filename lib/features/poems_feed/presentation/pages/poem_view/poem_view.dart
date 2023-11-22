import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/app_bar.dart';

class PoemViewPage extends StatelessWidget {
  const PoemViewPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppBar(title: 'Poetlum'),
    body: Text('Page :)'),
  );
}
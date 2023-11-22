import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/app_bar.dart';

class SavedPoemsPage extends StatelessWidget {
  const SavedPoemsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppBar(title: 'Poetlum')
    ,
  );
}

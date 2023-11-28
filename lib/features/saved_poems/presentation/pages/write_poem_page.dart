import 'package:flutter/material.dart';
import 'package:poetlum/features/application/presentation/widgets/app_bar/app_bar.dart';

class WritePoemPage extends StatelessWidget {
  WritePoemPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppBar(title: 'Poetlum'),
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const _CustomSpacer(heightFactor: 0.03),
          _CustomTextField(hintText: 'Poem name', controller: _nameController, isLarge: false),
          const _CustomSpacer(heightFactor: 0.03),
          _CustomTextField(hintText: 'Your amazing poem :D', controller: _contentController, isLarge: true),
          const _CustomSpacer(heightFactor: 0.03),
          FilledButton.tonal(onPressed: (){}, child: const Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Text('Save'))),
          const _CustomSpacer(heightFactor: 0.03),
        ],
      ),
    ),
  );
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField({
    required this.hintText,
    required this.controller, required this.isLarge,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isLarge;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth / 1.2;

      return Align(
        child: SizedBox(
          width: width,  
          child: TextField(
            controller: controller,
            maxLines: null,
            minLines: isLarge ? 20 : 1,
            textAlign: TextAlign.center,
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

class _CustomSpacer extends StatelessWidget {
  const _CustomSpacer({required this.heightFactor});
  final double heightFactor;


  @override
  Widget build(BuildContext context) => SizedBox(height: MediaQuery.of(context).size.height * heightFactor);
}

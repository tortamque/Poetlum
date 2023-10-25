import 'package:flutter/material.dart';

class PoetlumApp extends StatelessWidget {
  const PoetlumApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Poetlum',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PoetlumHomePage(title: 'Poetlum'),
    );
}

class PoetlumHomePage extends StatefulWidget {
  const PoetlumHomePage({super.key, required this.title});

  final String title;

  @override
  State<PoetlumHomePage> createState() => _PoetlumHomePageState();
}

class _PoetlumHomePageState extends State<PoetlumHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    body: const Placeholder(),
  );
}

import 'package:flutter/material.dart';
import 'package:poetlum/features/firebase/presentation/widgets/init_crashlytics_widget.dart';
import 'package:poetlum/features/firebase/presentation/widgets/init_firebase_widget.dart';
import 'package:poetlum/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    InitFirebaseWidget(
      options: DefaultFirebaseOptions.currentPlatform,
      child: const InitCrashlyticsWidget(
        child: PoetlumApp(),
      ),
    ),
  );
}

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

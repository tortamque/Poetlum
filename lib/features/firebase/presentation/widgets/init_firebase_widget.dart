import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:poetlum/core/shared/presentation/widgets/loader.dart';

class InitFirebaseWidget extends StatefulWidget {
  const InitFirebaseWidget({
    super.key, 
    required this.options, 
    required this.child, 
    this.loader,
  });
  
  final FirebaseOptions options;
  final Widget child;
  final Widget? loader;

  @override
  State<InitFirebaseWidget> createState() => _InitFirebaseWidgetState();
}

class _InitFirebaseWidgetState extends State<InitFirebaseWidget> {
  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: widget.options,
    );
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: _initFirebase(),
    builder:(context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return widget.child;
      } else{
        return MaterialApp(
          home: Scaffold(
            body: widget.loader ?? const Loader(text: 'Initializing Firebase'),
          ),
        );
      }
    },
  );
}

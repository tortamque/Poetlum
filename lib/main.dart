import 'package:flutter/material.dart';
import 'package:poetlum/features/application/poetlum_app.dart';
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

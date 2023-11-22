import 'package:flutter/material.dart';
import 'package:poetlum/features/application/poetlum_app.dart';
import 'package:poetlum/features/dependency_injection/presentation/widgets/init_dependencies.dart';
import 'package:poetlum/features/firebase/presentation/widgets/init_crashlytics_widget.dart';
import 'package:poetlum/features/firebase/presentation/widgets/init_firebase_widget.dart';
import 'package:poetlum/features/multi_bloc_provider/presentation/init_blocs.dart';
import 'package:poetlum/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    InitDependencies(
      child: InitFirebaseWidget(
        options: DefaultFirebaseOptions.currentPlatform,
        child: const InitCrashlyticsWidget(
          child: InitBlocs(
            child: PoetlumApp()
          ),
        ),
      ),
    ),
  );
}

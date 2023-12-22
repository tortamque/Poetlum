import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poetlum/features/application/poetlum_app.dart';
import 'package:poetlum/features/dependency_injection/presentation/widgets/init_dependencies.dart';
import 'package:poetlum/features/firebase/presentation/widgets/init_crashlytics_widget.dart';
import 'package:poetlum/features/firebase/presentation/widgets/init_firebase_widget.dart';
import 'package:poetlum/features/internet_connection_monitoring/presentation/widgets/init_network_controller.dart';
import 'package:poetlum/features/multi_bloc_provider/presentation/init_blocs.dart';
import 'package:poetlum/features/theme_change/presentation/widgets/init_theme_widget.dart';
import 'package:poetlum/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then(
    (_) => runApp(
      InitNetworkController(
        child: InitFirebaseWidget(
          options: DefaultFirebaseOptions.currentPlatform,
          child: const InitDependencies(
            child: InitCrashlyticsWidget(
              child: InitBlocs(
                child: InitTheme(
                  child: PoetlumApp(),
                ),
              ),
            ),
          ),
        ),
      ),
    )
  );
}

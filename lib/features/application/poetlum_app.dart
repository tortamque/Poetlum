import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:poetlum/config/theme/app_theme.dart';
import 'package:poetlum/features/application/presentation/widgets/auth_wrapper.dart';
import 'package:poetlum/features/multi_bloc_provider/presentation/init_blocs.dart';

class PoetlumApp extends StatelessWidget {
  const PoetlumApp({super.key});

  @override
  Widget build(BuildContext context) => InitBlocs(
    child: GetMaterialApp(
      title: 'Poetlum',
      theme: theme(),
      home: const AuthWrapper(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:poetlum/config/theme/app_theme.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/application/presentation/pages/auth_wrapper.dart';
import 'package:poetlum/features/application/presentation/pages/screens_wrapper.dart';
import 'package:poetlum/features/authorization/presentation/pages/login/login_page.dart';
import 'package:poetlum/features/authorization/presentation/pages/registration/registration_page.dart';
import 'package:poetlum/features/poems_feed/presentation/pages/poem_view/poem_view.dart';
import 'package:poetlum/features/saved_poems/presentation/pages/saved_poem_view_page.dart';
import 'package:poetlum/features/saved_poems/presentation/pages/write_poem_page.dart';

class PoetlumApp extends StatelessWidget {
  const PoetlumApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: 'Poetlum',
    theme: theme(),
    initialRoute: authWrapperPageConstant,
    routes: {
      authWrapperPageConstant:(_) => const AuthWrapper(),
      registerPageConstant: (_) => const RegistrationPage(),
      loginPageConstant: (_) => const LoginPage(),
      screensWrapperPageConstant: (_) => const ScreensWrapper(),
      poemViewPageConstant:(_) => const PoemViewPage(),
      writePoemPageConstant: (_) => WritePoemPage(getIt()),
      savedPoemViewConstant: (_) => const SavedPoemViewPage(),
    },
  );
}

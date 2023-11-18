import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:poetlum/config/theme/app_theme.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/features/application/presentation/widgets/auth_wrapper.dart';
import 'package:poetlum/features/authorization/presentation/pages/login/login_page.dart';
import 'package:poetlum/features/authorization/presentation/pages/registration/registration_page.dart';
import 'package:poetlum/features/multi_bloc_provider/presentation/init_blocs.dart';
import 'package:poetlum/features/poems_feed/presentation/pages/home/poems_feed.dart';

class PoetlumApp extends StatelessWidget {
  const PoetlumApp({super.key});

  @override
  Widget build(BuildContext context) => InitBlocs(
    child: GetMaterialApp(
      title: 'Poetlum',
      theme: theme(),
      initialRoute: authWrapperPageConstant,
      routes: {
        authWrapperPageConstant:(_) => const AuthWrapper(),
        registerPageConstant: (_) => const RegistrationPage(),
        loginPageConstant: (_) => const LoginPage(),
        poemsFeedPageConstant: (_) => const PoemsFeed(),
      },
    ),
  );
}

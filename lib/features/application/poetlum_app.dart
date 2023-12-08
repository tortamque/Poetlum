import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:poetlum/core/constants/navigator_constants.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/application/presentation/pages/auth_wrapper.dart';
import 'package:poetlum/features/application/presentation/pages/screens_wrapper.dart';
import 'package:poetlum/features/authorization/presentation/pages/login/login_page.dart';
import 'package:poetlum/features/authorization/presentation/pages/registration/registration_page.dart';
import 'package:poetlum/features/poems_feed/presentation/pages/poem_view/poem_view.dart';
import 'package:poetlum/features/saved_poems/presentation/pages/saved_collection_view_page.dart';
import 'package:poetlum/features/saved_poems/presentation/pages/saved_poem_view_page.dart';
import 'package:poetlum/features/saved_poems/presentation/pages/write_poem_page.dart';
import 'package:poetlum/features/theme_change/presentation/bloc/change_theme_cubit.dart';
import 'package:poetlum/features/theme_change/presentation/bloc/change_theme_state.dart';

class PoetlumApp extends StatelessWidget {
  const PoetlumApp({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, state) => GetMaterialApp(
      title: 'Poetlum',
      theme: state.themeData,
      initialRoute: authWrapperPageConstant,
      routes: {
        authWrapperPageConstant:(_) => const AuthWrapper(),
        registerPageConstant: (_) => const RegistrationPage(),
        loginPageConstant: (_) => const LoginPage(),
        screensWrapperPageConstant: (_) => const ScreensWrapper(),
        poemViewPageConstant:(_) => const PoemViewPage(),
        writePoemPageConstant: (_) => WritePoemPage(getIt()),
        savedCollectionViewConstant: (_) => const SavedCollectionViewPage(),
        savedPoemViewConstant: (_) => const SavedPoemViewPage(),
      },
    ),
  );
}

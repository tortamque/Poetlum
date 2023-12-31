import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/core/shared/presentation/widgets/loader.dart';
import 'package:poetlum/features/application/presentation/pages/screens_wrapper.dart';
import 'package:poetlum/features/authorization/domain/repository/auth_repository.dart';
import 'package:poetlum/features/authorization/presentation/pages/registration/registration_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthenticationRepository>();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return const RegistrationPage();
          }
          return const ScreensWrapper();
        }

        return const Scaffold(
          body: Center(
            child: Loader(text: 'Logging in...'),
          ),
        );
      },
    );
  }
}

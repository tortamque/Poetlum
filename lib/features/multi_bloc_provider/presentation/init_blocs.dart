import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/core/shared/presentation/bloc/credentials/credentials_bloc.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database/firebase_database_cubit.dart';
import 'package:poetlum/features/theme_change/presentation/bloc/change_theme_cubit.dart';

class InitBlocs extends StatelessWidget {
  const InitBlocs({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<RemotePoemBloc>(create: (context) => getIt()..add(const GetInitialPoemsEvent())),
      BlocProvider<AuthCubit>(create:(context) => getIt(),),
      BlocProvider<RegisterFormValidationCubit>(create:(context) => getIt()),
      BlocProvider<LoginFormValidationCubit>(create:(context) => getIt()),
      BlocProvider<FirebaseDatabaseCubit>(create: (context) => getIt()),
      BlocProvider<ThemeCubit>(create: (context) => getIt()),
      BlocProvider<CredentialsCubit>(create: (context) => getIt()),
    ],
    child: child,
  );
}

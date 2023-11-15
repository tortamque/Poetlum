import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:poetlum/config/theme/app_theme.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/features/application/presentation/widgets/AppBar/app_bar.dart';
import 'package:poetlum/features/authorization/presentation/bloc/registation/register_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/pages/login/login_page.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';

class PoetlumApp extends StatelessWidget {
  const PoetlumApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<RemotePoemBloc>(create: (context) => getIt()..add(const GetPoemsEvent())),
      BlocProvider<RegisterCubit>(create:(context) => getIt(),),
      BlocProvider<FormValidationCubit>(create:(context) => getIt()),
    ],
    child: GetMaterialApp(
      title: 'Poetlum',
      theme: theme(),
      home: LoginPage(),
    ),
  );
}

class PoetlumHomePage extends StatefulWidget {
  const PoetlumHomePage({super.key, required this.title});

  final String title;

  @override
  State<PoetlumHomePage> createState() => _PoetlumHomePageState();
}

class _PoetlumHomePageState extends State<PoetlumHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppBar(
      title: 'Poetlum',
    ),
    body: const Placeholder(),
  );
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/theme_change/presentation/bloc/change_theme_cubit.dart';

class InitTheme extends StatelessWidget {
  const InitTheme({super.key, required this.child});

  final Widget child;

  Future<void> initTheme(BuildContext context) async{
    final themeColor = await context.read<ThemeCubit>().getThemeColor();

    await context.read<ThemeCubit>().setThemeColor(themeColor: themeColor, needSave: false);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: initTheme(context), 
    builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }

      return child;
    },
  );
}
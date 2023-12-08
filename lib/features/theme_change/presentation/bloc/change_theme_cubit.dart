import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/config/theme/app_theme.dart';
import 'package:poetlum/features/theme_change/presentation/bloc/change_theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void setThemeColor(Color themeColor) {
    emit(
      ThemeState(
        themeData: theme(themeColor),
      ),
    );
  }
}

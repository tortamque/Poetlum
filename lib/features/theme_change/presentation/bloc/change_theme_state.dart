import 'package:flutter/material.dart';
import 'package:poetlum/config/theme/app_theme.dart';

class ThemeState {
  ThemeState({required this.themeData});

  factory ThemeState.initial() => ThemeState(
    themeData: theme(Colors.deepPurple),
  );

  final ThemeData themeData;
}

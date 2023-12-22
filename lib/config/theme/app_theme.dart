import 'package:flutter/material.dart';

ThemeData theme(Color color) => ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: color),
  useMaterial3: true,
);

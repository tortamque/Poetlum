import 'package:flutter/material.dart';
import 'package:poetlum/core/constants/shared_preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesService{
  Future<void> storeColor({required Color color});
  Future<Color> getColor();
}

class SharedPreferencesServiceImpl implements SharedPreferencesService{
  @override
  Future<void> storeColor({required Color color}) async {
    final prefs = await SharedPreferences.getInstance();

    final colorValue = color.value;

    await prefs.setInt(savedColorConstant, colorValue);
  }

  @override
  Future<Color> getColor() async {
    final prefs = await SharedPreferences.getInstance();

    final colorValue = prefs.getInt(savedColorConstant) ?? Colors.deepPurple.value;

    return Color(colorValue);
  }
}

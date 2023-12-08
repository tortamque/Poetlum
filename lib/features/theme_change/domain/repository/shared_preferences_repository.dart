import 'package:flutter/material.dart';

abstract class SharedPreferencesRepository{
  Future<void> storeColor({required Color color});
  Future<Color> getColor();
}

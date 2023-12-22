import 'dart:ui';

import 'package:poetlum/features/theme_change/data/data_sources/local/shared_preferences_service.dart';
import 'package:poetlum/features/theme_change/domain/repository/shared_preferences_repository.dart';

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository{
  SharedPreferencesRepositoryImpl(this._sharedPreferencesService);

  final SharedPreferencesService _sharedPreferencesService;

  @override
  Future<Color> getColor() async => _sharedPreferencesService.getColor();

  @override
  Future<void> storeColor({required Color color}) async => _sharedPreferencesService.storeColor(color: color);
}

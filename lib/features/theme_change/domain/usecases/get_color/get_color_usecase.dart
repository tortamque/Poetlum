import 'package:flutter/material.dart';
import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/theme_change/domain/repository/shared_preferences_repository.dart';

class GetColorUseCase implements UseCase<Color, void>{
  GetColorUseCase(this._sharedPreferencesRepository);

  final SharedPreferencesRepository _sharedPreferencesRepository;

  @override
  Future<Color> call({void params}) async => _sharedPreferencesRepository.getColor();
}

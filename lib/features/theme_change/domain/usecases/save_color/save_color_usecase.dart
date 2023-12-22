import 'package:flutter/material.dart';
import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/theme_change/domain/repository/shared_preferences_repository.dart';

class SaveColorUseCase implements UseCase<void, Color>{
  SaveColorUseCase(this._sharedPreferencesRepository);

  final SharedPreferencesRepository _sharedPreferencesRepository;
  
  @override
  Future<void> call({Color? params}) async {
    if(params != null){
      await _sharedPreferencesRepository.storeColor(color: params);
    }
  }
}

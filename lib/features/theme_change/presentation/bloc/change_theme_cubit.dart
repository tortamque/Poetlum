import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/config/theme/app_theme.dart';
import 'package:poetlum/features/theme_change/domain/usecases/get_color/get_color_usecase.dart';
import 'package:poetlum/features/theme_change/domain/usecases/save_color/save_color_usecase.dart';
import 'package:poetlum/features/theme_change/presentation/bloc/change_theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._saveColorUseCase, this._getColorUseCase) : super(ThemeState.initial());

  final SaveColorUseCase _saveColorUseCase;
  final GetColorUseCase _getColorUseCase;

  Future<void> setThemeColor({required Color themeColor, required bool needSave}) async {
    emit(
      ThemeState(
        themeData: theme(themeColor),
      ),
    );

    if(needSave){
      await _saveColorUseCase(params: themeColor);
    }
  }

  Future<Color> getThemeColor() async => _getColorUseCase();
}

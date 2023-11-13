

import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/registration/presentation/bloc/validation_state.dart';

class FormValidationCubit extends Cubit<FormValidationState> {
  FormValidationCubit() : super(const FormValidationState());

  void usernameChanged(String value) {
    final usernameValid = _isUsernameValid(value);
    
    emit(state.copyWith(
      username: value,
      isUsernameValid: usernameValid,
      isFormValid: usernameValid && state.isEmailValid && state.isPasswordValid,
    ),);
  }

  void emailChanged(String value) {
    final emailValid = _isEmailValid(value);

    emit(state.copyWith(
      email: value,
      isEmailValid: emailValid,
      isFormValid: state.isUsernameValid && emailValid && state.isPasswordValid,
    ),);
  }

  void passwordChanged(String value) {
    final passwordValid = _isPasswordValid(value);

    emit(state.copyWith(
      password: value,
      isPasswordValid: passwordValid,
      isFormValid: state.isUsernameValid && state.isEmailValid && passwordValid,
    ),);
  }

  bool _isUsernameValid(String username) => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username) && username.length <= 30;

  bool _isEmailValid(String email) => EmailValidator.validate(email) && email.length <= 40;

  bool _isPasswordValid(String password) => password.length >= 8 && password.length <= 20;
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/registration/presentation/bloc/validation/validation_state.dart';

class FormValidationCubit extends Cubit<FormValidationState> {
  FormValidationCubit() : super(const FormValidationState());

  void usernameChanged(String value) {
    final usernameValid = _isUsernameValid(value);
    late UsernameValidationStates validationResult;

    if(value.length < 5){
      validationResult = UsernameValidationStates.tooShort;
    } else if(value.length > 30){
      validationResult = UsernameValidationStates.tooLong;
    } else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)){
      validationResult = UsernameValidationStates.inappropriateChars;
    } else{
      validationResult = UsernameValidationStates.correct;
    }

    emit(state.copyWith(
      usernameValidationState: UsernameValidationState(
        username: value,
        isUsernameValid: usernameValid,
        state: validationResult,
      ),
    ),);
  }

  void emailChanged(String value) {
    final emailValid = _isEmailValid(value);
    late EmailValidationStates validationResult;

    if(!EmailValidator.validate(value)){
      validationResult = EmailValidationStates.wrongFormat;
    } else if(value.length > 40){
      validationResult = EmailValidationStates.tooLong;
    } else{
      validationResult = EmailValidationStates.correct;
    }

    emit(state.copyWith(
      emailValidationState: EmailValidationState(
        email: value,
        isEmailValid: emailValid,
        state: validationResult,
      ),
    ),);
  }

  void passwordChanged(String value) {
    final passwordValid = _isPasswordValid(value);
    late PasswordValidationStates validationResult;

    if(value.length < 8){
      validationResult = PasswordValidationStates.tooShort;
    } else if(value.length > 20){
      validationResult = PasswordValidationStates.tooLong;
    } else{
      validationResult = PasswordValidationStates.correct;
    }

    emit(state.copyWith(
      passwordValidationState: PasswordValidationState(
        password: value,
        isPasswordValid: passwordValid,
        state: validationResult,
      ),
    ),);
  }

  bool _isUsernameValid(String username) => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username) && username.length >= 5 && username.length <= 30;

  bool _isEmailValid(String email) => EmailValidator.validate(email) && email.length <= 40;

  bool _isPasswordValid(String password) => password.length >= 8 && password.length <= 20;
}

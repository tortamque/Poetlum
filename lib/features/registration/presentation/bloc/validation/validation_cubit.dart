import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/registration/presentation/bloc/validation/validation_state.dart';
import 'package:poetlum/features/registration/presentation/bloc/validation/validators.dart';

class FormValidationCubit extends Cubit<FormValidationState> {
  FormValidationCubit({
    required this.usernameValidator, 
    required this.emailValidator, 
    required this.passwordValidator,
  })
    : super(const FormValidationState());

  final Validator<String> usernameValidator;
  final Validator<String> emailValidator;
  final Validator<String> passwordValidator;

  void usernameChanged(String value) {
    final result = usernameValidator.validate(value);
    emit(state.copyWith(
      usernameValidationState: ValidationState(
        value: value,
        isValid: result.isValid,
        errorMessage: result.errorMessage,
      ),
    ),);
  }

  void emailChanged(String value) {
    final result = emailValidator.validate(value);
    emit(state.copyWith(
      emailValidationState: ValidationState(
        value: value,
        isValid: result.isValid,
        errorMessage: result.errorMessage,
      ),
    ),);
  }

  void passwordChanged(String value) {
    final result = passwordValidator.validate(value);
    emit(state.copyWith(
      passwordValidationState: ValidationState(
        value: value,
        isValid: result.isValid,
        errorMessage: result.errorMessage,
      ),
    ),);
  }
}

// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class AuthFormValidationState{
  final ValidationState emailValidationState = const ValidationState();
  final ValidationState passwordValidationState = const ValidationState();
  final bool isFormValid = false;
}

class LoginFormValidationState extends Equatable implements AuthFormValidationState{
  LoginFormValidationState({
    this.emailValidationState = const ValidationState(),
    this.passwordValidationState = const ValidationState(),
    bool? isFormValid,
  }) : isFormValid = isFormValid ?? 
                      emailValidationState.isValid &&
                      passwordValidationState.isValid;
  @override
  final ValidationState emailValidationState;
  @override
  final ValidationState passwordValidationState;
  @override
  final bool isFormValid;

  LoginFormValidationState copyWith({
    ValidationState? emailValidationState,
    ValidationState? passwordValidationState,
    bool? isFormValid,
  }) => LoginFormValidationState(
      emailValidationState: emailValidationState ?? this.emailValidationState,
      passwordValidationState: passwordValidationState ?? this.passwordValidationState,
      isFormValid: isFormValid ?? 
                  (emailValidationState ?? this.emailValidationState).isValid &&
                  (passwordValidationState ?? this.passwordValidationState).isValid,
    );

  @override
  List<Object?> get props => [
    emailValidationState,
    passwordValidationState,
    isFormValid,
  ];
}

class RegisterFormValidationState extends Equatable implements AuthFormValidationState{
  RegisterFormValidationState({
    this.emailValidationState = const ValidationState(),
    this.usernameValidationState = const ValidationState(),
    this.passwordValidationState = const ValidationState(),
    bool? isFormValid,
  }) : isFormValid = isFormValid ?? 
                      emailValidationState.isValid &&
                      usernameValidationState.isValid &&
                      passwordValidationState.isValid;
  final ValidationState usernameValidationState;
  @override
  final ValidationState emailValidationState;
  @override
  final ValidationState passwordValidationState;
  @override
  final bool isFormValid;

  RegisterFormValidationState copyWith({
    ValidationState? emailValidationState,
    ValidationState? usernameValidationState,
    ValidationState? passwordValidationState,
    bool? isFormValid,
  }) => RegisterFormValidationState(
      emailValidationState: emailValidationState ?? this.emailValidationState,
      usernameValidationState: usernameValidationState ?? this.usernameValidationState,
      passwordValidationState: passwordValidationState ?? this.passwordValidationState,
      isFormValid: isFormValid ?? 
                  (emailValidationState ?? this.emailValidationState).isValid &&
                  (usernameValidationState ?? this.usernameValidationState).isValid &&
                  (passwordValidationState ?? this.passwordValidationState).isValid,
    );

  @override
  List<Object?> get props => [
    emailValidationState,
    usernameValidationState,
    passwordValidationState,
    isFormValid,
  ];
}

class ValidationState extends Equatable {
  const ValidationState({
    this.value = '',
    this.isValid = false,
    this.errorMessage,
  });

  final String value;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [value, isValid, errorMessage];

  ValidationState copyWith({
    String? value,
    bool? isValid,
    String? errorMessage,
  })=> ValidationState(
      value: value ?? this.value,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
}

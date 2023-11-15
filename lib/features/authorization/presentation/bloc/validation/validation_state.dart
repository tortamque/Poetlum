// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class FormValidationState extends Equatable {
  FormValidationState({
    this.emailValidationState = const ValidationState(),
    this.usernameValidationState = const ValidationState(),
    this.passwordValidationState = const ValidationState(),
    bool? isFormValid,
  }) : isFormValid = isFormValid ?? 
                      emailValidationState.isValid &&
                      usernameValidationState.isValid &&
                      passwordValidationState.isValid;

  final ValidationState emailValidationState;
  final ValidationState usernameValidationState;
  final ValidationState passwordValidationState;
  final bool isFormValid;

  FormValidationState copyWith({
    ValidationState? emailValidationState,
    ValidationState? usernameValidationState,
    ValidationState? passwordValidationState,
    bool? isFormValid,
  }) => FormValidationState(
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

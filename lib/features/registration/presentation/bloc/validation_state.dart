import 'package:equatable/equatable.dart';


class FormValidationState extends Equatable {
  const FormValidationState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.isUsernameValid = false,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isFormValid = false,
  });

  final String username;
  final String email;
  final String password;
  final bool isUsernameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isFormValid;

  FormValidationState copyWith({
    String? username,
    String? email,
    String? password,
    bool? isUsernameValid,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isFormValid,
  }) => FormValidationState(
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
    isUsernameValid: isUsernameValid ?? this.isUsernameValid,
    isEmailValid: isEmailValid ?? this.isEmailValid,
    isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    isFormValid: isFormValid ?? this.isFormValid,
  );

  @override
  List<Object?> get props => [
    username,
    email,
    password,
    isUsernameValid,
    isEmailValid,
    isPasswordValid,
    isFormValid,
  ];
}

import 'package:equatable/equatable.dart';

class FormValidationState extends Equatable {
  const FormValidationState({
    this.emailValidationState = const EmailValidationState(),
    this.usernameValidationState = const UsernameValidationState(),
    this.passwordValidationState = const PasswordValidationState(),
    this.isFormValid = false,
  });

  final EmailValidationState emailValidationState;
  final UsernameValidationState usernameValidationState;
  final PasswordValidationState passwordValidationState;
  final bool isFormValid;

  FormValidationState copyWith({
    EmailValidationState? emailValidationState,
    UsernameValidationState? usernameValidationState,
    PasswordValidationState? passwordValidationState,
    bool? isFormValid,
  }) => FormValidationState(
    emailValidationState: emailValidationState ?? this.emailValidationState,
    usernameValidationState: usernameValidationState ?? this.usernameValidationState,
    passwordValidationState: passwordValidationState ?? this.passwordValidationState,
    isFormValid: isFormValid ?? this.isFormValid,
  );

  @override
  List<Object?> get props => [
    emailValidationState,
    usernameValidationState,
    passwordValidationState,
    isFormValid,
  ];
}

enum UsernameValidationStates{
  tooShort,
  tooLong,
  inappropriateChars,
  correct,
}

class UsernameValidationState extends Equatable {
  const UsernameValidationState({
    this.username = '',
    this.state = UsernameValidationStates.tooShort,
    this.isUsernameValid = false,
  });

  final String username;
  final UsernameValidationStates state;
  final bool isUsernameValid;

  @override
  List<Object?> get props => [username, state, isUsernameValid];

  UsernameValidationState copyWith({
    String? username,
    UsernameValidationStates? state,
    bool? isUsernameValid,
  }) => UsernameValidationState(
    username: username ?? this.username,
    state: state ?? this.state,
    isUsernameValid: isUsernameValid ?? this.isUsernameValid,
  );
}

enum PasswordValidationStates{
  tooShort,
  tooLong,
  correct,
}

class PasswordValidationState extends Equatable {
  const PasswordValidationState({
    this.password = '',
    this.state = PasswordValidationStates.tooShort,
    this.isPasswordValid = false,
  });

  final String password;
  final PasswordValidationStates state;
  final bool isPasswordValid;

  @override
  List<Object?> get props => [password, state, isPasswordValid];

  PasswordValidationState copyWith({
    String? password,
    PasswordValidationStates? state,
    bool? isPasswordValid,
  }) => PasswordValidationState(
    password: password ?? this.password,
    state: state ?? this.state,
    isPasswordValid: isPasswordValid ?? this.isPasswordValid,
  );
}

enum EmailValidationStates{
  wrongFormat,
  tooLong,
  correct,
}

class EmailValidationState extends Equatable {
  const EmailValidationState({
    this.email = '',
    this.state = EmailValidationStates.wrongFormat,
    this.isEmailValid = false,
  });

  final String email;
  final EmailValidationStates state;
  final bool isEmailValid;

  @override
  List<Object?> get props => [email, state, isEmailValid];

  EmailValidationState copyWith({
    String? email,
    EmailValidationStates? state,
    bool? isEmailValid,
  }) => EmailValidationState(
    email: email ?? this.email,
    state: state ?? this.state,
    isEmailValid: isEmailValid ?? this.isEmailValid,
  );
}

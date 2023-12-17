// ignore_for_file: avoid_positional_boolean_parameters

import 'package:email_validator/email_validator.dart';

abstract class Validator<T> {
  ValidationResult validate(T value);
}

class ValidationResult {
  ValidationResult(this.isValid, {this.errorMessage});

  final bool isValid;
  final String? errorMessage;
}

class UsernameValidator implements Validator<String> {
  @override
  ValidationResult validate(String value) {
    if (value.length < 5) return ValidationResult(false, errorMessage: 'Username is too short');
    if (value.length > 30) return ValidationResult(false, errorMessage: 'Username is too long');
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) return ValidationResult(false, errorMessage: 'Invalid characters in username');
    return ValidationResult(true);
  }
}

class LocalEmailValidator implements Validator<String> {
  @override
  ValidationResult validate(String value) {
    if (!EmailValidator.validate(value)) return ValidationResult(false, errorMessage: 'Email format is wrong');
    if (value.length > 40) return ValidationResult(false, errorMessage: 'Email is too long');
    return ValidationResult(true);
  }
}

class PasswordValidator implements Validator<String> {
  @override
  ValidationResult validate(String value) {
    if (value.length < 8) return ValidationResult(false, errorMessage: 'Password is too short');
    if (value.length > 20) return ValidationResult(false, errorMessage: 'Password is too long');
    return ValidationResult(true);
  }
}

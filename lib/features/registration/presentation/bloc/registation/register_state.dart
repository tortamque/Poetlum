import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, submitting, success, error }

class RegisterState extends Equatable {
  const RegisterState({
    this.status = RegisterStatus.initial,
    this.errorMessage,
  });

  final RegisterStatus status;
  final String? errorMessage;

  RegisterState copyWith({
    RegisterStatus? status,
    String? errorMessage,
  }) => RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );

  @override
  List<Object?> get props => [status, errorMessage];
}

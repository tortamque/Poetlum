import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, submitting, success, error }

class AuthState extends Equatable {
  const AuthState({
    this.status = RegisterStatus.initial,
    this.errorMessage,
  });

  final RegisterStatus status;
  final String? errorMessage;

  AuthState copyWith({
    RegisterStatus? status,
    String? errorMessage,
  }) => AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );

  @override
  List<Object?> get props => [status, errorMessage];
}

import 'package:equatable/equatable.dart';

enum AuthStatus { initial, submitting, success, error }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  final AuthStatus status;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
  }) => AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );

  @override
  List<Object?> get props => [status, errorMessage];
}

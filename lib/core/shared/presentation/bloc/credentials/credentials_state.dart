import 'package:equatable/equatable.dart';

enum CredentialsStatus{initial, submitting, success, error}

class CredentialsState extends Equatable{
  const CredentialsState({
    this.error,
    this.status = CredentialsStatus.initial,
  });

  final CredentialsStatus status;
  final String? error;

  CredentialsState copyWith({
    CredentialsStatus? status,
    String? error,
  }) => CredentialsState(
      status: status ?? this.status,
      error: error ?? this.error,
    );

  @override
  List<Object?> get props => [
    status,
  ];
}

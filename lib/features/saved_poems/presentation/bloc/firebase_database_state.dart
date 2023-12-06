import 'package:equatable/equatable.dart';

enum FirebaseDatabaseStatus{initial, submitting, success, error, needsRefresh}

class FirebaseDatabaseState extends Equatable{
  const FirebaseDatabaseState({
    this.status = FirebaseDatabaseStatus.initial,
  });

  final FirebaseDatabaseStatus status;

  FirebaseDatabaseState copyWith({
    FirebaseDatabaseStatus? status,
  }) => FirebaseDatabaseState(
      status: status ?? this.status,
    );

  @override
  List<Object?> get props => [
    status,
  ];
}

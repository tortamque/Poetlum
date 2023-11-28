import 'package:equatable/equatable.dart';

class FirebaseUserEntity extends Equatable{
  const FirebaseUserEntity({this.username, this.email, this.userId});

  final String? username;
  final String? email;
  final String? userId;

  @override
  List<Object?> get props => [
    username,
    email,
    userId
  ];
}

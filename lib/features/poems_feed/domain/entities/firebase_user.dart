import 'package:equatable/equatable.dart';

class FirebaseUserEntity extends Equatable{
  const FirebaseUserEntity({this.username, this.email});

  final String? username;
  final String? email;

  @override
  List<Object?> get props => [
    username,
    email,
  ];
}

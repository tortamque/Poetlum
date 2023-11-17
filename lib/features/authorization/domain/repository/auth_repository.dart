import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository{
  Stream<User?> get authStateChanges;
}

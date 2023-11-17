import 'package:firebase_auth/firebase_auth.dart';
import 'package:poetlum/features/authorization/domain/repository/auth_repository.dart';

class AuthenticationRepositoryImpl  implements AuthenticationRepository{
  @override
  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();
}

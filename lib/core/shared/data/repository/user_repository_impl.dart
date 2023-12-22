import 'package:firebase_auth/firebase_auth.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/data/models/firebase_user.dart';

class UserRepositoryImpl implements UserRepository{
  UserRepositoryImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  FirebaserUserModel getCurrentUser() {
    final firebaseUser = _firebaseAuth.currentUser;

    return FirebaserUserModel(username: firebaseUser?.displayName, email: firebaseUser?.email, userId: firebaseUser?.uid);
  }
}

import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseService{
  Future<void> registerUser({required String username, required String email, required String password});
}

class FirebaseServiceImpl implements FirebaseService{
  @override
  Future<void> registerUser({required String username, required String email, required String password}) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
  }
}

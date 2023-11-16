import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseService{
  Future<void> registerUser({required String username, required String email, required String password});
  Future<void> loginUser({required String email, required String password});
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
  
  @override
  Future<void> loginUser({required String email, required String password}) async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: password,
    );
  }
}

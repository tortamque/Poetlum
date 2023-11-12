import 'package:poetlum/features/registration/data/data_sources/remote/firebase_service.dart';
import 'package:poetlum/features/registration/domain/repository/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository{
  FirebaseRepositoryImpl(this._firebaseService);

  final FirebaseService _firebaseService;

  @override
  Future<void> registerUser({required String username, required String email, required String password}) async{
    await _firebaseService.registerUser(username: username, email: email, password: password);
  }
}

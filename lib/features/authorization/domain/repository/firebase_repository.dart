abstract class FirebaseRepository{
  Future<void> registerUser({required String username, required String email, required String password});
  Future<void> loginUser({required String email, required String password});
}

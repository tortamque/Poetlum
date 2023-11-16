import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/authorization/domain/repository/firebase_repository.dart';
import 'package:poetlum/features/authorization/domain/usecases/register/register_user_params.dart';

class RegisterUserUseCase implements UseCase<void, RegisterUserParams>{
  RegisterUserUseCase(this._firebaseRepository);

  final FirebaseRepository _firebaseRepository;
  
  @override
  Future<void> call({RegisterUserParams? params}) async{
    if(params != null){
      await _firebaseRepository.registerUser(username: params.username, email: params.email, password: params.password);
    }
  }
}

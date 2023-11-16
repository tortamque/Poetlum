import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/authorization/domain/repository/firebase_repository.dart';
import 'package:poetlum/features/authorization/domain/usecases/login/login_user_params.dart';

class LoginUserUseCase implements UseCase<void, LoginUserParams>{
  LoginUserUseCase(this._firebaseRepository);

  final FirebaseRepository _firebaseRepository;
  
  @override
  Future<void> call({LoginUserParams? params}) async{
    if(params != null){
      await _firebaseRepository.loginUser(email: params.email, password: params.password);
    }
  }
}

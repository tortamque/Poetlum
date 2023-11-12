import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/registration/domain/usecases/register_user_params.dart';
import 'package:poetlum/features/registration/domain/usecases/register_user_usecase.dart';

class RegisterCubit extends Cubit<void>{
  RegisterCubit(this._registerUserUseCase): super(null);
  
  final RegisterUserUseCase _registerUserUseCase;

  Future<void> register(
    String username, 
    String email, 
    String password,
    void Function() showPositiveToast,
    void Function(String error) showNegativeToast,
  ) async{
    if(username.isEmpty || email.isEmpty || password.isEmpty){
      showNegativeToast('Please fill in all required fields');
    } else{
      try{
        await _registerUserUseCase(
          params: RegisterUserParams(
            username: username, 
            email: email, 
            password: password,
          ),
        );

        showPositiveToast();
      } catch (e){
        showNegativeToast(e.toString());
      }
    }
  }
}

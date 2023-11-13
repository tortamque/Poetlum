import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/registration/domain/usecases/register_user_params.dart';
import 'package:poetlum/features/registration/domain/usecases/register_user_usecase.dart';
import 'package:poetlum/features/registration/presentation/bloc/registation/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUserUseCase) : super(const RegisterState());

  final RegisterUserUseCase _registerUserUseCase;

  Future<void> register(String username, String email, String password) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      emit(state.copyWith(status: RegisterStatus.error, errorMessage: 'Please fill in all required fields'));
      return;
    }

    emit(state.copyWith(status: RegisterStatus.submitting));

    try {
      await _registerUserUseCase(
        params: RegisterUserParams(username: username, email: email, password: password),
      );
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RegisterStatus.error, errorMessage: e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/authorization/domain/usecases/register_user_params.dart';
import 'package:poetlum/features/authorization/domain/usecases/register_user_usecase.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_state.dart';

class RegisterCubit extends Cubit<AuthState> {
  RegisterCubit(this._registerUserUseCase) : super(const AuthState());

  final RegisterUserUseCase _registerUserUseCase;

  Future<void> register({required String username, required String email, required String password}) async {
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

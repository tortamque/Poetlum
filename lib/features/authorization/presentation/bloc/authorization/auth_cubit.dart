import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/authorization/domain/usecases/login/login_user_params.dart';
import 'package:poetlum/features/authorization/domain/usecases/login/login_user_usecase.dart';
import 'package:poetlum/features/authorization/domain/usecases/register/register_user_params.dart';
import 'package:poetlum/features/authorization/domain/usecases/register/register_user_usecase.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._registerUserUseCase, this._loginUserUseCase) : super(const AuthState());

  final RegisterUserUseCase _registerUserUseCase;
  final LoginUserUseCase _loginUserUseCase;

  Future<void> login({required String email, required String password}) async{
    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: 'Please fill in all required fields'));
      return;
    }

    emit(state.copyWith(status: AuthStatus.submitting));

    try {
      await _loginUserUseCase(
        params: LoginUserParams(email: email, password: password),
      );
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> register({required String username, required String email, required String password}) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: 'Please fill in all required fields'));
      return;
    }

    emit(state.copyWith(status: AuthStatus.submitting));

    try {
      await _registerUserUseCase(
        params: RegisterUserParams(username: username, email: email, password: password),
      );
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }
}

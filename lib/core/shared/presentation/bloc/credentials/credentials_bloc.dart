import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/dependency_injection.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/core/shared/presentation/bloc/credentials/credentials_state.dart';

class CredentialsCubit extends Cubit<CredentialsState> {
  CredentialsCubit() : super(const CredentialsState());

  Future<void> changeEmail({required String newEmail, required String oldPassword}) async{
    emit(state.copyWith(status: CredentialsStatus.submitting));

    if(newEmail.isEmpty || oldPassword.isEmpty){
      emit(state.copyWith(status: CredentialsStatus.error, error: 'One of the fields is empty. Please fill in all fields'));
    }

    try{
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: getIt<UserRepository>().getCurrentUser().email!, 
            password: oldPassword,
          ),
        );
        await user.updateEmail(newEmail);
      }

      emit(state.copyWith(status: CredentialsStatus.success));
    } catch(e){
      emit(state.copyWith(status: CredentialsStatus.error, error: e.toString()));
    }
  }
}

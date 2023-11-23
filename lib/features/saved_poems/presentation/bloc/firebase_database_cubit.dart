import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_poems_usecase.dart';

class FirebaseDatabaseCubit extends Cubit<void> {
  FirebaseDatabaseCubit(this._getUserPoemsUseCase) : super(null);

  final GetUserPoemsUseCase _getUserPoemsUseCase;

  Future<void> getUserPoems(String userId) async{
    await _getUserPoemsUseCase(
      params: userId,
    );
  }
}

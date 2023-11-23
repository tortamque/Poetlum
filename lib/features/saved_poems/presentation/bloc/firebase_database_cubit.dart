import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_poems_usecase.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_state.dart';

class FirebaseDatabaseCubit extends Cubit<FirebaseDatabaseState> {
  FirebaseDatabaseCubit(this._getUserPoemsUseCase) : super(const FirebaseDatabaseState());

  final GetUserPoemsUseCase _getUserPoemsUseCase;

  Future<List<PoemEntity>?> getUserPoems(String userId) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    final poems = await _getUserPoemsUseCase(
      params: userId,
    );

    emit(state.copyWith(status: FirebaseDatabaseStatus.success));

    return poems;
  }
}

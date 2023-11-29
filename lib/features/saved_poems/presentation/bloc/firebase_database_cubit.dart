import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/data/models/collection.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_collections_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_poems_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/save_poem/save_custom_poem_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/save_poem/save_custom_poem_usecase.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_state.dart';

class FirebaseDatabaseCubit extends Cubit<FirebaseDatabaseState> {
  FirebaseDatabaseCubit(this._getUserPoemsUseCase, this._getUserCollectionsUseCase, this._saveCustomPoemUseCase) : super(const FirebaseDatabaseState());

  final GetUserPoemsUseCase _getUserPoemsUseCase;
  final GetUserCollectionsUseCase _getUserCollectionsUseCase;
  final SaveCustomPoemUseCase _saveCustomPoemUseCase;

  Future<List<PoemEntity>?> getUserPoems(String userId) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    final poems = await _getUserPoemsUseCase(
      params: userId,
    );

    emit(state.copyWith(status: FirebaseDatabaseStatus.success));

    return poems;
  }

  Future<List<CollectionEntity>?> getUserCollections(String userId) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    var collections = await _getUserCollectionsUseCase(
      params: userId,
    );

    collections ??= [];

    final poems = await _getUserPoemsUseCase(
      params: userId,
    );

    if(poems != null){
      collections.insert(0, CollectionModel(name: 'All saved poems', poems: poems));
    }
    
    emit(state.copyWith(status: FirebaseDatabaseStatus.success));

    return collections;
  }

  Future<void> saveCustomPoem({required String userId, required String username, required String title, required String text}) async {
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    try{
      await _saveCustomPoemUseCase(
        params: SaveCustomPoemParams(
          userId: userId,
          poemEntity: PoemEntity(
            author: username,
            linecount: text.split('\n').length,
            text: text,
            title: title,
          ),
        ),
      );

      emit(state.copyWith(status: FirebaseDatabaseStatus.success));
    } catch(e) {
      emit(state.copyWith(status: FirebaseDatabaseStatus.error));
    }
  }
}

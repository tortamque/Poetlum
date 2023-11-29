import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/data/models/collection.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_poem/delete_poem_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_poem/delete_poem_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_collections_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_poems_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_poem_exists/is_poem_exists_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_poem_exists/is_poem_exists_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/save_poem/save_poem_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/save_poem/save_poem_usecase.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_state.dart';

class FirebaseDatabaseCubit extends Cubit<FirebaseDatabaseState> {
  FirebaseDatabaseCubit(this._getUserPoemsUseCase, this._getUserCollectionsUseCase, this._savePoemUseCase, this._deletePoemUseCase, this._isPoemExistsUseCase) : super(const FirebaseDatabaseState());

  final GetUserPoemsUseCase _getUserPoemsUseCase;
  final GetUserCollectionsUseCase _getUserCollectionsUseCase;
  final SavePoemUseCase _savePoemUseCase;
  final DeletePoemUseCase _deletePoemUseCase;
  final IsPoemExistsUseCase _isPoemExistsUseCase;

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

  Future<void> savePoem({required String userId, required String username, required String title, required String text}) async {
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    try{
      await _savePoemUseCase(
        params: SavePoemParams(
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

  Future<void> deletePoem({required PoemEntity poemEntity, required String userId, String? collectionName}) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    try{
      await _deletePoemUseCase(
        params: DeletePoemParams(
          userId: userId,
          collectionName: collectionName,
          poemEntity: poemEntity,
        ),
      );

      emit(state.copyWith(status: FirebaseDatabaseStatus.success));
    } catch(e) {
      emit(state.copyWith(status: FirebaseDatabaseStatus.error));
    }
  }

  Future<bool> isPoemExists({required PoemEntity poemEntity, required String userId, String? collectionName}) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    try{
      final isExists = await _isPoemExistsUseCase(
        params: IsPoemExistsParams(poemEntity: poemEntity, userId: userId),
      );

      emit(state.copyWith(status: FirebaseDatabaseStatus.success));

      return isExists;
    } catch(e) {
      emit(state.copyWith(status: FirebaseDatabaseStatus.error));

      return false;
    }
  }
}

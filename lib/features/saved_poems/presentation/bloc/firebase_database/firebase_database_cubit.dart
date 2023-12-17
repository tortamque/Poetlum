import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/data/models/collection.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/create_new_collection/create_new_collection_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/create_new_collection/create_new_collection_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_collection/delete_collection_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_collection/delete_collection_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_poem/delete_poem_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_poem/delete_poem_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_poem_from_collection/delete_poem_from_collection_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_poem_from_collection/delete_poem_from_collection_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_poems_in_collection/get_poems_in_collection_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_poems_in_collection/get_poems_in_collection_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_collections/get_user_collections_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_poems/get_user_poems_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_collection_exists/is_collection_exists_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_collection_exists/is_collection_exists_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_poem_exists/is_poem_exists_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_poem_exists/is_poem_exists_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_poem_exists_by_name/is_poem_exists_by_name_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_poem_exists_by_name/is_poem_exists_by_name_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/save_poem/save_poem_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/save_poem/save_poem_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/update_poems_in_collection/update_poems_in_collection_params.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/update_poems_in_collection/update_poems_in_collection_usecase.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database/firebase_database_state.dart';

class FirebaseDatabaseCubit extends Cubit<FirebaseDatabaseState> {
  FirebaseDatabaseCubit(this._getUserPoemsUseCase, this._getUserCollectionsUseCase, this._savePoemUseCase, this._deletePoemUseCase, this._isPoemExistsUseCase, this._createNewCollectionUseCase, this._deleteCollectionUseCase, this._deletePoemFromCollectionUseCase, this._updatePoemsInCollectionUseCase, this._getPoemsInCollectionUseCase, this._isCollectionExistsUseCase, this._isPoemExistsByNameUseCase) : super(const FirebaseDatabaseState());

  final GetUserPoemsUseCase _getUserPoemsUseCase;
  final GetUserCollectionsUseCase _getUserCollectionsUseCase;
  final SavePoemUseCase _savePoemUseCase;
  final DeletePoemUseCase _deletePoemUseCase;
  final IsPoemExistsUseCase _isPoemExistsUseCase;
  final CreateNewCollectionUseCase _createNewCollectionUseCase;
  final DeleteCollectionUseCase _deleteCollectionUseCase;
  final DeletePoemFromCollectionUseCase _deletePoemFromCollectionUseCase;
  final UpdatePoemsInCollectionUseCase _updatePoemsInCollectionUseCase;
  final GetPoemsInCollectionUseCase _getPoemsInCollectionUseCase;
  final IsCollectionExistsUseCase _isCollectionExistsUseCase;
  final IsPoemExistsByNameUseCase _isPoemExistsByNameUseCase;

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
      collections.insert(0, CollectionModel(name: 'All saved poems', poems: poems, isAllSavedPoems: true));
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

  Future<bool> isPoemExistsByName({required String poemTitle, required String userId, String? collectionName}) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    try{
      final isExists = await _isPoemExistsByNameUseCase(
        params: IsPoemExistsByNameParams(poemTitle: poemTitle, userId: userId),
      );

      if(isExists){
        emit(state.copyWith(status: FirebaseDatabaseStatus.error));
      } else{
        emit(state.copyWith(status: FirebaseDatabaseStatus.success));
      }

      return isExists;
    } catch(e) {
      emit(state.copyWith(status: FirebaseDatabaseStatus.error));

      return false;
    }
  }

  Future<void> createNewCollection({required String userId, required String collectionName, required List<PoemEntity> poems}) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    try{
      await _createNewCollectionUseCase(
        params: CreateNewCollectionParams(
          userId: userId, 
          collectionName: collectionName, 
          poems: poems,
        ),
      );

      emit(state.copyWith(status: FirebaseDatabaseStatus.success));
      emit(state.copyWith(status: FirebaseDatabaseStatus.needsRefresh));
    } catch(e) {
      emit(state.copyWith(status: FirebaseDatabaseStatus.error));
    }
  }

  Future<void> deleteCollection({required String userId, required String collectionName, required List<PoemEntity> poems}) async{
    try{
      await _deleteCollectionUseCase(
        params: DeleteCollectionParams(
          userId: userId, 
          collectionName: collectionName, 
          poems: poems,
        ),
      );
    } catch(e) {
      emit(state.copyWith(status: FirebaseDatabaseStatus.error));
    }
  }

  Future<void> deletePoemFromCollection({required PoemEntity poemEntity, required String userId, String? collectionName}) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    try{
      await _deletePoemFromCollectionUseCase(
        params: DeletePoemFromCollectionParams(
          userId: userId,
          collectionName: collectionName,
          poemEntity: poemEntity,
        ),
      );

      emit(state.copyWith(status: FirebaseDatabaseStatus.success));
      emit(state.copyWith(status: FirebaseDatabaseStatus.needsRefresh));
    } catch(e) {
      emit(state.copyWith(status: FirebaseDatabaseStatus.error));
    }
  }

  Future<void> updatePoemsInCollection({required String userId, required String collectionName, required List<PoemEntity> updatedPoems}) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    try{
      await _updatePoemsInCollectionUseCase(
        params: UpdatePoemsInCollectionParams(
          userId: userId, 
          collectionName: collectionName, 
          updatedPoems: updatedPoems,
        ),
      );
      emit(state.copyWith(status: FirebaseDatabaseStatus.success));
      emit(state.copyWith(status: FirebaseDatabaseStatus.needsRefresh));
    } catch(e) {
      emit(state.copyWith(status: FirebaseDatabaseStatus.error));
    }
  }

  Future<List<PoemEntity>> getPoemsInCollection({required String userId, String? collectionName}) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    try{
      final result = await _getPoemsInCollectionUseCase(
        params: GetPoemsInCollectionParams(
          userId: userId, 
          collectionName: collectionName, 
        ),
      );

      emit(state.copyWith(status: FirebaseDatabaseStatus.success));

      return result;
    } catch(e) {
      emit(state.copyWith(status: FirebaseDatabaseStatus.error));

      return <PoemEntity>[];
    }
  }

  Future<bool> isCollectionExists({required String collectionName, required String userId}) async{
    emit(state.copyWith(status: FirebaseDatabaseStatus.submitting));

    try{
      final isExists = await _isCollectionExistsUseCase(
        params: IsCollectionExistsParams(collectionName: collectionName, userId: userId),
      );

      emit(state.copyWith(status: FirebaseDatabaseStatus.success));

      return isExists;
    } catch(e) {
      emit(state.copyWith(status: FirebaseDatabaseStatus.error));

      return false;
    }
  }
}

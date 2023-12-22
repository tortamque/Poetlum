import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_poem_from_collection/delete_poem_from_collection_params.dart';

class DeletePoemFromCollectionUseCase implements UseCase<void, DeletePoemFromCollectionParams>{
  DeletePoemFromCollectionUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<void> call({DeletePoemFromCollectionParams? params}) async {
    if(params != null){
      await _databaseRepository.deletePoemFromCollection(
        poemToDelete: params.poemEntity,
        userId: params.userId, 
        collectionName: params.collectionName,
      );
    }
  }
}

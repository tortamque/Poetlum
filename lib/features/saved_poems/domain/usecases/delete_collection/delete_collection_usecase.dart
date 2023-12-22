import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_collection/delete_collection_params.dart';

class DeleteCollectionUseCase implements UseCase<void, DeleteCollectionParams>{
  DeleteCollectionUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<void> call({DeleteCollectionParams? params}) async {
    if(params != null){
      await _databaseRepository.deleteCollection(
        userId: params.userId, 
        collectionName: params.collectionName, 
        poems: params.poems,
      );
    }
  }
}

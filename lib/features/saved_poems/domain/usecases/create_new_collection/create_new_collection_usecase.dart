import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/create_new_collection/create_new_collection_params.dart';

class CreateNewCollectionUseCase implements UseCase<void, CreateNewCollectionParams>{
  CreateNewCollectionUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<void> call({CreateNewCollectionParams? params}) async {
    if(params != null){
      await _databaseRepository.createNewCollection(
        userId: params.userId, 
        collectionName: params.collectionName, 
        poems: params.poems,
      );
    }
  }
}

import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/update_poems_in_collection/update_poems_in_collection_params.dart';

class UpdatePoemsInCollectionUseCase implements UseCase<void, UpdatePoemsInCollectionParams>{
  UpdatePoemsInCollectionUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<void> call({UpdatePoemsInCollectionParams? params}) async {
    if(params != null){
      await _databaseRepository.updatePoemsInCollection(
        userId: params.userId, 
        collectionName: params.collectionName, 
        updatedPoems: params.updatedPoems,
      );
    }
  }
}

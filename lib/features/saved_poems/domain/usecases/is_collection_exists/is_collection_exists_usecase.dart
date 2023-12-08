import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_collection_exists/is_collection_exists_params.dart';

class IsCollectionExistsUseCase implements UseCase<void, IsCollectionExistsParams>{
  IsCollectionExistsUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<bool> call({IsCollectionExistsParams? params}) async {
    if(params != null){
      final result = await _databaseRepository.isCollectionExists(
        collectionName: params.collectionName, 
        userId: params.userId,
      );

      return result;
    }

    return false;
  }
}

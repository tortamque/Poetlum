import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_poems_in_collection/get_poems_in_collection_params.dart';

class GetPoemsInCollectionUseCase implements UseCase<void, GetPoemsInCollectionParams>{
  GetPoemsInCollectionUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<List<PoemEntity>> call({GetPoemsInCollectionParams? params}) async {
    if(params != null){
      final result = await _databaseRepository.getPoemsInCollection(
        userId: params.userId, 
        collectionName: params.collectionName,
      );

      return result;
    }

    return <PoemEntity>[];
  }
}

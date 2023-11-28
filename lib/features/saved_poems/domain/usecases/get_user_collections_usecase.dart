import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';

class GetUserCollectionsUseCase implements UseCase<List<CollectionEntity>?, String>{
  GetUserCollectionsUseCase(this._databaseRepository);

  final FirebaseDatabaseRepository _databaseRepository;

  @override
  Future<List<CollectionEntity>?> call({String? params}) async {
    if(params != null){
      return _databaseRepository.getUserCollections(params);
    }
    return null;
  }
}

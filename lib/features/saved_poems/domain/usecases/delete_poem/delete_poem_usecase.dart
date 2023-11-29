import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_poem/delete_poem_params.dart';

class DeletePoemUseCase implements UseCase<void, DeletePoemParams>{
  DeletePoemUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<void> call({DeletePoemParams? params}) async {
    if(params != null){
      await _databaseRepository.deletePoem(
        poemEntity: params.poemEntity, 
        userId: params.userId, 
        collectionName: params.collectionName,
      );
    }
  }
}

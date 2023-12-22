import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_poem_exists/is_poem_exists_params.dart';

class IsPoemExistsUseCase implements UseCase<void, IsPoemExistsParams>{
  IsPoemExistsUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<bool> call({IsPoemExistsParams? params}) async {
    if(params != null){
      final result = await _databaseRepository.isPoemExists(poemEntity: params.poemEntity, userId: params.userId);

      return result;
    }

    return false;
  }
}

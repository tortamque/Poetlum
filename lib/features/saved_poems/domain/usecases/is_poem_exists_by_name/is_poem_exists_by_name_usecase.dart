import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_poem_exists_by_name/is_poem_exists_by_name_params.dart';

class IsPoemExistsByNameUseCase implements UseCase<void, IsPoemExistsByNameParams>{
  IsPoemExistsByNameUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<bool> call({IsPoemExistsByNameParams? params}) async {
    if(params != null){
      final result = await _databaseRepository.isPoemExistsByName(poemTitle: params.poemTitle, userId: params.userId);

      return result;
    }

    return false;
  }
}

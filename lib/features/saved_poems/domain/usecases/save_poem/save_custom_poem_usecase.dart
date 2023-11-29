import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/save_poem/save_custom_poem_params.dart';

class SaveCustomPoemUseCase implements UseCase<void, SaveCustomPoemParams>{
  SaveCustomPoemUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<void> call({SaveCustomPoemParams? params}) async {
    if(params != null){
      await _databaseRepository.saveCustomPoem(
        poemEntity: params.poemEntity,
        userId: params.userId,
      );
    }
  }
}

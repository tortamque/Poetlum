import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/save_poem/save_poem_params.dart';

class SavePoemUseCase implements UseCase<void, SavePoemParams>{
  SavePoemUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<void> call({SavePoemParams? params}) async {
    if(params != null){
      await _databaseRepository.savePoem(
        poemEntity: params.poemEntity,
        userId: params.userId,
      );
    }
  }
}

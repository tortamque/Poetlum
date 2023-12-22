import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';

class GetUserPoemsUseCase implements UseCase<List<PoemEntity>?, String>{
  GetUserPoemsUseCase(this._databaseRepository);

  final FirebaseDatabaseRepository _databaseRepository;

  @override
  Future<List<PoemEntity>?> call({String? params}) async {
    if(params != null){
      return _databaseRepository.getUserPoems(params);
    }
    return null;
  }
}

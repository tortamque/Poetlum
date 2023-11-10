import 'package:poetlum/core/resources/data_state.dart';
import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/poem_repository.dart';

class GetPoemsUseCase implements UseCase<DataState<List<PoemEntity>>, void>{
  GetPoemsUseCase(this._poemRepository);

  final PoemRepository _poemRepository;
  
  @override
  Future<DataState<List<PoemEntity>>> call({void params}) => _poemRepository.getPoems();
}
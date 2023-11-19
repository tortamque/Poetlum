import 'package:poetlum/core/resources/data_state.dart';
import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/poem_repository.dart';

class GetInitialPoemsUseCase implements UseCase<DataState<List<PoemEntity>>, void>{
  GetInitialPoemsUseCase(this._poemRepository);

  final PoemRepository _poemRepository;
  
  @override
  Future<DataState<List<PoemEntity>>> call({void params}) => _poemRepository.getInitialPoems();
}

class GetPoemsUseCaseParams {
  const GetPoemsUseCaseParams({
    required this.author,
    required this.title,
    required this.lineCount,
    required this.poemCount,
  });

  final String author;
  final String title;
  final String lineCount;
  final String poemCount;
}

class GetPoemsUseCase implements UseCase<DataState<List<PoemEntity>>, GetPoemsUseCaseParams>{
  GetPoemsUseCase(this._poemRepository);

  final PoemRepository _poemRepository;
  
  @override
  Future<DataState<List<PoemEntity>>> call({GetPoemsUseCaseParams? params}){
    if(
      params == null ||
      (
        params.author == '' &&
        params.title == '' &&
        params.lineCount == '' &&
        params.poemCount == '' 
      )
    ){
      return _poemRepository.getInitialPoems();
    } else{
      return _poemRepository.getPoems(
        author: params.author,
        title: params.title,
        lineCount: params.lineCount,
        poemCount: params.poemCount,
      );
    }
  }
}

import 'package:poetlum/core/usecases/usecase.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/edit_poem/edit_poem_params.dart';

class EditPoemUseCase implements UseCase<void, EditPoemParams>{
  EditPoemUseCase(this._databaseRepository);
  
  final FirebaseDatabaseRepository _databaseRepository;
  
  @override
  Future<void> call({EditPoemParams? params}) async {
    if(params != null){
      print('params ${params.collectionName}');
      await _databaseRepository.editPoem(
        oldAuthor: params.oldPoemEntity.author ?? '',
        oldTitle: params.oldPoemEntity.title ?? '',
        oldText: params.oldPoemEntity.text ?? '',
        oldLineCount: params.oldPoemEntity.linecount ?? 0,
        newAuthor: params.newPoemEntity.author ?? '',
        newTitle: params.newPoemEntity.title ?? '',
        newText: params.newPoemEntity.text ?? '',
        newLineCount: params.newPoemEntity.linecount ?? 0,
        collectionName: params.collectionName,
        userId: params.userId,
      );
    }
  }
}

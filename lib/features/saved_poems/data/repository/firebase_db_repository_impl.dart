import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/data/data_sources/remote/firebase_api_service.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';

class FirebaseDatabaseRepositoryImpl implements FirebaseDatabaseRepository{
  FirebaseDatabaseRepositoryImpl(this._databaseService);

  final FirebaseDatabaseService _databaseService;

  @override
  Future<List<PoemEntity>?> getUserPoems(String userId) async => _databaseService.getUserPoems(userId);
}
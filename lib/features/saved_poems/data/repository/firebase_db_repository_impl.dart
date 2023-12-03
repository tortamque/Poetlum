import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/data/data_sources/remote/firebase_api_service.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';

class FirebaseDatabaseRepositoryImpl implements FirebaseDatabaseRepository{
  FirebaseDatabaseRepositoryImpl(this._databaseService);

  final FirebaseDatabaseService _databaseService;

  @override
  Future<List<PoemEntity>?> getUserPoems(String userId) async => _databaseService.getUserPoems(userId);

  @override
  Future<List<CollectionEntity>?> getUserCollections(String userId) async => _databaseService.getUserCollections(userId);
  
  @override
  Future<void> savePoem({required String userId, required PoemEntity poemEntity}) => _databaseService.savePoem(userId: userId, poemEntity: poemEntity);
  
  @override
  Future<void> deletePoem({required PoemEntity poemEntity, required String userId, String? collectionName}) => _databaseService.deletePoem(poemEntity: poemEntity, userId: userId, collectionName: collectionName);
  
  @override
  Future<bool> isPoemExists({required PoemEntity poemEntity, required String userId}) => _databaseService.isPoemExists(poemEntity: poemEntity, userId: userId);
  
  @override
  Future<void> createNewCollection({required String userId, required String collectionName, required List<PoemEntity> poems}) => _databaseService.createNewCollection(userId: userId, collectionName: collectionName, poems: poems);
}

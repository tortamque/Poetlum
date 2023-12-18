import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';

abstract class FirebaseDatabaseRepository {
  Future<List<PoemEntity>?> getUserPoems(String userId);
  Future<List<CollectionEntity>?> getUserCollections(String userId);
  Future<void> savePoem({required String userId, required PoemEntity poemEntity});
  Future<void> deletePoem({required PoemEntity poemEntity, required String userId, String? collectionName});
  Future<bool> isPoemExists({required PoemEntity poemEntity, required String userId});
  Future<bool> isPoemExistsByName({required String poemTitle, required String userId});
  Future<void> createNewCollection({required String userId, required String collectionName, required List<PoemEntity> poems});
  Future<void> deleteCollection({required String userId, required String collectionName, required List<PoemEntity> poems});
  Future<void> deletePoemFromCollection({required String userId, String? collectionName, required PoemEntity poemToDelete});
  Future<void> updatePoemsInCollection({required String userId, required String collectionName, required List<PoemEntity> updatedPoems});
  Future<List<PoemEntity>> getPoemsInCollection({required String userId, String? collectionName});
  Future<bool> isCollectionExists({required String userId, required String collectionName});
}

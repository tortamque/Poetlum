import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';

abstract class FirebaseDatabaseRepository {
  Future<List<PoemEntity>?> getUserPoems(String userId);
  Future<List<CollectionEntity>?> getUserCollections(String userId);
  Future<void> savePoem({required String userId, required PoemEntity poemEntity});
  Future<void> deletePoem({required PoemEntity poemEntity, required String userId, String? collectionName});
  Future<bool> isPoemExists({required PoemEntity poemEntity, required String userId});
}

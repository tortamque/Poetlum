import 'package:firebase_database/firebase_database.dart';
import 'package:poetlum/features/poems_feed/data/models/poem.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/data/models/collection.dart';

abstract class FirebaseDatabaseService{
  Future<List<PoemModel>?> getUserPoems(String userId);
  Future<List<CollectionModel>?> getUserCollections(String userId);
  Future<void> saveCustomPoem({required String userId, required PoemEntity poemEntity});
}

class FirebaseDatabaseServiceImpl implements FirebaseDatabaseService {
  @override
  Future<List<PoemModel>?> getUserPoems(String userId) async {
    final ref = FirebaseDatabase.instance.ref('$userId/poems');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final poems = <PoemModel>[];

      
      for (final child in snapshot.children) {
        final poemData = Map<String, dynamic>.from(child.value as Map);
        
        poems.add(PoemModel.fromFirebase(poemData));
      }

      return poems;
    } else {
      return null;
    }
  }
  
  @override
  Future<List<CollectionModel>?> getUserCollections(String userId) async{
    final ref = FirebaseDatabase.instance.ref('$userId/collections');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final collections = <CollectionModel>[];

      
      for (final child in snapshot.children) {
        final collectionData = Map<String, dynamic>.from(child.value as Map);
        
        collections.add(CollectionModel.fromFirebase(collectionData));
      }

      return collections;
    } else {
      return null;
    }
  }
  
  @override
  Future<void> saveCustomPoem({required String userId, required PoemEntity poemEntity}) async{
    final poemsRef = FirebaseDatabase.instance.ref().child('$userId/poems');

    await poemsRef.push().set(poemEntity.toJson());
  }
}

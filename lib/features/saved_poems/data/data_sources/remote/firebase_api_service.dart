// ignore_for_file: avoid_dynamic_calls, cascade_invocations

import 'package:firebase_database/firebase_database.dart';
import 'package:poetlum/features/poems_feed/data/models/poem.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';
import 'package:poetlum/features/saved_poems/data/models/collection.dart';

abstract class FirebaseDatabaseService{
  Future<List<PoemModel>?> getUserPoems(String userId);
  Future<List<CollectionModel>?> getUserCollections(String userId);
  Future<void> savePoem({required String userId, required PoemEntity poemEntity});
  Future<void> deletePoem({required PoemEntity poemEntity, required String userId, required String? collectionName});
  Future<bool> isPoemExists({required PoemEntity poemEntity, required String userId});
  Future<void> createNewCollection({required String userId, required String collectionName, required List<PoemEntity> poems});
  Future<void> deleteCollection({required String userId, required String collectionName, required List<PoemEntity> poems});
  Future<void> deletePoemFromCollection({required String userId, String? collectionName, required PoemEntity poemToDelete});
  Future<void> updatePoemsInCollection({required String userId, required String collectionName, required List<PoemEntity> updatedPoems});
  Future<List<PoemEntity>> getPoemsInCollection({required String userId, required String collectionName});
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
  Future<void> savePoem({required String userId, required PoemEntity poemEntity}) async{
    final poemsRef = FirebaseDatabase.instance.ref().child('$userId/poems');

    await poemsRef.push().set(poemEntity.toJson());
  }
  
  @override
  Future<void> deletePoem({required PoemEntity poemEntity, required String userId, required String? collectionName}) async {
  final userRef = FirebaseDatabase.instance.ref(userId);

  await _deletePoemFromNode(userRef.child('poems'), poemEntity);

  if (collectionName != null) {
    final collectionsRef = userRef.child('collections');
    final collectionsSnapshot = await collectionsRef.get();

    if (collectionsSnapshot.exists) {
      final collections = collectionsSnapshot.value as Map<dynamic, dynamic>;
      for (final key in collections.keys) {
        final value = collections[key];
        if (value['name'] == collectionName && value['poems'] != null) {
          await _deletePoemFromNode(collectionsRef.child('$key/poems'), poemEntity);
        }
      }
    }
  }
}

  Future<void> _deletePoemFromNode(DatabaseReference nodeRef, PoemEntity poemEntity) async {
    final poemQuery = nodeRef.orderByChild('title').equalTo(poemEntity.title);
    final snapshot = await poemQuery.get();
    if (snapshot.exists) {
      final poems = snapshot.value as Map<dynamic, dynamic>;
      for (var key in poems.keys) {
        final value = poems[key];
        if (value['author'] == poemEntity.author && value['text'] == poemEntity.text) {
          await nodeRef.child(key).remove();
        }
      }
    }
  }

  @override
  Future<bool> isPoemExists({required PoemEntity poemEntity, required String userId}) async {
    final poemsRef = FirebaseDatabase.instance.ref('$userId/poems');
    
    final query = poemsRef.orderByChild('title').equalTo(poemEntity.title);
    final snapshot = await query.get();

    if (snapshot.exists) {
      final poems = snapshot.value as Map<dynamic, dynamic>;
      for (final poem in poems.values) {
        if (poem['author'] == poemEntity.author && poem['text'] == poemEntity.text) {
          return true; 
        }
      }
    }
    return false; 
  }
  
  @override
  Future<void> createNewCollection({required String userId, required String collectionName, required List<PoemEntity> poems}) async{
    final collectionsRef = FirebaseDatabase.instance.ref('$userId/collections');

    final poemsJson = poems.map((poem) => poem.toJson()).toList();

    final newCollectionData = {
      'name': collectionName,
      'poems': poemsJson,
    };

    await collectionsRef.push().set(newCollectionData);
  }

  @override
  Future<void> deleteCollection({required String userId, required String collectionName, required List<PoemEntity> poems}) async {
    final userRef = FirebaseDatabase.instance.ref(userId);
    final collectionsRef = userRef.child('collections');

    final collectionsSnapshot = await collectionsRef.get();

    if (!collectionsSnapshot.exists) {
      return;
    }

    final collections = collectionsSnapshot.value as Map<dynamic, dynamic>;
    var collectionDeleted = false;

    collections.forEach((key, value) {
      if (collectionDeleted) return;

      if (value['name'] == collectionName) {
        final collectionPoemsJson = value['poems'] as List<dynamic>?;
        
        if (collectionPoemsJson == null || collectionPoemsJson.isEmpty) {
          collectionsRef.child(key).remove();
          collectionDeleted = true;
        } else {
          final collectionPoems = collectionPoemsJson
              .map((poem) {
                final poemData = Map<String, dynamic>.from(poem as Map);
                final poemModel = PoemModel.fromFirebase(poemData);
                return poemModel;
              })
              .toList();

          if (_arePoemListsEqual(collectionPoems, poems)) {
            collectionsRef.child(key).remove();
            collectionDeleted = true;
          }
        }
      }
    });
  }

  bool _arePoemListsEqual(List<PoemEntity> list1, List<PoemEntity> list2) {
    if (list1.length != list2.length) return false;

    for (final poem in list1) {
      if (!list2.any((p) => _isPoemEqual(p, poem))) {
        return false;
      }
    }
    return true;
  }

  bool _isPoemEqual(PoemEntity poem1, PoemEntity poem2) => 
    poem1.title == poem2.title &&
    poem1.author == poem2.author &&
    poem1.text == poem2.text &&
    poem1.linecount == poem2.linecount;

  @override
  Future<void> deletePoemFromCollection({required String userId, String? collectionName, required PoemEntity poemToDelete}) async {
    final userRef = FirebaseDatabase.instance.ref(userId);

    if (collectionName == null) {
      final poemsRef = userRef.child('poems');
      final poemQuery = poemsRef.orderByChild('title').equalTo(poemToDelete.title);

      final snapshot = await poemQuery.get();
      if (snapshot.exists) {
        final poems = snapshot.value as Map<dynamic, dynamic>;
        poems.forEach((key, value) {
          final poemData = Map<String, dynamic>.from(value as Map);
          final poemModel = PoemModel.fromFirebase(poemData);

          if (_isPoemEqual(poemModel, poemToDelete)) {
            poemsRef.child(key).remove();
          }
        });
      }
    } else {
      final collectionsRef = userRef.child('collections');
      final collectionsSnapshot = await collectionsRef.get();

      if (!collectionsSnapshot.exists) {
        return;
      }

      final collections = collectionsSnapshot.value as Map<dynamic, dynamic>;
      
      for (final key in collections.keys) {
        final value = collections[key];
        if (value['name'] == collectionName && value['poems'] != null) {
          final collectionPoemsRef = collectionsRef.child('$key/poems');
          final collectionPoemsSnapshot = await collectionPoemsRef.get();

          if (collectionPoemsSnapshot.exists) {
            final collectionPoems = collectionPoemsSnapshot.value as List<Object?>;
            final updatedPoems = collectionPoems.where((poemData) {
              if (poemData == null) return false; 

              final poemModel = PoemModel.fromFirebase(Map<String, dynamic>.from(poemData as Map));
              
              return !_isPoemEqual(poemModel, poemToDelete);
            }).toList();

            await collectionPoemsRef.set(updatedPoems);
          }
        }
      }
    }
  }

  @override
  Future<void> updatePoemsInCollection({required String userId, required String collectionName, required List<PoemEntity> updatedPoems}) async {
    final userRef = FirebaseDatabase.instance.ref(userId);
    final collectionsRef = userRef.child('collections');

    final collectionsSnapshot = await collectionsRef.get();

    if (!collectionsSnapshot.exists) {
      return;
    }

    final collections = collectionsSnapshot.value as Map<dynamic, dynamic>;

    String? targetCollectionKey;
    for (var key in collections.keys) {
      final collectionData = collections[key];
      if (collectionData['name'] == collectionName) {
        targetCollectionKey = key;
        break;
      }
    }

    if (targetCollectionKey != null) {
      final updatedPoemsData = updatedPoems.map((poem) => {
        'author': poem.author,
        'linecount': poem.linecount,
        'text': poem.text,
        'title': poem.title
      }).toList();

      await collectionsRef.child('$targetCollectionKey/poems').set(updatedPoemsData);
    }
  }

  @override
  Future<List<PoemEntity>> getPoemsInCollection({required String userId, required String collectionName}) async {
    final userRef = FirebaseDatabase.instance.ref(userId);
    final collectionsRef = userRef.child('collections');

    final collectionsSnapshot = await collectionsRef.get();

    if (!collectionsSnapshot.exists) {
      return [];
    }

    final collections = collectionsSnapshot.value as Map<dynamic, dynamic>;
    var poems = <PoemEntity>[];
    

    for (final key in collections.keys) {
      final collectionData = collections[key];
      if (collectionData['name'] == collectionName && collectionData['poems'] != null) {
        final poemsData = collectionData['poems'] as List<dynamic>;
        poems = poemsData.map((poemJson) {
          final poemMap = Map<String, dynamic>.from(poemJson as Map);
          return PoemModel.fromFirebase(poemMap);
        }).toList();
        break;
      }
    }

    return poems;
  }
}

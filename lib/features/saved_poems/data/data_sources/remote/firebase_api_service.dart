import 'package:firebase_database/firebase_database.dart';
import 'package:poetlum/features/poems_feed/data/models/poem.dart';

abstract class FirebaseDatabaseService{
  Future<List<PoemModel>?> getUserPoems(String userId);
}

class FirebaseDatabaseServiceImpl implements FirebaseDatabaseService {
  @override
  Future<List<PoemModel>?> getUserPoems(String userId) async {
    final ref = FirebaseDatabase.instance.ref('$userId/poems');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final poems = <PoemModel>[];

      
      for (var child in snapshot.children) {
        final poemData = Map<String, dynamic>.from(child.value as Map);
        
        poems.add(PoemModel.fromFirebase(poemData));
      }

      return poems;
    } else {
      return null;
    }
  }
}

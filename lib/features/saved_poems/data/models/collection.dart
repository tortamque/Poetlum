import 'package:poetlum/features/poems_feed/data/models/poem.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';

class CollectionModel extends CollectionEntity{
  const CollectionModel({
    super.name = '', 
    super.poems = const [],
    super.isAllSavedPoems = false,
  });

  factory CollectionModel.fromFirebase(Map<String, dynamic> json) {
    final poemsJson = json['poems'] as List<dynamic>;
    final poems = poemsJson.map((poemJson) {
      final poemMap = Map<String, dynamic>.from(poemJson as Map);
      
      return PoemModel.fromFirebase(poemMap);
    }).toList();

    return CollectionModel(
      name: json['name'] ?? '',
      poems: poems,
    );
  }
}

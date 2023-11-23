import 'package:poetlum/features/poems_feed/data/models/poem.dart';
import 'package:poetlum/features/saved_poems/domain/entities/collection.dart';

class CollectionModel extends CollectionEntity{
  const CollectionModel({
    super.name = '', 
    super.poems = const [],
  });

  factory CollectionModel.fromFirebase(Map<String, dynamic> json) => CollectionModel(
    name: json['name'] ?? '',
    poems: (json['poems'] as Map<String, dynamic>).entries.map(
      (poem) => PoemModel.fromFirebase(poem.value),
    ).toList(),
  );
}

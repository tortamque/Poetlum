import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class DeletePoemFromCollectionParams {
  DeletePoemFromCollectionParams({required this.poemEntity, required this.userId, required this.collectionName});

  final PoemEntity poemEntity;
  final String userId;
  final String collectionName;
}

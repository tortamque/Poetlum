import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class DeletePoemParams {
  DeletePoemParams({required this.poemEntity, required this.userId, this.collectionName});

  final PoemEntity poemEntity;
  final String userId;
  final String? collectionName;
}

import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class UpdatePoemsInCollectionParams {
  UpdatePoemsInCollectionParams({required this.userId, required this.collectionName, required this.updatedPoems});

  final String userId;
  final String collectionName;
  final List<PoemEntity> updatedPoems;
}

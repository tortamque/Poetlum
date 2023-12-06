import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class UpdatePoemsInCollectionParams {
  UpdatePoemsInCollectionParams(this.updatedPoems, {required this.userId, required this.collectionName});

  final String userId;
  final String collectionName;
  final List<PoemEntity> updatedPoems;
}

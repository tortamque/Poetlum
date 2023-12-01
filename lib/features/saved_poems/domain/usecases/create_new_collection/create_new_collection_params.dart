import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class CreateNewCollectionParams {
  CreateNewCollectionParams({required this.userId, required this.collectionName, required this.poems});


  final String userId;
  final String collectionName;
  final List<PoemEntity> poems;
}

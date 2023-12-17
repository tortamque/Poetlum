import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class EditPoemParams {
  EditPoemParams({required this.newPoemEntity, required this.oldPoemEntity, required this.userId, this.collectionName});

  final PoemEntity newPoemEntity;
  final PoemEntity oldPoemEntity;
  final String userId;
  final String? collectionName;
}

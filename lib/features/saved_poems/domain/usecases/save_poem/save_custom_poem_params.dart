import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class SaveCustomPoemParams {
  SaveCustomPoemParams({required this.poemEntity, required this.userId});

  final PoemEntity poemEntity;
  final String userId;
}

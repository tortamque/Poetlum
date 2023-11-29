import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class IsPoemExistsParams {
  IsPoemExistsParams({required this.poemEntity, required this.userId});

  final PoemEntity poemEntity;
  final String userId;
}

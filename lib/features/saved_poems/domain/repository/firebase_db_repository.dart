import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

abstract class FirebaseDatabaseRepository {
  Future<List<PoemEntity>?> getUserPoems(String userId);
}

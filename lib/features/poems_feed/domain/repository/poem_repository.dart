import 'package:poetlum/core/resources/data_state.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

abstract class PoemRepository{
  Future<DataState<List<PoemEntity>>> getInitialPoems();
}

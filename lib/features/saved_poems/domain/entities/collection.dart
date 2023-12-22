import 'package:equatable/equatable.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class CollectionEntity extends Equatable{
  const CollectionEntity({this.name, this.poems, required this.isAllSavedPoems});

  final String? name;
  final List<PoemEntity>? poems;
  final bool isAllSavedPoems;

  @override
  List<Object?> get props => [
    name,
    poems, 
  ];
}

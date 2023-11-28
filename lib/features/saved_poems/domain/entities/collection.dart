import 'package:equatable/equatable.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

class CollectionEntity extends Equatable{
  const CollectionEntity({this.name, this.poems});

  final String? name;
  final List<PoemEntity>? poems;

  @override
  List<Object?> get props => [
    name,
    poems, 
  ];
}

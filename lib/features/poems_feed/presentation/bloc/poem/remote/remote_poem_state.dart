import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:poetlum/features/poems_feed/domain/entities/poem.dart';

abstract class RemotePoemState extends Equatable{
  const RemotePoemState({this.poems, this.error});

  final List<PoemEntity>? poems;
  final DioException? error;

  @override
  List<Object?> get props => [
    poems!,
    error!,
  ];
}

class RemotePoemLoading extends RemotePoemState{
  const RemotePoemLoading();
}

class RemotePoemDone extends RemotePoemState{
  const RemotePoemDone(List<PoemEntity> poems) : super(poems: poems);
}

class RemotePoemError extends RemotePoemState{
  const RemotePoemError(DioException error, this.message) : super(error: error);

  final String message;
}

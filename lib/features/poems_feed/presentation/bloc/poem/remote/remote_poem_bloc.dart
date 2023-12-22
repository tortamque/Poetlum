// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poetlum/core/resources/data_state.dart';
import 'package:poetlum/features/poems_feed/domain/usecases/get_poems_usecase.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_event.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_state.dart';

class RemotePoemBloc extends Bloc<RemotePoemEvent, RemotePoemState>{
  RemotePoemBloc(this._getInitialPoemsUseCase, this._getPoemsUseCase): super(const RemotePoemLoading()){
    on<GetInitialPoemsEvent>(onGetInitialPoems);
    on<GetPoemsEvent>(onGetPoems);
  }

  final GetInitialPoemsUseCase _getInitialPoemsUseCase;
  final GetPoemsUseCase _getPoemsUseCase;

  Future<void> onGetInitialPoems(GetInitialPoemsEvent event, Emitter<RemotePoemState> emitter) async{
    emit(const RemotePoemLoading());
    
    final dataState = await _getInitialPoemsUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
        RemotePoemDone(dataState.data!),
      );
    }

    if(dataState is DataFailed){
      emit(
        RemotePoemError(dataState.error!, dataState.message!),
      );
    }
  }

  Future<void> onGetPoems(GetPoemsEvent event, Emitter<RemotePoemState> emitter) async{
    emit(const RemotePoemLoading());

    final dataState = await _getPoemsUseCase(
      params: GetPoemsUseCaseParams(
        author: event.author,
        lineCount: event.lineCount,
        poemCount: event.poemCount,
        title: event.title,
        isRandom: event.isRandom,
      ),
    );

    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
        RemotePoemDone(dataState.data!),
      );
    }

    if(dataState is DataFailed){
      emit(
        RemotePoemError(dataState.error!, dataState.message!),
      );
    }
  }
}

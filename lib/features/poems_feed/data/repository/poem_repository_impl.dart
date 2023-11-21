import 'dart:io';

import 'package:dio/dio.dart';
import 'package:poetlum/core/constants/poems_constants.dart';
import 'package:poetlum/core/resources/data_state.dart';
import 'package:poetlum/features/poems_feed/data/data_sources/remote/poem_api_service.dart';
import 'package:poetlum/features/poems_feed/data/models/poem.dart';
import 'package:poetlum/features/poems_feed/domain/repository/poem_repository.dart';

class PoemRepositoryImpl implements PoemRepository{
  PoemRepositoryImpl(this._poemApiService);

  final PoemApiService _poemApiService;

  @override
  Future<DataState<List<PoemModel>>> getInitialPoems() async {
    try{
      final httpResponse = await _poemApiService.getInitialPoems();

      if(httpResponse.response.statusCode == HttpStatus.ok){
        return DataSuccess(httpResponse.data);
      } else{
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            error: httpResponse.response.statusMessage,
          ),
          'An error occurred during the attempt to connect to the server.'
        );
      }
    } on DioException catch(error){
      return DataFailed(
        error,
        'An error occurred during the attempt to connect to the server.',
      );
    }
  }

  @override
  Future<DataState<List<PoemModel>>> getPoems({required String author, required String title, required String lineCount, required String poemCount, required bool isRandom}) async {
    final outputFields = <String>[];
    final searchTerms = <String>[];

    if (author.isNotEmpty) {
      outputFields.add('author');
      searchTerms.add(author);
    }
    if (title.isNotEmpty) {
      outputFields.add('title');
      searchTerms.add(title);
    }
    if (lineCount.isNotEmpty) {
      outputFields.add('linecount');
      searchTerms.add(lineCount);
    }
    if (poemCount.isNotEmpty) {
      if(isRandom){
        print('changed to random poemCount != null');
        outputFields.add('random');
        searchTerms.add(poemCount);
      } else{
        outputFields.add('poemcount');
        searchTerms.add(poemCount);
      }
    }
    if(poemCount.isEmpty && isRandom){
      print('changed to random poemCount == null');
      outputFields.add('random');
      searchTerms.add(defaultPoemsCount.toString());
    }

    final outputFieldsPart = outputFields.join(',');
    final searchTermsPart = searchTerms.join(';');
    final query = '$outputFieldsPart/$searchTermsPart';

    print(query);

    try {
      final httpResponse = await _poemApiService.getPoems(query);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            error: httpResponse.response.statusMessage,
          ),
          'An error occurred during the attempt to connect to the server.',
        );
      }
    } on DioException catch (error) {
      return DataFailed(
        error,
        'An error occurred. Please ensure that you have provided the correct search settings.',
      );
    }
  }
}

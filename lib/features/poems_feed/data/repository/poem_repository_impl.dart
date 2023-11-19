import 'dart:io';

import 'package:dio/dio.dart';
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
        );
      }
    } on DioException catch(error){
      return DataFailed(error);
    }
  }

  @override
  Future<DataState<List<PoemModel>>> getPoems({String? author, String? title, String? lineCount, String? poemCount}) async {
    print('repo $author, $title, $lineCount, $poemCount');

    final outputFields = <String>[];
    final searchTerms = <String>[];

    if (author != null && author.isNotEmpty) {
      outputFields.add('author');
      searchTerms.add(author);
    }
    if (title != null && title.isNotEmpty) {
      outputFields.add('title');
      searchTerms.add(title);
    }
    if (lineCount != null && lineCount.isNotEmpty) {
      outputFields.add('linecount');
      searchTerms.add(lineCount);
    }
    if (poemCount != null && poemCount.isNotEmpty) {
      outputFields.add('poemcount');
      searchTerms.add(poemCount);
    }

    final outputFieldsPart = outputFields.join(',');
    final searchTermsPart = searchTerms.join(';');
    final query = '$outputFieldsPart/$searchTermsPart';
    print('query $query');

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
        );
      }
    } on DioException catch (error) {
      return DataFailed(error);
    }
  }
}

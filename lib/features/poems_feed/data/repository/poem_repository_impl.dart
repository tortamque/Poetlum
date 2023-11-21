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
          'An error occurred during the attempt to connect to the server.',
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
    final query = _buildQuery(author, title, lineCount, poemCount, isRandom);

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

  String _buildQuery(String author, String title, String lineCount, String poemCount, bool isRandom) {
    final outputFields = <String>[];
    final searchTerms = <String>[];

    _addQueryPart(outputFields, searchTerms, 'author', author);
    _addQueryPart(outputFields, searchTerms, 'title', title);
    _addQueryPart(outputFields, searchTerms, 'linecount', lineCount);
    
    if (poemCount.isNotEmpty || isRandom) {
      final field = isRandom ? 'random' : 'poemcount';
      final count = poemCount.isNotEmpty ? poemCount : defaultPoemsCount.toString();
      _addQueryPart(outputFields, searchTerms, field, count);
    }

    return '${outputFields.join(',')}/${searchTerms.join(';')}';
  }

  void _addQueryPart(List<String> fields, List<String> terms, String field, String term) {
    if (term.isNotEmpty) {
      fields.add(field);
      terms.add(term);
    }
  }
}

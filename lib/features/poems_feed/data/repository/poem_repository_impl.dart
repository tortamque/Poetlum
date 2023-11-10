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
  Future<DataState<List<PoemModel>>> getPoems() async {
    try{
      final httpResponse = await _poemApiService.getPoems();

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
}

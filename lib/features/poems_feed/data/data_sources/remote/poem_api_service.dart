import 'package:dio/dio.dart';
import 'package:poetlum/core/constants/poems_constants.dart';
import 'package:poetlum/core/shared/data/models/poem.dart';
import 'package:retrofit/retrofit.dart';

part 'poem_api_service.g.dart';

@RestApi(baseUrl: poemApiBaseUrl)
abstract class PoemApiService{
  factory PoemApiService(Dio dio) = _PoemApiService;

  @GET('random/$defaultPoemsCount')
  Future<HttpResponse<List<PoemModel>>> getInitialPoems();

  @GET('/{query}')
  Future<HttpResponse<List<PoemModel>>> getPoems(@Path('query') String query);
}

import 'package:dio/dio.dart';

abstract class DataState<T>{
  const DataState({this.data, this.error, this.message});

  final T? data;
  final DioException? error;
  final String? message;
}

class DataSuccess<T> extends DataState<T>{
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T>{
  const DataFailed(DioException error, String message) : super(error: error, message: message);
}

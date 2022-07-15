import 'package:dio/dio.dart';

class HttpClient {
  final Dio _dio;

  HttpClient({required Dio dio}) : _dio = dio;

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    var response = await _dio.get(
      url,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      options: options,
    );

    return response;
  }
}

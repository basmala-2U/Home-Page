import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'api_constants.dart';

// dio configuration used for all network requests
class DioConfig {
  DioConfig._();

  // timeout duration for requests
  static final Duration _timeout = Duration(seconds: 30);

  // create and return dio instance
  static Dio getDio() {
    Dio dio = Dio()
      // base url for all api calls
      ..options.baseUrl = ApiConstants.baseUrl
      // connection timeout
      ..options.connectTimeout = _timeout
      // response timeout
      ..options.receiveTimeout = _timeout
      // request content type
      ..options.contentType = Headers.jsonContentType
      // expected response type
      ..options.responseType = ResponseType.json
      // interceptor to log requests and responses
      ..interceptors.add(LogInterceptor(responseBody: true))
      // http adapter for android and ios
      ..httpClientAdapter = IOHttpClientAdapter();

    return dio;
  }
}

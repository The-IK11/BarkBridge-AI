import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '/helpers/di.dart';
import '../../constants/app_constants.dart';
import '../endpoints.dart';
import 'log.dart';

final class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  static CancelToken cancelToken = CancelToken();
  DioSingleton._internal();

  static DioSingleton get instance => _singleton;

  late Dio dio;

  void create() {
    final BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.ACCEPT_LANGUAGE: appData.read(kKeyCountryCode) ?? 'pt',
        NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
      },
    );
    dio = Dio(options)..interceptors.add(Logger());
  }

  void update(String auth) {
    if (kDebugMode) {
      print('Dio update');
    }
    final BaseOptions options = BaseOptions(
      baseUrl: url,
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        // NetworkConstants.ACCEPT_LANGUAGE: appData.read(kKeyLanguage) ?? "pt",
        // NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
        NetworkConstants.AUTHORIZATION: 'Bearer $auth',
      },

      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
    );
    dio = Dio(options)..interceptors.add(Logger());
  }

  void reset() {
    cancelToken.cancel("Dio client reset");
    cancelToken = CancelToken();
    create();
  }
}

Future<Response> postHttp({
  required String path,
  dynamic data,
  Map<String, dynamic>? queryParameters,
}) => DioSingleton.instance.dio.post(
  path,
  data: data,
  queryParameters: queryParameters,
  cancelToken: DioSingleton.cancelToken,
);

Future<Response> putHttp({
  required String path,
  dynamic data,
  Map<String, dynamic>? queryParameters,
}) => DioSingleton.instance.dio.put(
  path,
  data: data,
  queryParameters: queryParameters,
  cancelToken: DioSingleton.cancelToken,
);

Future<Response> getHttp({
  required String path,
  Map<String, dynamic>? queryParameters,
}) => DioSingleton.instance.dio.get(
  path,
  queryParameters: queryParameters,
  cancelToken: DioSingleton.cancelToken,
);

Future<Response> deleteHttp(
  String path, [
  dynamic data,
  Map<String, dynamic>? queryParameters,
]) => DioSingleton.instance.dio.delete(
  path,
  data: data,
  queryParameters: queryParameters,
  cancelToken: DioSingleton.cancelToken,
);
Future<Response> patchHttp({
  required String path,
  dynamic data,
  Map<String, dynamic>? queryParameters,
}) => DioSingleton.instance.dio.patch(
  path,
  data: data,
  queryParameters: queryParameters,
  cancelToken: DioSingleton.cancelToken,
);

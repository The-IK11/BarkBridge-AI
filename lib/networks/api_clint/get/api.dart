import 'package:dio/dio.dart';

import '../../../../../networks/exception_handler/data_source.dart';
import '../../dio/dio.dart';

final class GetApi {
  static final GetApi _singleton = GetApi._internal();
  GetApi._internal();
  static GetApi get instance => _singleton;
  String? lastEndpoit;

  Future<Map<String, dynamic>> get({
    required String? endpoint,
    Map<String, dynamic>? defaultQueryParameters,
    Map<String, dynamic>? queryParameters,
    String? dynamicEndpoint,
  }) async {
    try {
      final Response response = await getHttp(
        path:
            endpoint?? dynamicEndpoint!,
        queryParameters: {...?defaultQueryParameters, ...?queryParameters},
      );
      if (response.statusCode == 200) {
        lastEndpoit =
            "${endpoint == null ? dynamicEndpoint : "$endpoint${dynamicEndpoint ?? ''}"}";
        if (response.data is! Map) {
          response.data = {'itemList': response.data};
        }
        final Map<String, dynamic> data = response.data;
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      throw ErrorHandler.handle(error).failure;
    }
  }

  Future<Map<String, dynamic>> reload() async {
    try {
      final Response response = await getHttp(path: lastEndpoit!);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      throw ErrorHandler.handle(error).failure;
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/exception_handler/data_source.dart';
import '../../dio/dio.dart';
import 'map_to_form.dart';

final class PostApi {
  static final PostApi _singleton = PostApi._internal();
  PostApi._internal();
  static PostApi get instance => _singleton;
  Future<Map> post({
    Map<String, dynamic>? queryParameters,

    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response response = await postHttp(
        path: endPoint,
        data: data != null ? await processMapForUpload(data) : data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/exception_handler/data_source.dart';
import '../../dio/dio.dart';

final class DeleteApi {
  static final DeleteApi _singleton = DeleteApi._internal();
  DeleteApi._internal();
  static DeleteApi get instance => _singleton;
  Future<Map> delete({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response response = await deleteHttp(endPoint, data);

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

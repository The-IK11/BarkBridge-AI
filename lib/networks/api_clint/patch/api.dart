import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tintpin14_app/networks/dio/dio.dart';

import '../../../../../../networks/exception_handler/data_source.dart';

import 'map_to_form.dart';

final class PatchApi {
  static final PatchApi _singleton = PatchApi._internal();
  PatchApi._internal();
  static PatchApi get instance => _singleton;
  Future<Map> patch({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response response = await patchHttp(
        path: endPoint,
        data: data != null ? await processMapForUpload(data) : data,
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

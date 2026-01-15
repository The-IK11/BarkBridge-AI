import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../exception_handler/data_source.dart';

final class Logger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('= = = Dio Request = = =');
    log('${options.headers}');
    log('${options.data}');
    log('${options.contentType}');
    log('${options.extra}');
    log('${options.baseUrl}${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('= = = Dio Success Response = = =');

    // Pretty print response data
    if (response.data != null) {
      try {
        final prettyData =
            const JsonEncoder.withIndent('  ').convert(response.data);
        log('Response Data (Pretty JSON):\n$prettyData');

        // Log each key-value pair separately if data is a Map
        if (response.data is Map<String, dynamic>) {
          log('= = = Response Data Key-Value Pairs = = =');
          final dataMap = response.data as Map<String, dynamic>;
          dataMap.forEach((key, value) {
            final prettyValue =
                const JsonEncoder.withIndent('  ').convert(value);
            log('$key: $prettyValue');
          });
        }
      } catch (e) {
        log('Response Data (Raw): ${response.data}');
      }
    } else {
      log('Response Data: null');
    }

    log('Status Code: ${response.statusCode}');
    log('Status Message: ${response.statusMessage}');
    log('Headers: ${response.headers}');
    log('Extra: ${response.extra}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log('= = = Dio Error Response = = =');
      log('Error Response: ${err.response}');
      log('Error Message: ${err.message}');
      log('Error Type: ${err.type}');
      log('Error: ${err.error}');
      log('Error Req option: ${err.requestOptions}');
    }
    ErrorHandler.handle(err).failure;
    return super.onError(err, handler);
  }
}

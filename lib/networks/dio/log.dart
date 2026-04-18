import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:tintpin14_app/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:tintpin14_app/networks/dio/dio.dart';

import '../../constants/app_constants.dart';

import '../../helpers/di.dart';
import '../exception_handler/data_source.dart';

final class Logger extends Interceptor {
  // ANSI color codes
  static const String _reset = '\x1B[0m';
  static const String _cyan = '\x1B[36m';
  static const String _green = '\x1B[32m';
  static const String _red = '\x1B[31m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _white = '\x1B[37m';
  static const String _magenta = '\x1B[35m';

  String _prettyPrintJson(dynamic json) {
    try {
      return const JsonEncoder.withIndent('  ').convert(json);
    } catch (e) {
      return json.toString();
    }
  }

  String _formatFormData(FormData formData) {
    final buffer = StringBuffer();
    buffer.writeln('{');

    // Print form fields
    if (formData.fields.isNotEmpty) {
      buffer.writeln('  "fields": {');
      for (int i = 0; i < formData.fields.length; i++) {
        final field = formData.fields[i];
        buffer.write('    "${field.key}": "${field.value}"');
        if (i < formData.fields.length - 1 || formData.files.isNotEmpty) {
          buffer.writeln(',');
        } else {
          buffer.writeln();
        }
      }
      buffer.writeln('  }');
      if (formData.files.isNotEmpty) {
        buffer.writeln(',');
      }
    }

    // Print form files
    if (formData.files.isNotEmpty) {
      buffer.writeln('  "files": {');
      for (int i = 0; i < formData.files.length; i++) {
        final file = formData.files[i];
        buffer.write('    "${file.key}": {');
        buffer.write('"filename": "${file.value.filename}", ');
        buffer.write('"contentType": "${file.value.contentType}"');
        buffer.write('}');
        if (i < formData.files.length - 1) {
          buffer.writeln(',');
        } else {
          buffer.writeln();
        }
      }
      buffer.writeln('  }');
    }

    buffer.writeln('}');
    return buffer.toString();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(
      '$_cyan╔══════════════════════════════════════════════════════════════════════════════$_reset',
    );
    log('$_cyan║ $_blue📤 DIO REQUEST$_reset');
    log(
      '$_cyan╠══════════════════════════════════════════════════════════════════════════════$_reset',
    );
    log('$_cyan║$_white URL: ${options.baseUrl}${options.path}$_reset');
    log('$_cyan║$_white Method: $_yellow${options.method}$_reset');

    if (options.headers.isNotEmpty) {
      log('$_cyan║$_yellow Headers:$_reset');
      final prettyHeaders = _prettyPrintJson(options.headers);
      for (var line in prettyHeaders.split('\n')) {
        log('$_cyan║$_magenta   $line$_reset');
      }
    }

    if (options.data != null) {
      log('$_cyan║$_yellow Body:$_reset');
      String bodyString;
      if (options.data is FormData) {
        bodyString = _formatFormData(options.data as FormData);
      } else {
        bodyString = _prettyPrintJson(options.data);
      }
      for (var line in bodyString.split('\n')) {
        log('$_cyan║$_white   $line$_reset');
      }
    }

    if (options.contentType != null) {
      log('$_cyan║$_yellow Content-Type: $_white${options.contentType}$_reset');
    }

    log(
      '$_cyan╚══════════════════════════════════════════════════════════════════════════════$_reset',
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      '$_green╔══════════════════════════════════════════════════════════════════════════════$_reset',
    );
    log('$_green║ $_green✅ DIO SUCCESS RESPONSE$_reset');
    log(
      '$_green╠══════════════════════════════════════════════════════════════════════════════$_reset',
    );
    log(
      '$_green║$_white Status: $_blue${response.statusCode}$_white ${response.statusMessage}$_reset',
    );

    // Headers are a special type, just convert to string
    if (response.headers.toString().isNotEmpty) {
      log(
        '$_green║$_yellow Headers: $_magenta${response.headers.toString()}$_reset',
      );
    }

    if (response.data != null) {
      log('$_green║$_yellow Response Data:$_reset');
      final prettyData = _prettyPrintJson(response.data);
      for (var line in prettyData.split('\n')) {
        log('$_green║$_white   $line$_reset');
      }
    } else {
      log('$_green║$_white Response Data: null$_reset');
    }

    log(
      '$_green╚══════════════════════════════════════════════════════════════════════════════$_reset',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.data['message'] == "Unauthenticated.") {
      DioSingleton.instance.reset();
      appData.write(kKeyAccessToken, null);
      getx.Get.offAll(() => SignInScreen());
    }

    if (kDebugMode) {
      log(
        '$_red╔══════════════════════════════════════════════════════════════════════════════$_reset',
      );
      log('$_red║ $_red❌ DIO ERROR RESPONSE$_reset');
      log(
        '$_red╠══════════════════════════════════════════════════════════════════════════════$_reset',
      );
      log('$_red║$_yellow Error Type: $_magenta${err.type}$_reset');
      log('$_red║$_yellow Error Message: $_white${err.message}$_reset');

      if (err.response != null) {
        log(
          '$_red║$_yellow Status Code: $_magenta${err.response?.statusCode}$_reset',
        );
        log('$_red║$_yellow Response Data:$_reset');
        final prettyData = _prettyPrintJson(err.response?.data);
        for (var line in prettyData.split('\n')) {
          log('$_red║$_white   $line$_reset');
        }
      }

      if (err.error != null) {
        log('$_red║$_yellow Error Details: $_white${err.error}$_reset');
      }

      log(
        '$_red║$_yellow Request URL: $_white${err.requestOptions.baseUrl}${err.requestOptions.path}$_reset',
      );
      log(
        '$_red╚══════════════════════════════════════════════════════════════════════════════$_reset',
      );
    }

    ErrorHandler.handle(err).failure;
    return super.onError(err, handler);
  }
}

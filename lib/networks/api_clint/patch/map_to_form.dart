import 'dart:io';
import 'package:dio/dio.dart';

Future<dynamic> processMapForUpload(Map<String, dynamic> inputMap) async {
  final FormData formData = FormData();

  for (final MapEntry(key: key, value: value) in inputMap.entries) {
    if (value is File) {
      final String fileName = value.uri.pathSegments.last;
      formData.files.add(
        MapEntry(
          key,
          await MultipartFile.fromFile(value.path, filename: fileName),
        ),
      );
    } else if (value is MultipartFile) {
      formData.files.add(MapEntry(key, value));
    } else if (value is List) {
      for (var item in value) {
        if (item is File) {
          final String fileName = item.uri.pathSegments.last;
          formData.files.add(
            MapEntry(
              key,
              await MultipartFile.fromFile(item.path, filename: fileName),
            ),
          );
        } else if (item is MultipartFile) {
          formData.files.add(MapEntry(key, item));
        } else {
          // Add non-file list items as separate fields
          formData.fields.add(MapEntry(key, item.toString()));
        }
      }
    } else {
      // Normal fields
      formData.fields.add(MapEntry(key, value?.toString() ?? ''));
    }
  }

  // Always return FormData to ensure nested array keys are properly handled
  return formData;
}

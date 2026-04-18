import 'dart:convert';
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
      for (int i = 0; i < value.length; i++) {
        final item = value[i];
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
        } else if (item is Map) {
          // Handle complex objects like chapters
          final Map<String, dynamic> processedItem = {};
          for (final MapEntry(key: itemKey, value: itemValue) in item.entries) {
            if (itemValue is File) {
              final String fileName = itemValue.uri.pathSegments.last;
              formData.files.add(
                MapEntry(
                  '$key[$i][$itemKey]',
                  await MultipartFile.fromFile(
                    itemValue.path,
                    filename: fileName,
                  ),
                ),
              );
            } else {
              processedItem[itemKey] = itemValue;
            }
          }
          // Send the processed object as JSON string
          formData.fields.add(MapEntry('$key[$i]', jsonEncode(processedItem)));
        } else {
          // Add non-file, non-map list items as array fields
          formData.fields.add(MapEntry('$key[$i]', item.toString()));
        }
      }
    } else {
      // Normal fields - preserve numeric types but convert to string for FormData
      final String stringValue = value?.toString() ?? '';
      formData.fields.add(MapEntry(key, stringValue));
    }
  }

  // Always return FormData to ensure nested array keys (existing_images[0], chapters[0][id]) are properly handled
  // Some APIs require FormData format to correctly parse nested keys even without files
  return formData;
}

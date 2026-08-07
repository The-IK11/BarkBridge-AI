import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailHelper {
  VideoThumbnailHelper._();

  static final Dio _dio = Dio();

  /// In-memory cache so thumbnails survive widget rebuilds / navigation.
  static final Map<String, Uint8List> _memoryCache = {};

  /// Clear the in-memory thumbnail cache (e.g. on logout or pull-to-refresh).
  static void clearCache() => _memoryCache.clear();

  static Future<Uint8List?> getThumbnailFromUrl({
    required String url,
    int timeMs = 0,
    int quality = 75,
    int maxWidth = 300,
  }) async {
    // ── Return from memory cache instantly ──
    if (_memoryCache.containsKey(url)) {
      debugPrint('[Thumbnail] ⚡ Memory-cache hit: $url');
      return _memoryCache[url];
    }

    File? tempFile;
    try {
      debugPrint('[Thumbnail] ▶ Starting for URL: $url');

      // Step 1: Temp directory
      final dir = await getTemporaryDirectory();
      debugPrint('[Thumbnail] ✅ Temp dir: ${dir.path}');

      final fileName = url.split('/').last;
      tempFile = File('${dir.path}/$fileName');
      debugPrint('[Thumbnail] 📁 Temp file path: ${tempFile.path}');

      // Step 2: Download
      if (!tempFile.existsSync()) {
        debugPrint('[Thumbnail] ⬇ Downloading video...');
        final response = await _dio.get(
          url,
          options: Options(responseType: ResponseType.bytes),
          onReceiveProgress: (received, total) {
            debugPrint('[Thumbnail] 📶 $received / $total bytes');
          },
        );

        debugPrint(
          '[Thumbnail] ✅ Download done. Status: ${response.statusCode}',
        );
        debugPrint(
          '[Thumbnail] 📦 Bytes received: ${(response.data as List).length}',
        );

        await tempFile.writeAsBytes(response.data);
        debugPrint('[Thumbnail] ✅ Written to disk: ${tempFile.path}');
      } else {
        debugPrint('[Thumbnail] ♻️ Using cached file: ${tempFile.path}');
      }

      // Confirm file exists and has size
      final fileSize = await tempFile.length();
      debugPrint('[Thumbnail] 📏 File size on disk: $fileSize bytes');

      if (fileSize == 0) {
        debugPrint('[Thumbnail] ❌ File is empty! Deleting and returning null.');
        await tempFile.delete();
        return null;
      }

      // Step 3: Extract thumbnail
      debugPrint('[Thumbnail] 🖼 Extracting thumbnail...');
      final bytes = await VideoThumbnail.thumbnailData(
        video: tempFile.path,
        imageFormat: ImageFormat.JPEG,
        timeMs: timeMs,
        maxWidth: maxWidth,
        quality: quality,
      );

      if (bytes == null) {
        debugPrint('[Thumbnail] ❌ thumbnailData returned null');
      } else {
        debugPrint(
          '[Thumbnail] ✅ Thumbnail extracted! Size: ${bytes.length} bytes',
        );
        // ── Store in memory cache ──
        _memoryCache[url] = bytes;
      }

      return bytes;
    } catch (e, stack) {
      debugPrint('[Thumbnail] ❌ Exception: $e');
      debugPrint('[Thumbnail] 📋 Stack: $stack');
      if (tempFile != null && tempFile.existsSync()) {
        await tempFile.delete();
        debugPrint('[Thumbnail] 🗑 Cleaned up temp file');
      }
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import '../common_widgets/loading_indicators.dart';

import 'navigation_service.dart';

extension Loader on Future {
  Future<T?> waitingForFutureWithoutBg<T>() async {
    bool isDialogOpen = true;
    showDialog(
      context: NavigationService.context,
      builder: (context) => loadingIndicatorCircle(context: context),
    ).then((_) {
      isDialogOpen = false; // Update flag when dialog is dismissed manually
    });

    try {
      final T result = await this as T;
      return result;
    } catch (e) {
      rethrow;
    } finally {
      // Only try to close dialog if it's still open
      if (isDialogOpen) {
        NavigationService.goBack; // Close dialog
      }
    }
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tintpin14_app/networks/api_clint/error_message_converter.dart';

import '../../../../../../../common_widgets/custom_toast.dart';
import '../../../../../../../networks/rx_base.dart';
import 'api.dart';
import 'enum.dart';

final class PatchRx extends RxResponseInt {
  final api = PatchApi.instance;

  PatchRx({
    required super.empty,
    required super.dataFetcher,
    this.patchEndPoint,
    this.onSuccess,
    this.onError,
    this.toastSetting = PatchToastSetting.error,
    this.errorKey,
    this.successMessage,
  });

  String? patchEndPoint;
  PatchToastSetting? toastSetting;
  final Function(Map data)? onSuccess;
  final Function(String error)? onError;
  final String? errorKey;
  final String? successMessage;
  ValueStream get patchResponseStream => dataFetcher.stream;

  Future<bool> patchData({String? endPoint, Map<String, dynamic>? data}) async {
    try {
      final Map resdata = await api.patch(
        data: data,
        endPoint: endPoint ?? patchEndPoint!,
      );
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    String message = data['message'] ?? 'Request Complete Successfully';
    if (successMessage != null) {
      message = successMessage!;
    }

    if (toastSetting == PatchToastSetting.both ||
        toastSetting == PatchToastSetting.successfull) {
      customToastMessage('Successful', message);
    }

    dataFetcher.sink.add(data);
    if (onSuccess != null) {
      await onSuccess!(data);
    }

    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message =
          error.response?.data[errorKey ?? 'message'].toString() ??
          'Something went wrong';
      if (errorKey == 'data') {
        message = convertValidationErrorsToReadable(
          error.response?.data[errorKey ?? 'message'],
        );
      }
      if (error.type == DioExceptionType.connectionError) {
        message = 'Check Your Network Connection';
      }
    }
    if (onError != null) {
      onError!(message);
    }
    if (toastSetting == PatchToastSetting.both ||
        toastSetting == PatchToastSetting.error) {
      customToastMessage('Error', message);
    }
    throw Exception();
  }
}

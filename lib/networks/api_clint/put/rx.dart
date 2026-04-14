import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../../common_widgets/custom_toast.dart';
import '../../../../../../../networks/rx_base.dart';
import 'api.dart';
import 'enum.dart';
import '../error_message_converter.dart';

/// A reactive class for handling PUT API requests with built-in error handling,
/// success callbacks, and toast notifications.
///
/// This class extends [RxResponseInt] and provides a streamlined way to make
/// PUT requests to REST APIs. It automatically handles common scenarios like
/// network errors, validation errors, and success responses.
///
/// ## Usage Example
///
/// ```dart
/// // Without model conversion (returns Map)
/// final putProfile = PutRx(
///   empty: {},
///   dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
///   endPoint: '/users/profile',
///   toastSetting: ToastSetting.both,
///   onSuccess: (data) {
///     print('Profile updated: ${data['name']}');
///   },
/// );
///
/// // With model conversion (returns typed model)
/// final putUser = PutRx<UserModel>(
///   empty: UserModel.empty(),
///   dataFetcher: BehaviorSubject<UserModel>.seeded(UserModel.empty()),
///   endPoint: '/users/1',
///   fromJson: (map) => UserModel.fromJson(map),
///   onSuccess: (user) {
///     print('Updated user: ${user.name}');
///   },
/// );
/// ```
///
/// ## Features
///
/// - Automatic error handling with customizable toast messages
/// - Success callback support for put-processing
/// - Network connection error detection
/// - Validation error parsing and formatting
/// - Reactive data streaming via Rx streams
/// - Configurable toast notification settings
/// - Optional model conversion via [fromJson]
final class PutRx<T> extends RxResponseInt<T> {
  final api = PutApi.instance;

  /// Creates a new PutRx instance for handling PUT API requests.
  ///
  /// ## Parameters
  ///
  /// - [empty]: The initial empty state for the data stream. Typically an empty Map.
  /// - [dataFetcher]: A BehaviorSubject that manages the reactive data stream.
  ///   Used to emit API response data to subscribers.
  /// - [endPoint]: The API endpoint path for the PUT request (e.g., '/users/login').
  ///   Can be overridden when calling [putData].
  /// - [onSuccess]: Optional callback function executed when the API call succeeds.
  ///   Receives the response data as a Map.
  /// - [onError]: Optional callback function executed when the API call fails.
  ///   Receives the error message as a String.
  /// - [toastSetting]: Controls when toast notifications are shown.
  ///   Defaults to [ToastSetting.error].
  /// - [errorKey]: The key in the error response to extract the error message from.
  ///   Defaults to 'message'. Use 'data' for validation errors.
  /// - [successMessage]: Custom success message to display instead of the API's message.
  ///
  /// ## Example
  ///
  /// ```dart
  /// PutRx putLogin = PutRx(
  ///   empty: {},
  ///   dataFetcher: BehaviorSubject<Map<String, dynamic>>(),
  ///   putEndPoint: '/users/login',
  ///   toastSetting: ToastSetting.both,
  ///   onSuccess: (data) => print('Login successful'),
  ///   errorKey: 'message',
  /// );
  /// ```
  /// Optional transformer that converts a JSON map into an instance of [T].
  /// If omitted, the raw `Map<String, dynamic>` from the API will be emitted.
  final T Function(Map<String, dynamic>)? fromJson;

  PutRx({
    required super.empty,
    required super.dataFetcher,
    this.endPoint,
    this.onSuccess,
    this.onError,
    this.toastSetting = PutToastSetting.error,
    this.errorKey,
    this.defaultQueryParameters,
    this.successMessage,
    this.fromJson,
  });

  /// The API endpoint path for PUT requests.
  ///
  /// This is the default endpoint used when calling [putData] without
  /// specifying a custom endpoint. Can be overridden per request.
  String? endPoint;

  /// Controls when toast notifications are displayed.
  ///
  /// - [ToastSetting.error]: Show only error toasts
  /// - [ToastSetting.successfull]: Show only success toasts
  /// - [ToastSetting.both]: Show both success and error toasts
  PutToastSetting? toastSetting;

  /// Callback function executed when the API request succeeds.
  ///
  /// This function receives the response data (either Map or typed model T)
  /// and can be used for put-processing like storing tokens, updating UI state, or navigation.
  final Function(T data)? onSuccess;

  /// Callback function executed when the API request fails.
  ///
  /// This function receives the error message as a String and can be used
  /// for custom error handling or logging.
  final Function(String error)? onError;

  /// The key in the API error response to extract the error message from.
  ///
  /// - Use 'message' for general error messages
  /// - Use 'data' for validation errors (will be parsed by [convertValidationErrorsToReadable])
  final String? errorKey;

  /// Custom success message to override the API's default success message.
  ///
  /// If null, the API's 'message' field will be used for success toasts.
  ///
  ///

  final Map<String, dynamic>? defaultQueryParameters;

  final String? successMessage;

  /// A reactive stream that emits the latest API response data.
  ///
  /// Subscribe to this stream to reactively update UI components when
  /// new data is received from API calls.
  ValueStream get putResponseStream => dataFetcher.stream;

  /// Makes a PUT request to the specified API endpoint.
  ///
  /// This is the primary method for executing PUT API calls. It handles
  /// the complete request lifecycle including error handling and success callbacks.
  ///
  /// ## Parameters
  ///
  /// - [dynamicEndpoint]: Optional custom endpoint to override [endPoint].
  ///   If null, uses the default [endPoint].
  /// - [data]: The request body data as a Map. Will be JSON encoded.
  ///
  /// ## Returns
  ///
  /// A [Future<bool>] that resolves to:
  /// - `true` if the request was successful
  /// - `false` if the request failed (exception is thrown)
  ///
  /// ## Example
  ///
  /// ```dart
  /// bool success = await putLogin.putData(
  ///   data: {
  ///     'email': 'user@example.com',
  ///     'password': 'password123',
  ///   },
  /// );
  ///
  /// if (success) {
  ///   // Handle success
  ///   Get.offAll(() => HomeScreen());
  /// }
  /// ```
  ///
  /// ## Error Handling
  ///
  /// This method automatically handles various error scenarios:
  /// - Network connection errors
  /// - HTTP error responses
  /// - Validation errors
  /// - Server errors
  ///
  /// Errors are displayed as toast messages based on [toastSetting].
  Future<bool> putData({
    String? dynamicEndpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Map resdata = await api.put(
        data: data,
        endPoint: dynamicEndpoint ?? endPoint!,
        queryParameters: {...?defaultQueryParameters, ...?queryParameters},
      );
      // Convert to model if fromJson is provided
      if (fromJson != null) {
        final T modelData = fromJson!(resdata as Map<String, dynamic>);
        return await handleSuccessWithReturn(modelData);
      } else {
        return await handleSuccessWithReturn(resdata as T);
      }
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  /// Handles successful API responses and triggers success callbacks.
  ///
  /// This method is called internally when a PUT request succeeds. It processes
  /// the response data, displays success toasts if configured, emits data to
  /// the reactive stream, and executes the success callback.
  ///
  /// ## Parameters
  ///
  /// - [data]: The raw response data from the API as a Map.
  ///
  /// ## Processing Steps
  ///
  /// 1. Extracts success message from response or uses [successMessage]
  /// 2. Shows success toast if [toastSetting] allows it
  /// 3. Emits response data to the reactive stream ([dataFetcher])
  /// 4. Executes [onSuccess] callback if provided
  /// 5. Returns `true` to indicate success
  ///
  /// ## Response Data Structure
  ///
  /// Expected response format:
  /// ```json
  /// {
  ///   "message": "Operation successful",
  ///   "data": { ... },
  ///   "status": 200
  /// }
  /// ```
  ///
  /// The [dataFetcher] stream will emit the complete response Map.
  @override
  handleSuccessWithReturn(data) async {
    String message = 'Request Complete Successfully';
    // Only try to access 'message' key if data is a Map
    if (data is Map && data['message'] != null) {
      message = data['message'];
    }
    if (successMessage != null) {
      message = successMessage!;
    }

    if (toastSetting == PutToastSetting.both ||
        toastSetting == PutToastSetting.successfull) {
      customToastMessage('Successful', message);
    }

    dataFetcher.sink.add(data);
    if (onSuccess != null) {
      await onSuccess!(data);
    }

    return true;
  }

  /// Handles API errors and provides user-friendly error messages.
  ///
  /// This method is called internally when a PUT request fails. It processes
  /// different types of errors, extracts appropriate error messages, and
  /// displays error toasts if configured.
  ///
  /// ## Error Handling
  ///
  /// ### DioException Errors
  /// - **Network Errors**: Detects connection issues and shows "Check Your Network Connection"
  /// - **HTTP Errors**: Extracts error messages from response using [errorKey]
  /// - **Validation Errors**: When [errorKey] is 'data', uses [convertValidationErrorsToReadable]
  ///   to format validation errors into readable messages
  ///
  /// ### Generic Errors
  /// - Falls back to "Something went wrong" for unknown error types
  ///
  /// ## Parameters
  ///
  /// - [error]: The error object caught during the API request.
  ///   Typically a [DioException] or other Exception.
  ///
  /// ## Processing Steps
  ///
  /// 1. Logs the raw error for debugging
  /// 2. Determines error type and extracts appropriate message
  /// 3. Executes [onError] callback if provided
  /// 4. Shows error toast if [toastSetting] allows it
  /// 5. Returns `false` to indicate failure
  ///
  /// ## Error Response Format
  ///
  /// Expected error response format:
  /// ```json
  /// {
  ///   "message": "Validation failed",
  ///   "data": {
  ///     "email": ["Email is required"],
  ///     "password": ["Password must be at least 8 characters"]
  ///   }
  /// }
  /// ```
  ///
  /// For validation errors, the [convertValidationErrorsToReadable] function
  /// will format this into: "Email is required. Password must be at least 8 characters."
  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      // Handle network connection errors first
      if (error.type == DioExceptionType.connectionError) {
        message = 'Check Your Network Connection';
      }
      // Handle validation errors (when errorKey is 'data')
      else if (errorKey == 'data' && error.response?.data['data'] != null) {
        message = convertValidationErrorsToReadable(
          error.response?.data['data'],
        );
      }
      // Handle general error messages
      else {
        message =
            error.response?.data[errorKey ?? 'message'] ??
            error.response?.data['message'] ??
            'Something went wrong';
      }
    }
    if (onError != null) {
      onError!(message);
    }
    if (toastSetting == PutToastSetting.both ||
        toastSetting == PutToastSetting.error) {
      customToastMessage('Error', message);
    }
    return false;
  }
}

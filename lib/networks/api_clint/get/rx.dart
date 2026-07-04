import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

/// A reactive wrapper around [GetApi] that exposes a [BehaviorSubject]-backed
/// stream for a single GET resource of type [T].
///
/// This class fetches data using [GetApi.get], converts the response to [T]
/// using the optional [fromJson] transformer, and pushes results into
/// [dataFetcher]. Consumers can listen to [getStream] for updates.
///
/// Type parameter contract:
/// - If [fromJson] is provided, the raw API response map will be passed to it
///   and its return value will be emitted as [T].
/// - If [fromJson] is omitted, [T] must be compatible with
///   `Map<String, dynamic>` because [GetApi.get] returns a map. In that case,
///   the raw map will be emitted as-is.
///
/// Error semantics:
/// - On success, [handleSuccessWithReturn] adds the parsed value to
///   [dataFetcher] and returns it.
/// - On failure, [handleErrorWithReturn] adds the error to [dataFetcher] and
///   rethrows it. Callers should `try/catch` [fetch].
///
/// Example
/// ```dart
/// // Model
/// class User {
///   final String id;
///   User({required this.id});
///   factory User.fromJson(Map<String, dynamic> json) => User(id: json['id']);
///   static User empty() => User(id: '');
/// }
///
/// // Reactive GET
/// final userRx = GetRx<User>(
///   empty: User.empty(),
///   dataFetcher: BehaviorSubject<User>.seeded(User.empty()),
///   endpoint: '/users/',
///   fromJson: (map) => User.fromJson(map),
/// );
///
/// // Later
/// await userRx.fetch(id: '123'); // GET /users/123 and emit User
/// userRx.getStream.listen((user) { /* handle updates */ });
/// ```
final class GetRx<T> extends RxResponseInt<T> {
  /// Singleton API client used to perform GET requests.
  final api = GetApi.instance;

  /// Base endpoint for the GET request. If null, [id] must contain the full
  /// URL or path to be requested.
  final String? endpoint;

  /// Optional transformer that converts a JSON map into an instance of [T].
  /// If omitted, the raw `Map<String, dynamic>` from the API will be emitted
  /// and thus [T] should be `Map<String, dynamic>`.
  final T Function(Map<String, dynamic>)? fromJson;
  GetRx({
    this.fromJson,
    this.endpoint,
    required super.empty,
    required super.dataFetcher,
    this.defaultQueryParameters,
  });

  final Map<String, dynamic>? defaultQueryParameters;

  /// A read-only [ValueStream] view of the internal [BehaviorSubject].
  ///
  /// Since a [BehaviorSubject] is used, listeners receive the latest value
  /// immediately upon subscription (the seeded [empty] value initially).
  ValueStream<T> get getStream => dataFetcher.stream;

  /// Fetch data from the API and emit it on [getStream].
  ///
  /// - [dynamicEndpoint]: Optional identifier appended to [endpoint]. If [endpoint] is
  ///   `null`, [dynamicEndpoint] is treated as the full request path.
  /// - Returns `true` when a value is successfully fetched and emitted.
  ///
  /// Error handling:
  /// - On error, the error is added to the stream and rethrown. In that case
  ///   the returned future completes with an error; callers should handle via
  ///   `try/catch`.
  Future<bool> fetch({
    String? dynamicEndpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      //// start printing
      final endpointToUse = dynamicEndpoint ?? endpoint;

      String queryString = '';
      if (queryParameters != null && queryParameters.isNotEmpty) {
        queryString =
            '?${queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&')}';
      }

      // Print full URL
      print('API call: $endpointToUse$queryString');
      //end printing

      final dynamic json = await api.get(
        endpoint: endpoint,
        dynamicEndpoint: dynamicEndpoint,
        defaultQueryParameters: defaultQueryParameters,

        queryParameters: queryParameters,
      );
      if (fromJson != null) {
        final T data = fromJson!(json);
        handleSuccessWithReturn(data);
      } else {
        handleSuccessWithReturn(json);
      }

      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  void fetchData() {}
}

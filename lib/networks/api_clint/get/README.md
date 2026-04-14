# GET client module

This module provides a tiny reactive GET client built on top of Dio and rxdart.

- `api.dart` exposes a singleton `GetApi` with:
  - `Future<Map<String, dynamic>> get({ String? endpoint, String? id })`: Performs a GET request using the configured Dio client. If the server returns a non-map payload, it is wrapped into `{ 'itemList': ... }` for convenience.
  - `Future<Map<String, dynamic>> reload()`: Repeats the last successful GET call.

- `rx.dart` exposes `GetRx<T>`, a reactive wrapper that:
  - Accepts an initial `empty` value and a `BehaviorSubject<T>` as `dataFetcher`.
  - Optionally accepts a `fromJson(Map<String, dynamic>) -> T` transformer.
  - Provides a `ValueStream<T> getStream` to listen for updates.
  - `fetch({String? id})` performs the GET request via `GetApi` and emits results to the stream.

## Usage

```dart
// Model
class User {
  final String id;
  User({required this.id});
  factory User.fromJson(Map<String, dynamic> json) => User(id: json['id']);
  static User empty() => User(id: '');
}

// Reactive GET client
final userRx = GetRx<User>(
  empty: User.empty(),
  dataFetcher: BehaviorSubject<User>.seeded(User.empty()),
  endpoint: '/users/',
  fromJson: (map) => User.fromJson(map),
);

// Trigger a fetch and listen for updates
await userRx.fetch(id: '123'); // GET /users/123
final sub = userRx.getStream.listen((user) {
  // handle latest user
});

// When done
sub.cancel();
userRx.dispose();
```

### Error handling
- On failure, `fetch` adds the error to the stream and rethrows it. Use `try/catch` when awaiting `fetch`, and optionally listen to `getStream` error events.

```dart
try {
  await userRx.fetch(id: '123');
} catch (e) {
  // handle error
}
```

### Notes
- If you omit `fromJson`, set `T` to `Map<String, dynamic>` because `GetApi.get` returns a map.
- For list responses, build your own adapter in `fromJson` (e.g., read `map['itemList']` and transform).

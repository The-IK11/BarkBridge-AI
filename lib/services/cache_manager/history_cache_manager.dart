import 'package:barkbridgeai/feature/analyzed%20history/model/analyzed_history_model.dart';

/// In-memory cache for analyzed history data.
///
/// Holds the fetched items, pagination state, and exposes helpers so the
/// [AnalyzedHistoryScreen] can skip redundant API calls when navigating
/// back to the screen.
///
/// The cache lives as long as the app process is alive. It is invalidated
/// when:
/// - The user explicitly pulls-to-refresh.
/// - [clearCache] is called (e.g. after a new analysis is submitted).
class HistoryCacheManager {
  // ── Singleton ──────────────────────────────────────────────────────────────
  HistoryCacheManager._();
  static final HistoryCacheManager instance = HistoryCacheManager._();

  // ── Cached state ───────────────────────────────────────────────────────────
  final List<AnalyzedHistoryScanItem> _items = [];
  int _currentPage = 1;
  int _lastPage = 1;
  bool _hasData = false;

  // ── Getters ────────────────────────────────────────────────────────────────
  List<AnalyzedHistoryScanItem> get items => List.unmodifiable(_items);
  int get currentPage => _currentPage;
  int get lastPage => _lastPage;
  bool get hasData => _hasData;
  bool get hasMorePages => _currentPage < _lastPage;

  // ── Mutators ───────────────────────────────────────────────────────────────

  /// Replace the entire cache (used on first load / pull-to-refresh).
  void setInitialData({
    required List<AnalyzedHistoryScanItem> items,
    required int currentPage,
    required int lastPage,
  }) {
    _items.clear();
    _items.addAll(items);
    _currentPage = currentPage;
    _lastPage = lastPage;
    _hasData = true;
  }

  /// Append a new page of items (used for scroll pagination).
  void appendPage({
    required List<AnalyzedHistoryScanItem> items,
    required int currentPage,
    required int lastPage,
  }) {
    _items.addAll(items);
    _currentPage = currentPage;
    _lastPage = lastPage;
  }

  /// Clear all cached data so the next visit triggers a fresh API call.
  void clearCache() {
    _items.clear();
    _currentPage = 1;
    _lastPage = 1;
    _hasData = false;
  }
}

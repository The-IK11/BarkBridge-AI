# Dart/Flutter scroll pagination implementation guidelines

This guide explains how to implement list pagination (infinite scrolling) in this Flutter project, adhering to the established reactive pattern present in [analyzed_history_screen.dart](file:///c:/Users/ibrah/ibrahims app/tintpin14_app/lib/feature/analyzed history/presenation/analyzed_history_screen.dart).

This pattern uses RxDart (`GetRx` client streams) to fetch paginated data, accumulates lists in the widget state, manages scroll listeners, and supports pull-to-refresh.

---

## 1. Key State Variables

Declare the following state variables inside your `StatefulWidget` class:

```dart
final ScrollController _scrollController = ScrollController();

// ── Accumulated list across all pages ──
final List<ItemType> _allItems = [];
int _currentPage = 1;
int _lastPage = 1;
bool _isFetchingMore = false;
bool _isRefreshing = false;
```

---

## 2. Lifecycle Setup (initState / dispose)

Configure the scroll controller listener and request the first page on widget initialization, and clean up the controller on dispose:

```dart
@override
void initState() {
  super.initState();
  _scrollController.addListener(_onScroll);
  _fetchPage(page: 1, isRefresh: true);
}

@override
void dispose() {
  _scrollController.dispose();
  super.dispose();
}
```

---

## 3. Scroll and Pull-to-Refresh Listeners

Trigger page fetches only when the user scrolls near the bottom of the list and more pages are available:

```dart
// ── Scroll listener ──
void _onScroll() {
  final isAtBottom = _scrollController.position.pixels >=
      _scrollController.position.maxScrollExtent - 200; // Trigger 200px before bottom

  final hasMorePages = _currentPage < _lastPage;

  if (isAtBottom && hasMorePages && !_isFetchingMore && !_isRefreshing) {
    _fetchPage(page: _currentPage + 1);
  }
}

// ── Pull-to-refresh handler ──
Future<void> _onRefresh() async {
  await _fetchPage(page: 1, isRefresh: true);
}
```

---

## 4. Paginated Page Fetching Method

Use the reactive `GetRx` client to fetch and parse the data. The dynamic endpoint url should contain limit and page queries, e.g. `Endpoints.somePath(limit, page)`.

```dart
Future<void> _fetchPage({required int page, bool isRefresh = false}) async {
  if (_isFetchingMore || _isRefreshing) return;

  setState(() {
    if (isRefresh) {
      _isRefreshing = true;
    } else {
      _isFetchingMore = true;
    }
  });

  // Call the GetRx fetch method
  await getSomeDataRx.fetch(
    dynamicEndpoint: Endpoints.getSomeData(10, page), // limit = 10, page
  );

  final response = getSomeDataRx.getStream.value;
  final pagination = response?.data;
  final newItems = pagination?.data ?? [];

  setState(() {
    if (isRefresh) {
      // Clear accumulated items and reset page on refresh
      _allItems.clear();
      _currentPage = 1;
      _isRefreshing = false;
    } else {
      _isFetchingMore = false;
    }

    _allItems.addAll(newItems);
    _currentPage = pagination?.currentPage ?? page;
    _lastPage = pagination?.lastPage ?? 1;
  });
}
```

---

## 5. UI Build Structure

Use `RefreshIndicator` and a `StreamBuilder` listening to `getSomeDataRx.getStream`.
The layout inside the builder must use a `CustomScrollView` with the scroll controller.

```dart
@override
Widget build(BuildContext context) {
  return GlowBackground(
    appBar: CustomAppBar(
      title: "Title Here",
      showBackButton: true,
    ),
    child: SafeArea(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        backgroundColor: AppColors.allPrimaryColor,
        child: StreamBuilder(
          stream: getSomeDataRx.getStream,
          builder: (context, snapshot) {
            // ── 1. Initial full-page loading ──
            if (_isRefreshing && _allItems.isEmpty) {
              return const WaitingWidget();
            }

            // ── 2. Empty state ──
            if (_allItems.isEmpty) {
              return Center(
                child: Text(
                  "No data available",
                  style: TextFontStyle.textstyle14cFFFFFFManrope500,
                ),
              );
            }

            // ── 3. Scrollable List ──
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  sliver: SliverList.separated(
                    itemCount: _allItems.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      return ItemCard(item: _allItems[index]);
                    },
                  ),
                ),
                
                // ── 4. Bottom loader / End-of-list adapter ──
                SliverToBoxAdapter(
                  child: _buildBottomLoader(),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}
```

---

## 6. Bottom Loader and Feedback Indicator

Add a bottom loader that indicates additional loading, or displays a descriptive message once all pages have been fetched:

```dart
Widget _buildBottomLoader() {
  if (_isFetchingMore) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.allPrimaryColor),
        ),
      ),
    );
  }

  // Show "no more data" feedback when all pages loaded
  if (_currentPage >= _lastPage && _allItems.isNotEmpty && _allItems.length >= 10) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: Text(
          "You've reached the end",
          style: TextFontStyle.textstyle14cFFFFFFManrope500,
        ),
      ),
    );
  }

  return SizedBox(height: 20.h);
}
```

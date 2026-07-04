
import 'dart:typed_data';
import 'dart:ui';

import 'package:barkbridgeai/common_widgets/custom_network_image.dart';
import 'package:barkbridgeai/common_widgets/custom_app_bar.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/common_widgets/waiting_widget.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/feature/analyzed%20history/model/analyzed_history_model.dart';
import 'package:barkbridgeai/feature/analyzed%20history/presenation/analyzed_history_details_screen.dart';
import 'package:barkbridgeai/feature/analyzed%20history/widget/video_thumnail.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/helpers/ui_helpers.dart';
import 'package:barkbridgeai/networks/api_access.dart';
import 'package:barkbridgeai/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AnalyzedHistoryScreen extends StatefulWidget {
  const AnalyzedHistoryScreen({super.key});

  @override
  State<AnalyzedHistoryScreen> createState() => _AnalyzedHistoryScreenState();
}

class _AnalyzedHistoryScreenState extends State<AnalyzedHistoryScreen> {
  static const String baseUrl = 'https://barkbridgeai.tech/';

  final ScrollController _scrollController = ScrollController();

  // ── Accumulated list across all pages ──
  final List<AnalyzedHistoryScanItem> _allItems = [];
  int _currentPage = 1;
  int _lastPage = 1;
  bool _isFetchingMore = false;
  bool _isRefreshing = false;

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

  // ── Fetch a specific page ──────────────────────────────────────────────────
  Future<void> _fetchPage({required int page, bool isRefresh = false}) async {
    if (_isFetchingMore || _isRefreshing) return;

    setState(() {
      if (isRefresh) {
        _isRefreshing = true;
      } else {
        _isFetchingMore = true;
      }
    });

    await getAnalysisHistoryRx.fetch(
      dynamicEndpoint: Endpoints.getAnalysisHistory(10, page),
    );

    final response = getAnalysisHistoryRx.getStream.value;
    final pagination = response?.data;
    final newItems = pagination?.data ?? [];

    setState(() {
      if (isRefresh) {
        // Clear and replace on refresh
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

  // ── Scroll listener ────────────────────────────────────────────────────────
  void _onScroll() {
    final isAtBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;

    final hasMorePages = _currentPage < _lastPage;

    if (isAtBottom && hasMorePages && !_isFetchingMore && !_isRefreshing) {
      _fetchPage(page: _currentPage + 1);
    }
  }

  // ── Pull to refresh ────────────────────────────────────────────────────────
  Future<void> _onRefresh() async {
    await _fetchPage(page: 1, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        title: "Analyzed History",
        showBackButton: false,
      ),
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          backgroundColor: AppColors.allPrimaryColor,
          child: StreamBuilder(
            stream: getAnalysisHistoryRx.getStream,
            builder: (context, snapshot) {
              // ── Initial loading (empty list) ──
              if (_isRefreshing && _allItems.isEmpty) {
                return const WaitingWidget();
              }
      
              // ── Empty state ──
              if (_allItems.isEmpty) {
                return Center(
                  child: Text(
                    "No analysis data available",
                    style: TextFontStyle.textstyle14cFFFFFFManrope500,
                  ),
                );
              }
      
              // ── List ──
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    sliver: SliverList.separated(
                      itemCount: _allItems.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        return HistoryCard(
                          item: _allItems[index],
                          baseUrl: baseUrl,
                        );
                      },
                    ),
                  ),
      
                  // ── Bottom loader ──
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

    // Show "no more data" hint when all pages loaded
    if (_currentPage >= _lastPage && _allItems.isNotEmpty &&_allItems.length >= 10) {
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
}

class HistoryCard extends StatefulWidget {
  final AnalyzedHistoryScanItem item;
  final String baseUrl;

  const HistoryCard({
    super.key,
    required this.item,
    required this.baseUrl,
  });

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  // Cache the future so it doesn't re-run on every rebuild
  Future<Uint8List?>? _thumbnailFuture;

  String get fullMediaUrl => '${widget.baseUrl}${widget.item.filePath ?? ''}';

  @override
  void initState() {
    super.initState();
    if (widget.item.isVideo) {
      _thumbnailFuture = VideoThumbnailHelper.getThumbnailFromUrl(
        url: fullMediaUrl,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => AnalyzedHistoryDetailsScreen(isAIResponseScreen: true,
        aiResponse: widget.item,
        ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: EdgeInsets.all(12.sp),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.lightBlue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color.fromARGB(251, 33, 75, 243).withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                _buildMediaPreview(),
                UIHelper.horizontalSpace(10.w),
                Expanded(child: _buildInfo()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPreview() {
    if (widget.item.isImage) {
      return CustomNetworkImage(
        imageUrl: fullMediaUrl, // ← full URL with baseUrl prefix
        height: 100.h,
        width: 100.w,
        borderRadius: BorderRadius.circular(12.r),
      );
    }

    // Video thumbnail — uses cached future from initState
    return FutureBuilder<Uint8List?>(
      future: _thumbnailFuture,
      builder: (context, snapshot) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: SizedBox(
            height: 100.h,
            width: 100.w,
            child: _thumbnailChild(snapshot),
          ),
        );
      },
    );
  }

  Widget _thumbnailChild(AsyncSnapshot<Uint8List?> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const ColoredBox(
        color: Colors.black26,
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          ),
        ),
      );
    }

    if (snapshot.data == null) {
      return const ColoredBox(
        color: Colors.black26,
        child: Center(
          child: Icon(Icons.videocam_off_rounded, color: Colors.white54, size: 32),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.memory(snapshot.data!, fit: BoxFit.cover),
        // const Center(
        //   child: Icon(Icons.play_circle_fill, color: Colors.white, size: 32),
        // ),
      ],
    );
  }

  Widget _buildInfo() {
    final result = widget.item.result;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoText("Date: ${_formatDate(widget.item.createdAt ?? '')}"),
        UIHelper.verticalSpace(5.h),

        if (result?.isImageResult == true) ...[
          if (result?.mood != null) _infoText("Mood: ${result!.mood}"),
          UIHelper.verticalSpace(5.h),
          if (result?.behavior != null)
            _infoText("Behavior: ${result!.behavior}", maxLines: 1),
        ],

        if (result?.isVideoResult == true) ...[
          if (result?.activity != null)
            _infoText("Activity: ${result!.activity}", maxLines: 1),
          UIHelper.verticalSpace(5.h),
          if (result?.energyLevel != null)
            _infoText("Energy: ${result!.energyLevel}", maxLines: 1),
        ],

        UIHelper.verticalSpace(5.h),
        if (result?.confidenceScore != null)
          _infoText("Confidence: ${result!.confidenceScore}%"),
      ],
    );
  }

  Widget _infoText(String text, {int? maxLines}) {
    return Text(
      text,
      style: TextFontStyle.textstyle14cFFFFFFManrope500,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  String _formatDate(String dateString) {
    try {
      final dt = DateTime.parse(dateString);
      return "${dt.day}/${dt.month}/${dt.year}";
    } catch (_) {
      return dateString;
    }
  }
}
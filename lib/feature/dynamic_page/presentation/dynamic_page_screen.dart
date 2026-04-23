import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/common_widgets/waiting_widget.dart';
import 'package:tintpin14_app/feature/dynamic_page/model/dynamic_page_model.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/helpers/loading_helper.dart';
import 'package:tintpin14_app/networks/api_access.dart';
import 'package:tintpin14_app/networks/endpoints.dart';

class DynamicScreen extends StatefulWidget {
  final String title;
  final String endpoint;
  const DynamicScreen({super.key, required this.title, required this.endpoint});

  @override
  State<DynamicScreen> createState() => _DynamicScreenState();
}

class _DynamicScreenState extends State<DynamicScreen> {
  bool showContent = false;

  @override
  void initState() {
    super.initState();
    _fetchPageData();

    // Show WaitingWidget for 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          showContent = true;
        });
      }
    });
  }

  void _fetchPageData() async {
    getDynamicPageRx.fetch(
      dynamicEndpoint: Endpoints.getDynamicPage(widget.endpoint),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        title: widget.title,
        backgroundColor: Colors.transparent,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
        child: StreamBuilder<DynamicPageModel>(
          stream: getDynamicPageRx.dataFetcher.stream,
          builder: (context, snapshot) {
            // Show loading widget for 1.5 seconds or while fetching
            if (!showContent ||
                snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(height: 200.h),
                  WaitingWidget(),
                ],
              );
            }

            // Show error if connection failed
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading page',
                  style: TextStyle(color: AppColors.cFFFFFF),
                ),
              );
            }

            final pageData = snapshot.data;

            // Show message if data is empty
            if (pageData == null || pageData.data == null) {
              return Center(
                child: Text(
                  'No content available',
                  style: TextStyle(color: AppColors.cFFFFFF),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  // Display HTML content
                  Html(
                    data: pageData.data!.pageContent ?? '',
                    style: {
                      'body': Style(
                        color: AppColors.cFFFFFF,
                        fontSize: FontSize(16.sp),
                        lineHeight: LineHeight(1.6),
                      ),
                      'p': Style(
                        color: AppColors.cFFFFFF,
                        fontSize: FontSize(14.sp),
                        margin: Margins.all(8.0),
                      ),
                      'h1': Style(
                        color: AppColors.cFFFFFF,
                        fontSize: FontSize(24.sp),
                        fontWeight: FontWeight.bold,
                        margin: Margins.symmetric(vertical: 12.0),
                      ),
                      'h2': Style(
                        color: AppColors.cFFFFFF,
                        fontSize: FontSize(20.sp),
                        fontWeight: FontWeight.bold,
                        margin: Margins.symmetric(vertical: 10.0),
                      ),
                      'li': Style(
                        color: AppColors.cFFFFFF,
                        fontSize: FontSize(14.sp),
                        margin: Margins.symmetric(vertical: 6.0),
                      ),
                      'a': Style(
                        color: const Color(0xFF3B53FF),
                        textDecoration: TextDecoration.underline,
                      ),
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barkbridgeai/common_widgets/auth_common_text_form_field.dart';
import 'package:barkbridgeai/common_widgets/custom_app_bar.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/common_widgets/waiting_widget.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/feature/faqAndTermsOfService/model/faq_screen_model.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/networks/api_access.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int selectedTab = 0;
  FaqScreenModel? faqData;
  String searchQuery = '';
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
    _fetchFaqData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _fetchFaqData() {
    getFaqRx.fetch();
    getFaqRx.dataFetcher.stream.listen((data) {
      setState(() {
        faqData = data;
      });
    });
  }

  List<FaqItem> getFilteredFaqsForTab() {
    if (faqData?.data == null || faqData!.data!.isEmpty) {
      return [];
    }
    if (selectedTab >= 0 && selectedTab < faqData!.data!.length) {
      var faqs = faqData!.data![selectedTab].faqs ?? [];
      if (searchQuery.isEmpty) {
        return faqs;
      }
      return faqs
          .where(
            (faq) =>
                faq.question?.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ) ??
                false,
          )
          .toList();
    }
    return [];
  }

  Widget tabBody() {
    // Show waiting widget while data is loading
    if (faqData == null) {
      return const WaitingWidget();
    }

    if (faqData?.data == null || faqData!.data!.isEmpty) {
      return Center(
        child: Text(
          "No FAQs available",
          style: TextStyle(color: AppColors.cFFFFFF),
        ),
      );
    }

    List<FaqItem> faqs = getFilteredFaqsForTab();
    return Column(
      children: List.generate(
        faqs.length,
        (index) => _faqItemWidget(faqs[index]),
      ),
    );
  }

  Widget _faqItemWidget(FaqItem faq) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.c778DFF.withAlpha(20),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            width: 1.w,
            color: AppColors.cFFFFFF.withAlpha(20),
          ),
        ),
        child: ExpansionTile(
          title: Text(
            faq.question ?? '',
            style: TextFontStyle.textstyle14cFFFFFFManrope500,
          ),
          collapsedTextColor: AppColors.cFFFFFF,
          textColor: AppColors.cFFFFFF,
          iconColor: AppColors.cFFFFFF,
          collapsedIconColor: AppColors.cFFFFFF,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                faq.answer ?? '',
                style: TextFontStyle.textstyle14cFFFFFFManrope500.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.cFFFFFF.withAlpha(200),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(title: "FAQ"),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight + 60.h),
              AuthCommonTextFormField(
                prefixIcon: Container(
                  width: 38.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.c3B53FF, AppColors.c2606ED],
                    ),
                  ),
                  child: Icon(Icons.search, color: AppColors.cFFFFFF),
                ),
                controller: searchController,
                hintText: "Search FAQ",
                fillcolor: AppColors.cFFFFFF.withAlpha(8),
                borderColor: AppColors.cFFFFFF.withAlpha(50),
                radius: BorderRadius.circular(16.r),
              ),
              SizedBox(height: 20.h),
              _buildCategoryTabs(),
              SizedBox(height: 12.h),
              tabBody(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    if (faqData == null || faqData?.data == null || faqData!.data!.isEmpty) {
      return SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            faqData!.data!.length,
            (index) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTab = index;
                  });
                },
                child: _tabBarItem(
                  faqData!.data![index].name ?? 'Category',
                  selectedTab == index,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBarItem(String category, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.c778DFF.withAlpha(20),
        borderRadius: BorderRadius.circular(12.r),
        border: isSelected
            ? Border.all(width: 1.w, color: AppColors.cFFFFFF.withAlpha(20))
            : null,
      ),
      child: Center(
        child: Text(
          category,
          style: TextFontStyle.textstyle14cFFFFFFManrope500.copyWith(
            color: isSelected
                ? AppColors.cFFFFFF
                : AppColors.cFFFFFF.withAlpha(70),
          ),
        ),
      ),
    );
  }
}

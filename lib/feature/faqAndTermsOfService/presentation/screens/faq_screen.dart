import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/common_widgets/auth_common_text_form_field.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/faqAndTermsOfService/presentation/widgets/behavior_widget.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int selectedTab = 1;
  Widget tabBody() {
    if (selectedTab == 1) {
      return Behavior();
    } else if (selectedTab == 2) {
      return Center(
        child: Text("Emotions", style: TextStyle(color: AppColors.cFFFFFF)),
      );
    } else if (selectedTab == 3) {
      return Center(
        child: Text("Video", style: TextStyle(color: AppColors.cFFFFFF)),
      );
    } else {
      return Center(
        child: Text("Noise", style: TextStyle(color: AppColors.cFFFFFF)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(title: "FAQ", backgroundColor: Colors.transparent),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 20.h),
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
              controller: TextEditingController(),
              hintText: "Search Location",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              borderColor: AppColors.cFFFFFF.withAlpha(50),
              radius: BorderRadius.circular(16.r),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = 1;
                      });
                    },
                    child: _tabBarItem("Behavior", selectedTab == 1),
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = 2;
                      });
                    },
                    child: _tabBarItem("Emotions", selectedTab == 2),
                  ),
                ),
                // SizedBox(width: 5.w),
                // Expanded(
                //   child: InkWell(
                //     onTap: () {
                //       setState(() {
                //         selectedTab = 3;
                //       });
                //     },
                //     child: _tabBarItem("Video", selectedTab == 3),
                //   ),
                // ),
                SizedBox(width: 5.w),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = 4;
                      });
                    },
                    child: _tabBarItem("Noise", selectedTab == 4),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(child: tabBody()),
          ],
        ),
      ),
    );
  }

  Widget _tabBarItem(String category, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.c778DFF.withAlpha(20),
        borderRadius: BorderRadius.circular(12.r),
        border: isSelected == true
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

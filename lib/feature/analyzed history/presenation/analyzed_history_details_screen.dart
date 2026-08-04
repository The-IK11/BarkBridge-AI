import 'package:barkbridgeai/feature/analyzed%20history/model/analyzed_history_model.dart';
import 'package:barkbridgeai/feature/profile/model/ai_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:barkbridgeai/common_widgets/custom_app_bar.dart';
import 'package:barkbridgeai/common_widgets/custom_button.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/navigation_screen.dart';
import 'package:barkbridgeai/networks/api_access.dart';

class AnalyzedHistoryDetailsScreen extends StatelessWidget {
  final AnalyzedHistoryScanItem? aiResponse;
  final bool isAIResponseScreen;
  const AnalyzedHistoryDetailsScreen({
    super.key,
    required this.isAIResponseScreen,
    this.aiResponse,
  });

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        title: isAIResponseScreen
            ? "AI Analysis Results"
            : "Last Analyzed Results",

        showBackButton: isAIResponseScreen,
      ),
      child: SafeArea(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeOutCubic,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              ),
            );
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Activity Section
                _buildSectionCard(
                  title: "Activity",
                  content: aiResponse?.result!.activity ?? "N/A",
                  icon: Icons.pets,
                ),
                SizedBox(height: 16.h),

                // Social Behavior Section
                _buildSectionCard(
                  title: "Social Behavior",
                  content: aiResponse?.result!.socialBehavior ?? "N/A",
                  icon: Icons.group,
                ),
                SizedBox(height: 16.h),

                // Energy Level Section
                _buildSectionCard(
                  title: "Energy Level",
                  content: aiResponse?.result!.energyLevel ?? "N/A",
                  icon: Icons.flash_on,
                ),
                SizedBox(height: 16.h),

                // Behavioral Flags Section
                if (aiResponse?.result?.behavioralFlags != null &&
                    aiResponse!.result!.behavioralFlags!.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F1125),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.c3B53FF.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flag,
                              color: AppColors.c3B53FF,
                              size: 20.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Behavioral Flags",
                              style: TextFontStyle.textStyle14c171717OpenSans600
                                  .copyWith(color: AppColors.c3B53FF),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: aiResponse!.result!.behavioralFlags!
                              .map<Widget>(
                                (flag) => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.c3B53FF.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: AppColors.c3B53FF,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    flag,
                                    style: TextFontStyle
                                        .textStyle14c171717OpenSans600
                                        .copyWith(
                                          color: AppColors.cFFFFFF,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 16.h),

                // Enrichment Needs Section
                _buildSectionCard(
                  title: "Enrichment Needs",
                  content: aiResponse?.result?.enrichmentNeeds ?? "N/A",
                  icon: Icons.lightbulb,
                ),
                SizedBox(height: 16.h),

                // Confidence Score Section
                if (aiResponse?.result?.confidenceScore != null)
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F1125),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.c3B53FF.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Confidence Score",
                          style: TextFontStyle.textStyle14cFFFFFFOpenSans400
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${aiResponse!.result!.confidenceScore}%",
                          style: TextFontStyle.textStyle14cFFFFFFOpenSans400
                              .copyWith(color: AppColors.c3B53FF),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 20.h),
                if (isAIResponseScreen)
                  CustomButton(
                    text: "Back To Home",
                    onPressed: () {
                      Get.offAll(() {
                        return NavigationScreen();
                      });
                    },
                  ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1125),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.c3B53FF.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.c3B53FF, size: 20.sp),
              SizedBox(width: 10.w),
              Text(
                title,
                style: TextFontStyle.textStyle14cFFFFFFOpenSans400.copyWith(
                  color: AppColors.c3B53FF,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            style: TextFontStyle.textStyle14cFFFFFFOpenSans400.copyWith(
              fontWeight: FontWeight.w300,
              height: 1.6,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:barkbridgeai/common_widgets/custom_app_bar.dart';
// import 'package:barkbridgeai/common_widgets/glow_background.dart';
// import 'package:barkbridgeai/constants/text_font_style.dart';
// import 'package:barkbridgeai/gen/colors.gen.dart';
// import 'package:barkbridgeai/navigation_screen.dart';

// class AiResponseScreen extends StatelessWidget {
//   const AiResponseScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GlowBackground(
//       appBar: CustomAppBar(
//         title: "AI Response",
//         backgroundColor: Colors.transparent,
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(
//           children: [
//             SizedBox(height: kToolbarHeight + 20.h),
//             Text(
//               "By observing a dog’s body movements, you can understand what it is trying to say without hearing a single word. A relaxed posture, loose tail wag, and soft eyes usually mean the dog feels safe, friendly, or happy. A stiff body, raised tail, or frozen stance can signal alertness, fear, or discomfort. When a dog lowers its body, avoids eye contact, or tucks its tail, it may be feeling anxious or asking for reassurance. Jumping, spinning, or quick movements often show excitement or a desire to play, while pacing or repeated glances toward something can mean the dog wants attention, food, or to go outside. Every small movement—ears, tail, posture, and motion—works together to express what the dog is feeling and what it wants in that moment.",
//               style: TextFontStyle.textstyle14cFFFFFFManrope500.copyWith(
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: 0,
//         onTap: (index) {},
//       ),
//     );
//   }
// }

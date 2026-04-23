import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/faqAndTermsOfService/presentation/screens/faq_screen.dart';
import 'package:tintpin14_app/feature/profile/presentation/widgets/upgradePlanBanner.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/helpers/all_routes.dart';
import 'package:tintpin14_app/helpers/navigation_service.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notificationState = false;
  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        title: "Settings",

        backgroundColor: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kToolbarHeight + 20.h),

              SizedBox(height: 15.h),
              Text(
                "Membership",
                style: TextFontStyle.textstyle16c5465A6Manrope500,
              ),
              SizedBox(height: 20.h),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  "Subscription Info",
                  style: TextFontStyle.textstyle16cFFFFFFManrope500,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20.sp,
                  color: AppColors.c5465A6,
                ),
              ),

              SizedBox(height: 30.h),
              Text("About", style: TextFontStyle.textstyle16c5465A6Manrope500),
              settingContent("Privacy Policy"),
              dividerLine(),
              settingContent("Term of Service"),
              dividerLine(),
              settingContent("Copyright Policy"),
              SizedBox(height: 30.h),
              Text(
                "Support",
                style: TextFontStyle.textstyle16c5465A6Manrope500,
              ),
              settingContent("Contact Us"),
              dividerLine(),
              settingContent("Tutorials"),
              dividerLine(),
              InkWell(
                onTap: () {
                  NavigationService.navigateTo(Routes.faqScreen);
                },
                child: settingContent("FAQ"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dividerLine() {
    return Container(
      height: 1.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.c0A1C3C.withAlpha(0),
            AppColors.c0A1C3C,
            AppColors.c0A1C3C,
            AppColors.c0A1C3C.withAlpha(0),
          ],
        ),
      ),
    );
  }

  Widget settingContent(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(title, style: TextFontStyle.textstyle16cFFFFFFManrope500),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 20.sp,
        color: AppColors.c5465A6,
      ),
    );
  }
}

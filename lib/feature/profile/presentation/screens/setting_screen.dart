import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barkbridgeai/common_widgets/custom_app_bar.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/helpers/all_routes.dart';
import 'package:barkbridgeai/helpers/navigation_service.dart';
import 'package:barkbridgeai/networks/endpoints.dart';

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
      appBar: CustomAppBar(title: "Settings"),
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
              InkWell(
                onTap: () {
                  NavigationService.navigateTo(Routes.subscriptionScreen);
                },
                child: ListTile(
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
              ),

              SizedBox(height: 30.h),
              Text("About", style: TextFontStyle.textstyle16c5465A6Manrope500),
              settingContent("About Us"),
              dividerLine(),
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
              settingContent("FAQ"),
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
    return InkWell(
      onTap: () {
        if (title == "Privacy Policy") {
          NavigationService.navigateToWithArgs(Routes.dynamicPageScreen, {
            "title": "Privacy Policy",
            "endpoint": Endpoints.getPrivacyPolicy(),
          });
        } else if (title == "Term of Service") {
          NavigationService.navigateToWithArgs(Routes.dynamicPageScreen, {
            "title": "Term of Service",
            "endpoint": Endpoints.getTermsOfService(),
          });
        } else if (title == "Copyright Policy") {
          NavigationService.navigateToWithArgs(Routes.dynamicPageScreen, {
            "title": "Copyright Policy",
            "endpoint": Endpoints.copyRightPolicy(),
          });
        } else if (title == "Contact Us") {
          NavigationService.navigateToWithArgs(Routes.dynamicPageScreen, {
            "title": "Contact Us",
            "endpoint": Endpoints.contactUs(),
          });
        } else if (title == "Tutorials") {
          NavigationService.navigateToWithArgs(Routes.dynamicPageScreen, {
            "title": "Tutorials",
            "endpoint": Endpoints.tutorials(),
          });
        } else if (title == "About Us") {
          NavigationService.navigateToWithArgs(Routes.dynamicPageScreen, {
            "title": "About Us",
            "endpoint": Endpoints.aboutUs(),
          });
        } else {
          NavigationService.navigateTo(Routes.faqScreen);
        }
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Text(title, style: TextFontStyle.textstyle16cFFFFFFManrope500),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 20.sp,
          color: AppColors.c5465A6,
        ),
      ),
    );
  }
}

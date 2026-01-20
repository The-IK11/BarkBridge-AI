import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/plansAndPricing/screens/plan_and_pricing_screen.dart';
import 'package:tintpin14_app/feature/profile/presentation/screens/account_details_screen.dart';
import 'package:tintpin14_app/feature/profile/presentation/screens/edit_profile_screen.dart';
import 'package:tintpin14_app/feature/profile/presentation/screens/setting_screen.dart';
import 'package:tintpin14_app/feature/profile/presentation/widgets/upgradePlanBanner.dart';
import 'package:tintpin14_app/gen/assets.gen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextFontStyle.textstyle20cFFFFFFManrope600,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight + 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 160.h,
                    width: 160.w,
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border(
                        left: BorderSide(color: AppColors.c0454CB, width: 1.w),
                        right: BorderSide(color: AppColors.c0454CB, width: 1.w),
                      ),
                    ),
                    child: Container(
                      width: 123.w,
                      height: 123.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.c86A1FF,
                      ),
                      child: Container(
                        width: 105.w,
                        height: 105.h,
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: Image.asset(
                            Assets.images.errorImage.path,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColors.c778DFF.withAlpha(8),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.cFFFFFF.withAlpha(50),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Kevin Worthen",
                      style: TextFontStyle.textstyle20cFFFFFFManrope600
                          .copyWith(fontSize: 24.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "kevin.worthen65@gmail.com",
                      style: TextFontStyle.textstyle15c5465A6Manrope400,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              dividerLine(),
              InkWell(
                onTap: () {
                  Get.to(() => EditProfileScreen());
                },
                child: ListTile(
                  leading: Text(
                    "Edit Profile",
                    style: TextFontStyle.textstyle16cFFFFFFManrope500,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: AppColors.c5465A6,
                  ),
                ),
              ),
              //SizedBox(height: 25.h),
              dividerLine(),
              InkWell(
                onTap: () {
                  Get.to(() => AccountDetailsScreen());
                },
                child: ListTile(
                  leading: Text(
                    "Account Details",
                    style: TextFontStyle.textstyle16cFFFFFFManrope500,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: AppColors.c5465A6,
                  ),
                ),
              ),
              dividerLine(),

              InkWell(
                onTap: () {
                  Get.to(() => SettingScreen());
                },
                child: ListTile(
                  leading: Text(
                    "Settings",
                    style: TextFontStyle.textstyle16cFFFFFFManrope500,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: AppColors.c5465A6,
                  ),
                ),
              ),
              dividerLine(),
              SizedBox(height: 25.h),
              // Container(
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       colors: [AppColors.c3B53FF, AppColors.c2709E0],
              //     ),
              //     border: Border.all(width: 1.5.w, color: AppColors.cFFFFFF),
              //   ),
              //   child: Column(children: [

              //     ],
              //   ),
              // ),
              InkWell(
                onTap: () {
                  Get.to(() => PlanAndPricingScreen());
                },
                child: UpgradePlanBanner(),
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
}

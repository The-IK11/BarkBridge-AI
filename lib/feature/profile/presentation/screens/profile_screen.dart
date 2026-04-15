import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/custom_network_image.dart';
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
              avatar(),
              SizedBox(height: 15.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColors.c778DFF.withAlpha(30),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    width: 1.w,
                    color: const Color.fromARGB(
                      255,
                      148,
                      142,
                      142,
                    ).withAlpha(50),
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

  Stack avatar() {
    return Stack(
      children: [
        Container(
          height: 170.h,
          width: 230.w,
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.avatarEillipes.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 28.w,
          child: Container(
            height: 170.h,
            width: 180.w,
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(Assets.images.avatarBorder.path),
                fit: BoxFit.cover,
              ),
            ),

            child: Container(
              margin: EdgeInsets.all(20.sp),
              width: 123.w,
              height: 123.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4.6.w,
                  color: Color.fromARGB(255, 37, 48, 89),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 72.w,
          top: 39.h,
          child: CustomNetworkImage(
            isCircular: true,
            width: 85.w,
            height: 85.h,
            imageUrl: '',
            fit: BoxFit.cover,
          ),
        ),

        // Positioned(
        //   left: 130.w,
        //   top: 100.h,
        //   child: InkWell(
        //     onTap: () {},
        //     child: Container(
        //       width: 30.w,
        //       height: 30.h,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: const Color.fromARGB(255, 9, 58, 232),
        //       ),
        //       child: Icon(
        //         Icons.camera_alt_outlined,
        //         size: 18.sp,
        //         color: AppColors.cFFFFFF,
        //       ),
        //     ),
        //   ),
        // ),
      ],
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

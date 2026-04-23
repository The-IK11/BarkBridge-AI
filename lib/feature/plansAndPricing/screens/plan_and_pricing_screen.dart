import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/gen/assets.gen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/helpers/navigation_service.dart';

class PlanAndPricingScreen extends StatelessWidget {
  const PlanAndPricingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        showBackButton: true,

        title: "Plans and Pricing",
        leading: InkWell(
          borderRadius: BorderRadius.circular(50.r),
          onTap: () {
            NavigationService.goBack;
          },
          child: Icon(Icons.close, color: Colors.white, size: 20.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kToolbarHeight + 30.h),
              Center(
                child: Image.asset(
                  Assets.icons.whiteCrownIcon.path,
                  width: 80.w,
                  height: 80.h,
                ),
              ),
              SizedBox(height: 10.h),
              dividerLine(),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.c3B53FF,
                      AppColors.c2606ED,
                      AppColors.c3B53FF,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MONTHLY",
                      style: TextFontStyle.textstyle16cFFFFFFManrope500
                          .copyWith(
                            color: AppColors.cC2C2C2,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$20.00",
                          style: TextFontStyle.textstyle28cFFFFFFManrope700,
                        ),
                        Text(
                          "/Per Month",
                          style: TextFontStyle.textstyle16c5465A6Manrope500
                              .copyWith(color: AppColors.cC2C2C2),
                        ),
                      ],
                    ),
                    premiumFacility("Up to 300 scans per month"),
                    premiumFacility("Fair use cap applies"),
                    premiumFacility("Premium features unlocked"),
                    premiumFacility("Monthly usage counter reset"),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              dividerLine(),
              SizedBox(height: 20.h),
              Text(
                "CREDIT PACKS",
                style: TextFontStyle.textstyle16c5465A6Manrope500,
              ),
              SizedBox(height: 25.h),
              creditPack(),
              SizedBox(height: 20.h),
              creditPack(),
              SizedBox(height: 20.h),
              CustomButton(
                text: "Continue with \$20.00/monthly",
                onPressed: () {},
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Privacy Policy",
                      style: TextFontStyle.textstyle15c5465A6Manrope400
                          .copyWith(fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    height: 5.h,
                    width: 5.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.c2400FF,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Terms of Use",
                      style: TextFontStyle.textstyle15c5465A6Manrope400
                          .copyWith(fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
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

  Widget premiumFacility(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Assets.icons.bubbleTickIcon.image(width: 24.w, height: 24.h),
      title: Text(
        title,
        style: TextFontStyle.textstyle16c5465A6Manrope500.copyWith(
          color: AppColors.cFFFFFF,
        ),
      ),
    );
  }

  Widget creditPack() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: AppColors.c3B53FF),
        borderRadius: BorderRadius.circular(26.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "10 Credits",
                style: TextFontStyle.textstyle16c5465A6Manrope500.copyWith(
                  color: AppColors.cC2C2C2,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$3.99",
                    style: TextFontStyle.textstyle28cFFFFFFManrope700,
                  ),
                  Text(
                    "/One-time purchase",
                    style: TextFontStyle.textstyle16c5465A6Manrope500.copyWith(
                      color: AppColors.cC2C2C2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              gradient: LinearGradient(
                colors: [AppColors.c3B53FF, AppColors.c2400FF],
              ),
            ),
            child: Text(
              "Buy Now",
              style: TextFontStyle.textstyle16cFFFFFFManrope500.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

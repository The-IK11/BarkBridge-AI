import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/gen/assets.gen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({super.key, this.imageUrl, this.title, this.subtitle});
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageUrl ?? Assets.images.onboarding1Image.path,
          width: double.infinity,
        ),
        Text(
          title ?? "Your Dog Is Talking to You",
          style: TextFontStyle.textstyle11cB8BBCCManrope400.copyWith(
            fontSize: 35.sp,
            color: AppColors.cFFFFFF,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        Text(
          subtitle ??
              "Record a howl and turn it into a message you can understand",
          style: TextFontStyle.textstyle11cB8BBCCManrope400.copyWith(
            fontSize: 17.sp,
            color: AppColors.c5465A6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

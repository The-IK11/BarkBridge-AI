import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'common_widgets/safe_scaffold.dart';
import 'gen/assets.gen.dart';

final class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          //decoration: const BoxDecoration(color: AppColors.allPrimaryColor),
          child: Center(
            child: SizedBox(
              // child: shimmer(
              //   context: context,
              //   //name: Assets.lottie.loadingSpinner,
              //   name: Assets.icons.welcomeLogo.path,
              //   size: 150.sp,
              //   color: AppColors.allPrimaryColor,
              // ),
              child: Image.asset(Assets.images.splashImage.path),
            ),
          ),
        ),
      ),
    );
  }
}

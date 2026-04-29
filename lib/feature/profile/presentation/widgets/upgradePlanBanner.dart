import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/gen/fonts.gen.dart';

class UpgradePlanBanner extends StatelessWidget {
  const UpgradePlanBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. The Main Gradient Container
        Container(
          width: double.infinity,
          //height: 110.h,
          padding: EdgeInsets.only(
            left: 20.w,
            top: 16.h,
            bottom: 16.h,
            right: 60.w,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.c2709E0, AppColors.c3B53FF],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Crown Icon with decorative "+" marks
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.workspace_premium,
                    color: Colors.white,
                    size: 50.sp,
                  ),
                  // Small decorative crosses can be added here with Positioned
                ],
              ),
              SizedBox(width: 15.w),
              // Text Content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upgrade Your Plan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.manrope,
                      ),
                    ),
                    Text(
                      "understand your dog like never before",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.manrope,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 2. The Precise Arrow Button Position
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 70.w,
            height: 70.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.white.withAlpha(80), Colors.white.withAlpha(0)],
                center: const Alignment(0.5, 0.5),
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24.r),
              ),
            ),
            child: Container(
              width: 40.w,
              height: 40.w,
              margin: EdgeInsets.only(
                top: 10.h,
                left: 10.w,
              ), // Adjust to match image nudge
              decoration: const BoxDecoration(
                color: Colors.transparent, // Or a slightly lighter solid blue
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

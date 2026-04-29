import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';

class CustomTabBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int length;

  const CustomTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.length = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 144.w,
      child: Row(
        children: List.generate(
          length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                width: index == currentIndex ? 37.w : 144.w,
                //margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: index == currentIndex ? 7.h : 3.h,
                decoration: BoxDecoration(
                  color: index == currentIndex
                      ? AppColors.cFFFFFF
                      : AppColors.c111F47,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

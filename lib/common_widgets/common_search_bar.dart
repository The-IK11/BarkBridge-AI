import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class CommonSearchBar extends StatefulWidget {
  const CommonSearchBar({super.key, this.controller});

  final TextEditingController? controller;

  @override
  State<CommonSearchBar> createState() => _CommonSearchBarState();
}

class _CommonSearchBarState extends State<CommonSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 336,
      // height: 50.h,
      // padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 9.h),
      decoration: ShapeDecoration(
        color: const Color(0xFFFAFAFA),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFF2F2F2)),
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 16.h,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.c838383, size: 24.sp),
          // suffixIcon: FittedBox(
          //   child: Container(
          //     alignment: Alignment.center,
          //     padding: EdgeInsets.zero,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(8.r),
          //         color: AppColors.c027A48),
          //     child: Padding(
          //       padding: EdgeInsets.all(8.0.sp),
          //       child: Image.asset(
          //         height: 16.h,
          //         width: 16.w,
          //         Assets.icons.appleIcon.path,
          //       ),
          //     ),
          //   ),
          // ),
          hintStyle: TextFontStyle.textStylec14c02505FChakraPetch700,
          // contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: InputBorder.none,
          hintText: 'Search here...',
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _searchTEController.dispose();
  //   super.dispose();
  // }
}

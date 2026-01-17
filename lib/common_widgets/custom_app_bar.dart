import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import '../helpers/navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? iconThemeColor;
  final VoidCallback? onBackButtonPressed;
  final Widget? leading;

  @override
  final Size preferredSize;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.titleStyle,
    this.backgroundColor,
    this.iconThemeColor,
    this.onBackButtonPressed,
    this.leading,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      leading:
          leading ??
          InkWell(
            onTap: () {
              if (onBackButtonPressed != null) {
                onBackButtonPressed!();
              } else {
                // Default behavior if no callback is provided

                NavigationService.goBack;
              }
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Image.asset(
                  Assets.icons.backIcon.path,
                  width: 20.w,
                  height: 20.h,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      centerTitle: true,
      title: Text(
        title,
        style: TextFontStyle.textstyle16c6C757DHelveticalNenu400.copyWith(
          color: AppColors.cFFFFFF,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: backgroundColor ?? AppColors.cFFFFFF,
      elevation: 0,
      // iconTheme: IconThemeData(color: iconThemeColor ?? AppColors.cF5F5F5),
      actions: actions ?? [],
      // <Widget>[
      //   CircleAvatar(
      //     backgroundColor: AppColors.cF5F5F5,
      //     radius: 32.r,
      //     child: Padding(
      //       padding: EdgeInsets.all(12.sp),
      //       child: Image.asset(
      //         Assets.icons.emailIcon.path,
      //         height: 24.h,
      //         width: 24.w,
      //       ),
      //     ),
      //   ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../constants/text_font_style.dart';
// import '../gen/assets.gen.dart';
// import '../gen/colors.gen.dart';
// import '../helpers/navigation_service.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key,
//     this.title,
//     this.titleStyle,
//     this.showBackArrow = true,
//     this.leadingIcon,
//     this.actions,
//     this.leadingOnPressed,
//     this.backgroundColors,
//     this.centerTitle = false,
//     this.isSuffix = false,
//   });

//   final String? title;
//   final TextStyle? titleStyle;
//   final bool showBackArrow;
//   final Widget? leadingIcon;
//   final List<Widget>? actions;
//   final VoidCallback? leadingOnPressed;
//   final Color? backgroundColors;
//   final bool centerTitle;
//   final bool isSuffix;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(8.0.sp),
//       child: AppBar(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         automaticallyImplyLeading: false,
//         centerTitle: centerTitle,

//         leading: showBackArrow
//             ? InkWell(
//                 onTap: () => NavigationService.goBack,
//                 child: Image.asset(
//                   Assets.icons.backIcon.path,
//                   height: 10.h,
//                   width: 10.w,
//                 ),
//               )
//             : null,
//         title: Text(
//           title ?? '',
//           style:
//               titleStyle ??
//               TextFontStyle.textstyle16c4A90E2HelveticalNenu500.copyWith(
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.c222222,
//               ),
//         ),
//         actions: isSuffix ? actions : null,
//         // actions: actions,
//         backgroundColor: backgroundColors ?? Colors.transparent,
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

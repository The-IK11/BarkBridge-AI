import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import '../helpers/navigation_service.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? iconThemeColor;
  final VoidCallback? onBackButtonPressed;
  final Widget? leading;
  final String? subTitle;

  @override
  final Size preferredSize;

  CommonAppbar({
    super.key,
    required this.title,
    this.actions,
    this.titleStyle,
    this.backgroundColor,
    this.iconThemeColor,
    this.onBackButtonPressed,
    this.leading,
    this.subTitle,
  }) : preferredSize = Size.fromHeight(65.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80.w,
      scrolledUnderElevation: 0.0,
      toolbarHeight: 65.h,
      leading: Padding(
        padding: EdgeInsets.only(left: 24.w, top: 8.h, bottom: 8.h),
        child:
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
              child: Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.circular(22.r),
                  border: Border.all(
                    width: 1.18.w,
                    color: AppColors.cE5E7EB.withOpacity(0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cE5E7EB.withOpacity(0.5),
                      blurRadius: 6.r,
                      spreadRadius: -4.r,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: AppColors.cE5E7EB.withOpacity(0.5),
                      blurRadius: 15.r,
                      spreadRadius: -3.r,
                      offset: Offset(0, 15),
                    ),
                  ],
                ),
                child: Image.asset(
                  Assets.icons.appbarBackIcon.path,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ),
      ),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            title,
            style: TextFontStyle.textstyle16c6C757DHelveticalNenu400.copyWith(
              color: AppColors.c000000,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subTitle != null) ...[
            SizedBox(height: 4.h),
            Text(
              subTitle!,
              style: TextFontStyle.textstyle12c4A90E2HelveticalNenu500.copyWith(
                color: AppColors.c6A7282,
              ),
            ),
          ],
        ],
      ),

      backgroundColor: backgroundColor ?? AppColors.cFFFFFF,
      elevation: 0,
      iconTheme: IconThemeData(color: iconThemeColor ?? AppColors.cF5F5F5),
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

//@override
//Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//}

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

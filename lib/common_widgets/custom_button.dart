import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType buttonType;
  final String? imageUrl;
  final Border? border;
  final TextStyle? textStyle;
  final Color? fillColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.imageUrl,
    this.buttonType = ButtonType.primary,
    this.border,
    this.textStyle,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return buttonType == ButtonType.primary
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.c3B53FF,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              minimumSize: Size(double.infinity, 50.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imageUrl != null)
                  Image.asset(imageUrl!, height: 20, width: 20),
                const SizedBox(width: 8),
                Text(
                  text,
                  style:
                      textStyle ??
                      TextFontStyle.textStylec16c4B5563ChakraPetch400.copyWith(
                        color: AppColors.cFFFFFF,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: fillColor ?? AppColors.c141F2A,
              side: border != null
                  ? const BorderSide(
                      color: AppColors.allPrimaryColor,
                      width: 1.5,
                    )
                  : BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              minimumSize: Size(double.infinity, 54.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imageUrl != null)
                  Image.asset(
                    imageUrl!,
                    height: 20.h,
                    width: 20.w,
                    //color: AppColors.cFFFFFF,
                  ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style:
                      textStyle ??
                      TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cFFFFFF,
                      ),
                ),
              ],
            ),
          );
  }
}

enum ButtonType { primary, secondary }

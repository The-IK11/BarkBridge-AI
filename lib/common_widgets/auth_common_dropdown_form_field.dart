import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class AuthCommonDropdownFormField<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String hintText;
  final Widget? prefixIcon;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final bool isEnabled;

  const AuthCommonDropdownFormField({
    super.key,
    required this.value,
    required this.items,
    required this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 48.h),
      width: double.infinity,
      child: DropdownButtonFormField<T>(
       // initialValue: value,
        items: items,
        onChanged: isEnabled ? onChanged : null,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null
              ? Padding(padding: EdgeInsets.all(12.sp), child: prefixIcon)
              : null,
          contentPadding: EdgeInsets.symmetric(
            vertical: ((54.h) - 20.sp) / 2,
            horizontal: 16.w,
          ),
          fillColor: AppColors.cF5F5F5,
          filled: true,
          hintText: hintText,
          hintStyle: TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
            color: AppColors.c838383,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(color: AppColors.cE4E4E4, width: 1.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(
              color: const Color.fromARGB(105, 141, 141, 144),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(
              color: const Color.fromARGB(105, 141, 141, 144),
              width: 1.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
          errorStyle: const TextStyle(
            color: Colors.redAccent,
            fontSize: 12,
            height: 1,
          ),
        ),
        style: TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.c000000,
        ),
        disabledHint: value != null
            ? Text(value.toString())
            : Text(
                hintText,
                style: TextFontStyle.textStylec16c4B5563ChakraPetch400.copyWith(
                  color: AppColors.c838383,
                ),
              ),
      ),
    );
  }
}

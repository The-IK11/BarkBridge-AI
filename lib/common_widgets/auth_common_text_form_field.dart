import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class AuthCommonTextFormField extends StatefulWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyBoardType;
  final double? height;
  final double? width;
  final String? hintText;
  final Color? hintTextColor;
  final Color? textColor;
  final Color? fillcolor;
  final TextEditingController controller;
  final Widget? suffixWidget;
  final bool isSuffixIcon;
  final bool isEnabled;
  final bool isObscure;
  final int maxLines;
  final Color? borderColor;
  final BorderRadius? radius;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final String? initialValue;

  const AuthCommonTextFormField({
    required this.controller,
    this.height,
    this.width,
    required this.hintText,
    this.hintTextColor,
    this.suffixWidget,
    this.isSuffixIcon = false,
    this.isEnabled = true,
    this.isObscure = false,
    this.validator,
    this.radius,
    this.borderColor,
    this.maxLines = 1,
    this.fillcolor,
    this.keyBoardType,
    super.key,
    this.textColor,
    this.onChanged,
    this.autovalidateMode,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
  });

  @override
  State<AuthCommonTextFormField> createState() =>
      _AuthCommonTextFormFieldState();
}

class _AuthCommonTextFormFieldState extends State<AuthCommonTextFormField> {
  bool _obscureText = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 48.h),
      width: widget.width ?? double.infinity,
      child: TextFormField(
        onChanged: (value) {
          final error = widget.validator?.call(value);
          setState(() => hasError = error != null);
        },
        initialValue: widget.initialValue,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: widget.keyBoardType,
        style: TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color:
              widget.textColor ?? (hasError ? Colors.red : AppColors.c000000),
        ),
        readOnly: !widget.isEnabled,
        autovalidateMode:
            widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
        maxLines: widget.maxLines,
        controller: widget.controller,
        obscureText: widget.isObscure ? _obscureText : false,
        validator: widget.validator,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: widget.prefixIcon,
                )
              : null,
          contentPadding: EdgeInsets.symmetric(
            vertical: ((widget.height ?? 54.h) - 20.sp) / 2,
            horizontal: 16.w,
          ),
          errorStyle: const TextStyle(
            color: Colors.redAccent,
            fontSize: 12,
            height: 1,
          ),
          fillColor: widget.fillcolor ?? AppColors.cF5F5F5,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
            color: widget.hintTextColor ?? AppColors.c838383,
          ),
          suffixIcon: widget.isObscure
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color.fromARGB(255, 137, 136, 136),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : widget.isSuffixIcon
              ? (widget.suffixWidget ?? widget.suffixIcon)
              : null,
          border: OutlineInputBorder(
            borderRadius:
                widget.radius ?? BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.cF5F5F5,
              width: 1.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                widget.radius ?? BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.cF5F5F5,
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                widget.radius ?? BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(
              color:
                  widget.borderColor ??
                  const Color.fromARGB(105, 141, 141, 144),
              width: 1.w,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius:
                widget.radius ?? BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(
              color:
                  widget.borderColor ??
                  const Color.fromARGB(105, 141, 141, 144),
              width: 1.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius:
                widget.radius ?? BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius:
                widget.radius ?? BorderRadius.all(Radius.circular(32.r)),
            borderSide: BorderSide(color: Colors.red, width: 1.w),
          ),
        ),
      ),
    );
  }
}

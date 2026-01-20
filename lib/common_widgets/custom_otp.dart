import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOtpInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const CustomOtpInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        showCursor: false, // Cleaner look for OTP
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: "", // Hide the 0/1 char counter
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2.h),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: const Color(0xFF2E3BFF), width: 2.h),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

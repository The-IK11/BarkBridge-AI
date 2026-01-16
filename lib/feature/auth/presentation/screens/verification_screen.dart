import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/custom_otp.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/auth/presentation/screens/reset_password_screen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  void _handleOtpChange(String value, int index) {
    // Move to next field if value is entered
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    // Move to previous field if backspaced
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight + 20.h),

            // Title Section
            Text(
              "Verification",
              style: TextFontStyle.textstyle28cFFFFFFManrope700,
            ),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "We have sent code to your whatsapp number ",
                    style: TextFontStyle.textstyle14c898996Manrope400,
                  ),
                  TextSpan(
                    text: "+1255 252 252",
                    style: TextFontStyle.textstyle14c898996Manrope400.copyWith(
                      color: AppColors.cFFFFFF,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return CustomOtpInput(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  onChanged: (value) => _handleOtpChange(value, index),
                );
              }),
            ),
            SizedBox(height: 24.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Didn't receive code? ",
                    style: TextFontStyle.textstyle14c898996Manrope400,
                  ),
                  TextSpan(
                    text: "Resend",
                    style: TextFontStyle.textstyle14c898996Manrope400.copyWith(
                      color: AppColors.c2707EE,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),
            CustomButton(
              text: "Verify",
              onPressed: () {
                Get.to(() => ResetPasswordScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

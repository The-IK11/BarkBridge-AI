import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/custom_otp.dart';
import 'package:tintpin14_app/common_widgets/custom_toast.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/auth/presentation/screens/reset_password_screen.dart';
import 'package:tintpin14_app/feature/auth/presentation/screens/set_new_password_screen.dart';
import 'package:tintpin14_app/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/helpers/loading_helper.dart';
import 'package:tintpin14_app/navigation_screen.dart';
import 'package:tintpin14_app/networks/api_access.dart';

class VerificationScreen extends StatefulWidget {
  final String verificationType; // "signup" or "reset_password"
  final String email;
  const VerificationScreen({
    super.key,
    required this.verificationType,
    required this.email,
  });

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
                    text: "We have sent code on",
                    style: TextFontStyle.textstyle14c898996Manrope400,
                  ),
                  TextSpan(
                    text: widget.email,
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
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (widget.verificationType == "reset_password") {
                          await postLoginOtpResend
                              .postData(data: {"email": widget.email})
                              .waitingForFutureWithoutBg();
                        } else {
                          await postRegisterOtpResend
                              .postData(data: {"email": widget.email})
                              .waitingForFutureWithoutBg();
                        }
                      },
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
              onPressed: () async {
                if (widget.verificationType == "reset_password") {
                  await postLoginOtpVerify
                      .postData(
                        data: {
                          "otp": _controllers.map((c) => c.text).join(),
                          "email": widget.email,
                        },
                      )
                      .waitingForFutureWithoutBg()
                      .then((v) {
                        if (v) {
                          Get.offAll(SetNewPasswordScreen());
                        }
                      });
                } else {
                  await postRegisterOtpVerify
                      .postData(
                        data: {
                          "otp": _controllers.map((c) => c.text).join(),
                          "email": widget.email,
                        },
                      )
                      .waitingForFutureWithoutBg()
                      .then((v) {
                        if (v) {
                          Get.to(NavigationScreen());
                        }
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

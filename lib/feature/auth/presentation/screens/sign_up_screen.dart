import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:tintpin14_app/common_widgets/auth_common_text_form_field.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:tintpin14_app/feature/auth/presentation/screens/verification_screen.dart';
import 'package:tintpin14_app/gen/assets.gen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kToolbarHeight + 20.h),

              // Title Section
              Text(
                "Sign up with Email",
                style: TextFontStyle.textstyle28cFFFFFFManrope700,
              ),
              SizedBox(height: 8.h),
              Text(
                "Input your registered account!",
                style: TextFontStyle.textstyle16c898996Manrope400,
              ),
              SizedBox(height: 40.h),

              // Email Field
              _buildLabel("Email"),
              AuthCommonTextFormField(
                controller: TextEditingController(),
                hintText: "Type your email",
                fillcolor: AppColors.cFFFFFF.withAlpha(8),
                borderColor: AppColors.cE6E6E8,
                radius: BorderRadius.circular(16.r),
              ),
              SizedBox(height: 20.h),

              // Password Field
              _buildLabel("Phone number"),
              AuthCommonTextFormField(
                controller: TextEditingController(),
                hintText: "Type your phone number",
                fillcolor: AppColors.cFFFFFF.withAlpha(8),
                borderColor: AppColors.cE6E6E8,
                radius: BorderRadius.circular(16.r),
                //isObscure: true,
              ),

              SizedBox(height: 20.h),

              // Password Field
              _buildLabel("Password"),
              AuthCommonTextFormField(
                controller: TextEditingController(),
                hintText: "Type your password",
                fillcolor: AppColors.cFFFFFF.withAlpha(8),
                borderColor: AppColors.cE6E6E8,
                radius: BorderRadius.circular(16.r),
                isObscure: true,
              ),

              SizedBox(height: 24.h),
              Row(
                // Align items to the top or center so text lines up with checkbox
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: checkBoxValue,
                    onChanged: (value) {
                      setState(() {
                        checkBoxValue = !checkBoxValue;
                      });
                    },
                    // Note: MaterialStateBorderSide is deprecated in newer Flutter versions;
                    // check below if you need the update.
                    side: MaterialStateBorderSide.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return const BorderSide(color: Colors.blue, width: 2);
                      }
                      return const BorderSide(color: Colors.grey, width: 2);
                    }),
                  ),
                  SizedBox(width: 10.w),

                  // --- FIX START ---
                  Expanded(
                    // Use Expanded instead of SizedBox.expand
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "By Creating your account you have to agree with our ",
                            style: TextFontStyle.textstyle14c898996Manrope400,
                          ),
                          TextSpan(
                            text: "Terms and Condition",
                            style: TextFontStyle.textstyle14c898996Manrope400
                                .copyWith(color: AppColors.c2707EE),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // --- FIX END ---
                ],
              ),
              SizedBox(height: 24.h),
              CustomButton(
                buttonType: ButtonType.primary,
                text: "Sign Up Now",
                onPressed: () {
                  Get.to(() => VerificationScreen());
                },
              ),

              SizedBox(height: 30.h),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.cE6E6E8)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      "Or",
                      style: TextFontStyle.textstyle14c898996Manrope400,
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.cE6E6E8)),
                ],
              ),
              SizedBox(height: 30.h),

              // Social Buttons
              CustomButton(
                buttonType: ButtonType.secondary,
                text: "Sign in with Apple",
                onPressed: () {},
                imageUrl: Assets.icons.appleIcon.path,
              ),
              SizedBox(height: 16.h),
              CustomButton(
                buttonType: ButtonType.secondary,
                text: "Sign in with Apple",
                onPressed: () {},
                imageUrl: Assets.icons.googleIcon.path,
              ), // Or use an asset icon

              SizedBox(height: 20.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextFontStyle.textstyle16c898996Manrope400,
                    children: [
                      TextSpan(
                        text: "Sign up",
                        style: TextFontStyle.textstyle16c898996Manrope400
                            .copyWith(color: AppColors.cFFFFFF),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => SignInScreen());
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text, style: TextFontStyle.textstyle14c626262Manrope500),
    );
  }
}

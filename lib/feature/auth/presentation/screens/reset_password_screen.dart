import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:tintpin14_app/common_widgets/auth_common_text_form_field.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/constants/validator.dart';
import 'package:tintpin14_app/feature/auth/presentation/screens/verification_screen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/helpers/loading_helper.dart';
import 'package:tintpin14_app/networks/api_access.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 20.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight + 20.h),

            // Title Section
            Text(
              "Reset Password",
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
              validator: emailValidator,
              controller: emailController,
              hintText: "Enter your email",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              radius: BorderRadius.circular(16.r),
            ),
            SizedBox(height: 30.h),
            CustomButton(
              text: "Continue",
              onPressed: () async {
                await postLoginEmailVerify
                    .postData(data: {"email": emailController.text})
                    .waitingForFutureWithoutBg()
                    .then((v) {
                      if (v) {
                        Get.to(
                          () => VerificationScreen(
                            verificationType: "reset_password",
                            email: emailController.text,
                          ),
                        );
                      }
                    });
              },
            ),
          ],
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

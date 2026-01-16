import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:tintpin14_app/common_widgets/auth_common_text_form_field.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/auth/presentation/screens/set_new_password_screen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});
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
              controller: TextEditingController(),
              hintText: "Type your email",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              borderColor: AppColors.cE6E6E8,
              radius: BorderRadius.circular(16.r),
            ),
            SizedBox(height: 30.h),
            CustomButton(
              text: "Continue",
              onPressed: () {
                Get.to(() => SetNewPasswordScreen());
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

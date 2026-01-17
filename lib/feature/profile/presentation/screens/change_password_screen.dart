import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/common_widgets/auth_common_text_form_field.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        title: "Change password",
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight + 20.h),
            // Email Field
            _buildLabel("Old Password"),
            AuthCommonTextFormField(
              controller: TextEditingController(),
              hintText: "Type your old password",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              borderColor: AppColors.cE6E6E8,
              radius: BorderRadius.circular(16.r),
              isObscure: true,
            ),
            SizedBox(height: 25.h),
            _buildLabel("New Password"),
            AuthCommonTextFormField(
              controller: TextEditingController(),
              hintText: "Type your password",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              borderColor: AppColors.cE6E6E8,
              radius: BorderRadius.circular(16.r),
              isObscure: true,
            ),
            SizedBox(height: 25.h),
            _buildLabel("Confirm Password"),
            AuthCommonTextFormField(
              controller: TextEditingController(),
              hintText: "Type confirm password",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              borderColor: AppColors.cE6E6E8,
              radius: BorderRadius.circular(16.r),
              isObscure: true,
            ),
            Spacer(),
            CustomButton(text: "Update", onPressed: () {}),
          ],
        ),
      ),
    );
  }
  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text, style: TextFontStyle.textstyle14c626262Manrope500),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tintpin14_app/common_widgets/auth_common_text_form_field.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/profile/presentation/screens/change_password_screen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        title: "Edit profile",
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight + 20.h),
            // Email Field
            _buildLabel("Your Name"),
            AuthCommonTextFormField(
              controller: TextEditingController(),
              hintText: "Type your name",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              borderColor: AppColors.cE6E6E8,
              radius: BorderRadius.circular(16.r),
            ),
            SizedBox(height: 25.h),
            _buildLabel("Your Email"),
            AuthCommonTextFormField(
              controller: TextEditingController(),
              hintText: "Type your email",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              borderColor: AppColors.cE6E6E8,
              radius: BorderRadius.circular(16.r),
            ),
            SizedBox(height: 25.h),
            _buildLabel("Your Phone Number"),
            AuthCommonTextFormField(
              controller: TextEditingController(),
              hintText: "Type your number",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              borderColor: AppColors.cE6E6E8,
              radius: BorderRadius.circular(16.r),
            ),
            Spacer(),
            CustomButton(
              text: "Update",
              onPressed: () {
                Get.to(() => ChangePasswordScreen());
              },
            ),
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

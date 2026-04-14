import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:tintpin14_app/common_widgets/auth_common_text_form_field.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/navigation_screen.dart';
import 'package:tintpin14_app/feature/auth/presentation/screens/sign_in_screen.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
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
            // Password Field
            _buildLabel("New Password"),
            AuthCommonTextFormField(
              controller: newPasswordController,
              hintText: "Type New password",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              radius: BorderRadius.circular(16.r),
              isObscure: true,
            ),
            SizedBox(height: 20.h),
            _buildLabel("Confirm Password"),
            AuthCommonTextFormField(
              controller: confirmPasswordController,
              hintText: "Retype New password",
              fillcolor: AppColors.cFFFFFF.withAlpha(8),
              radius: BorderRadius.circular(16.r),
              isObscure: true,
            ),
            SizedBox(height: 40.h),
            CustomButton(
              text: "Continue",
              onPressed: () {
                showSuccessDialog(context);
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

  Future<void> showSuccessDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.c1D2031,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),

          child: Padding(
            padding: EdgeInsets.only(
              top: 25.h,
              bottom: 15.h,
              left: 15.w,
              right: 15.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Reset Password Success!",
                  style: TextFontStyle.textstyle20cFFFFFFManrope700,
                ),
                SizedBox(height: 14.h),
                Text(
                  "Please, sign in to get started.",
                  style: TextFontStyle.textstyle11cB8BBCCManrope400,
                ),
                SizedBox(height: 54.h),
                CustomButton(text: "Done", onPressed: () {}),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tintpin14_app/common_widgets/auth_common_text_form_field.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/custom_toast.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/constants/validator.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/helpers/loading_helper.dart';
import 'package:tintpin14_app/helpers/ui_helpers.dart';
import 'package:tintpin14_app/networks/api_access.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Validate inputs

    // Prepare data for API
    final Map<String, dynamic> updateData = {
      'old_password': oldPassword,
      'new_password': newPassword,
      'new_password_confirmation': confirmPassword,
    };

    // Call the API
    try {
      final success = await postUpdatePassword
          .postData(data: updateData)
          .waitingForFutureWithoutBg();

      if (success) {
        customToastMessage("Success", "Password updated successfully");
        // Clear fields on success
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        if (mounted) {
          Get.back();
        }
      }
    } catch (e) {
      customToastMessage("Error", "Failed to update password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(title: "Change password"),
      child: Padding(
        padding: EdgeInsets.all(UIHelper.kDefaultPadding()),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kToolbarHeight + 20.h),
              // Email Field
              _buildLabel("Old Password"),
              AuthCommonTextFormField(
                validator: passwordValidator,
                controller: oldPasswordController,
                hintText: "Type your old password",
                fillcolor: AppColors.cFFFFFF.withAlpha(8),

                radius: BorderRadius.circular(16.r),
                isObscure: true,
              ),
              SizedBox(height: 25.h),
              _buildLabel("New Password"),
              AuthCommonTextFormField(
                validator: passwordValidator,

                controller: newPasswordController,
                hintText: "Type your password",
                fillcolor: AppColors.cFFFFFF.withAlpha(8),

                radius: BorderRadius.circular(16.r),
                isObscure: true,
              ),
              SizedBox(height: 25.h),
              _buildLabel("Confirm Password"),
              AuthCommonTextFormField(
                validator: (value) =>
                    confirmPasswordValidator(value, newPasswordController.text),
                controller: confirmPasswordController,
                hintText: "Type confirm password",
                fillcolor: AppColors.cFFFFFF.withAlpha(8),

                radius: BorderRadius.circular(16.r),
                isObscure: true,
              ),
              Spacer(),
              CustomButton(
                text: "Update",
                onPressed: () {
                  if (key.currentState!.validate()) {
                    _updatePassword();
                  }
                },
              ),
            ],
          ),
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

import 'dart:io';
import 'dart:math';

import 'package:barkbridgeai/common_widgets/loading_indicators.dart';
import 'package:barkbridgeai/constants/app_constants.dart';
import 'package:barkbridgeai/helpers/di.dart';
import 'package:barkbridgeai/helpers/navigation_service.dart';
import 'package:barkbridgeai/helpers/social_auth.dart';
import 'package:barkbridgeai/helpers/url_lunch.dart';
import 'package:barkbridgeai/navigation_screen.dart';
import 'package:barkbridgeai/networks/endpoints.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:barkbridgeai/common_widgets/auth_common_text_form_field.dart';
import 'package:barkbridgeai/common_widgets/custom_button.dart';
import 'package:barkbridgeai/common_widgets/custom_toast.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/constants/validator.dart';
import 'package:barkbridgeai/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:barkbridgeai/feature/auth/presentation/screens/verification_screen.dart';
import 'package:barkbridgeai/gen/assets.gen.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/helpers/loading_helper.dart';
import 'package:barkbridgeai/networks/api_access.dart';
import 'package:barkbridgeai/services/revenuecat_service/revenue_cat_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController;
    emailController;
    phoneController;
    passwordController;
    confirmPasswordController;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Name"),
                    AuthCommonTextFormField(
                      validator: emptyValidator,
                      controller: nameController,
                      hintText: "Enter your name",
                      fillcolor: AppColors.cFFFFFF.withAlpha(8),
                      radius: BorderRadius.circular(16.r),
                    ),
                    SizedBox(height: 20.h),
                    // Email Field
                    _buildLabel("Email"),
                    AuthCommonTextFormField(
                      validator: emailValidator,
                      controller: emailController,
                      hintText: "Enter your email",
                      fillcolor: AppColors.cFFFFFF.withAlpha(8),
                      radius: BorderRadius.circular(16.r),
                    ),
                    SizedBox(height: 20.h),
                    // Phone Number Field
                    _buildLabel("Phone Number(Optional)"),
                    AuthCommonTextFormField(
                      keyBoardType: TextInputType.phone,
                      //   validator: validatePhoneNumber,
                      controller: phoneController,
                      hintText: "Enter your phone number",
                      fillcolor: AppColors.cFFFFFF.withAlpha(8),
                      radius: BorderRadius.circular(16.r),
                      //isObscure: true,
                    ),
                    SizedBox(height: 20.h),
                    // Phone Number Field
                    _buildLabel("Password"),
                    AuthCommonTextFormField(
                      validator: passwordValidator,
                      controller: passwordController,
                      hintText: "Type your password",
                      fillcolor: AppColors.cFFFFFF.withAlpha(8),
                      radius: BorderRadius.circular(16.r),
                      //isObscure: true,
                    ),

                    SizedBox(height: 20.h),

                    // Password Field
                    _buildLabel("Password"),
                    AuthCommonTextFormField(
                      validator: (value) => confirmPasswordValidator(
                        value,
                        passwordController.text,
                      ),
                      controller: confirmPasswordController,
                      hintText: "Re-type your password",
                      fillcolor: AppColors.cFFFFFF.withAlpha(8),
                      radius: BorderRadius.circular(16.r),
                      isObscure: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Checkbox(
                      value: checkBoxValue,
                      onChanged: (value) {
                        setState(() {
                          checkBoxValue = !checkBoxValue;
                        });
                      },

                      side: WidgetStateBorderSide.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return const BorderSide(color: Colors.blue, width: 2);
                        }
                        return const BorderSide(color: Colors.grey, width: 2);
                      }),
                    ),
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
                            text: "Privacy Policy",
                            style: TextFontStyle.textstyle14c898996Manrope400
                                .copyWith(color: AppColors.c2707EE),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                urlLunch(
                                  "https://barkbridgeai.tech/page/privacy-policy",
                                );
                                // Handle Privacy Policy tap
                              },
                          ),
                          TextSpan(
                            text: "&",
                            style: TextFontStyle.textstyle14c898996Manrope400
                                .copyWith(),
                          ),
                          TextSpan(
                            text: " Terms and Condition",
                            style: TextFontStyle.textstyle14c898996Manrope400
                                .copyWith(color: AppColors.c2707EE),

                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                urlLunch(
                                  "https://barkbridgeai.tech/page/terms-conditions",
                                );
                                // Handle & tap if needed
                              },
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
                onPressed: () async {
                  // Validate form before submission
                  if (_formKey.currentState!.validate()) {
                    if (checkBoxValue == false) {
                      customToastMessage(
                        "Terms and Conditions",
                        "You must agree to the terms and conditions to proceed.",
                      );
                      return; // Stop further execution if terms are not agreed
                    }
                    await postRegister
                        .postData(
                          data: {
                            "name": nameController.text,
                            "email": emailController.text,
                            "phone": phoneController.text.isEmpty
                                ? null
                                : phoneController.text,
                            "password": passwordController.text,
                            "password_confirmation":
                                confirmPasswordController.text,
                            "agree_to_terms": checkBoxValue ? 1 : 0,
                          },
                        )
                        .waitingForFutureWithoutBg()
                        .then((v) {
                          if (v) {
                            Get.to(
                              () => VerificationScreen(
                                verificationType: "signup",
                                email: emailController.text,
                              ),
                            );
                          }
                        });
                  }
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
                onPressed: () async {
                  // Manually track and control the loading dialog so we can
                  // dismiss it ourselves before Get.offAll() — preventing
                  // Navigator.pop() from closing NavigationScreen.
                  bool isDialogOpen = false;

                  void showLoading() {
                    isDialogOpen = true;
                    showDialog(
                      context: NavigationService.context,
                      barrierDismissible: false,
                      builder: (ctx) => loadingIndicatorCircle(context: ctx),
                    ).then((_) => isDialogOpen = false);
                  }

                  void dismissLoading() {
                    if (isDialogOpen) {
                      isDialogOpen = false;
                      NavigationService.goBack;
                    }
                  }

                  showLoading();
                  try {
                    await SocialAuthHelper.signInWithApple(
                      onSuccess: (user, token, userName) async {
                        // Dismiss Apple-auth loading before API loading starts
                        dismissLoading();
                        await Future(() async {
                          final isSuccess = await postAppleLogin.postData(
                            data: {'provider': 'apple', 'token': token},
                          );

                          if (isSuccess) {
                            await RevenueCatService().loginUser(
                              appData.read(kKeyUserID).toString(),
                            );
                            return true;
                          }
                          return false;
                        })
                            .waitingForFutureWithoutBg()
                            .then((v) {
                              if (v == true) {
                                Get.offAll(() => NavigationScreen());
                              }
                            });
                      },
                    );
                  } finally {
                    // Dismiss if user cancelled Apple sheet or an error occurred
                    dismissLoading();
                  }
                },
                iconColor: AppColors.cFFFFFF,
                imageUrl: Assets.icons.appleIcon.path,
              ),
              SizedBox(height: 16.h),
              CustomButton(
                buttonType: ButtonType.secondary,
                text: "Sign in with Google",
                onPressed: () async {
                  await SocialAuthHelper.signOut(onSuccess: () async {});
                  await SocialAuthHelper.signInWithGoogle(
                    onSuccess: (user, token) async {
                      final payload = {
                        'token': token,
                        'provider': 'google',
                        'username': user.displayName ?? 'User',
                        'email': user.email ?? '',
                        'avatar': user.photoURL ?? '',
                      };

                      // Hit the API like this
                      await Future(() async {
                        final isSuccess = await postSocialLogin.postData(
                          data: payload,
                        );

                        if (isSuccess) {
                          await RevenueCatService().loginUser(
                            appData.read(kKeyUserID).toString(),
                          );
                          return true;
                        }
                        return false;
                      })
                          .waitingForFutureWithoutBg()
                          .then((v) {
                            if (v == true) {
                              Get.to(() => NavigationScreen());
                              appData.write(kGoogle, true);
                            }
                          });
                    },
                  );
                },
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
                        text: "Sign in",
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

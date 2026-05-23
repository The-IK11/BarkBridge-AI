import 'dart:developer';

import 'package:barkbridgeai/constants/app_constants.dart';
import 'package:barkbridgeai/helpers/di.dart';
import 'package:barkbridgeai/helpers/social_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:barkbridgeai/common_widgets/auth_common_text_form_field.dart';
import 'package:barkbridgeai/common_widgets/custom_button.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/constants/validator.dart';
import 'package:barkbridgeai/feature/auth/presentation/screens/reset_password_screen.dart';
import 'package:barkbridgeai/feature/auth/presentation/screens/sign_up_screen.dart';
import 'package:barkbridgeai/gen/assets.gen.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:barkbridgeai/helpers/loading_helper.dart';
import 'package:barkbridgeai/navigation_screen.dart';
import 'package:barkbridgeai/networks/api_access.dart';

// Ensure you import the GlowBackground widget created above

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Wrap the entire screen in our custom background
    return GlowBackground(
      // appBar: AppBar(
      //   backgroundColor:
      //       Colors.transparent, // Required to see the glow behind it
      //   elevation: 0, // Removes the shadow line
      //   centerTitle: true,
      //   title: const Text(
      //     "Sign In",
      //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      // ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kToolbarHeight + 20.h),

                // Title Section
                Text(
                  "Sign in with Email",
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
                  hintText: "Type your email",
                  fillcolor: AppColors.cFFFFFF.withAlpha(8),

                  radius: BorderRadius.circular(16.r),
                ),

                SizedBox(height: 20.h),

                // Password Field
                _buildLabel("Password"),
                AuthCommonTextFormField(
                  validator: passwordValidator,
                  controller: passwordController,
                  hintText: "Type your password",
                  fillcolor: AppColors.cFFFFFF.withAlpha(8),

                  radius: BorderRadius.circular(16.r),
                  isObscure: true,
                ),

                SizedBox(height: 24.h),

                // Forgot Password
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => ResetPasswordScreen());
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextFontStyle.textstyle16c2F29FFManrope400,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                CustomButton(
                  buttonType: ButtonType.primary,
                  text: "Sign In",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await postLogin
                          .postData(
                            data: {
                              "email": emailController.text,
                              "password": passwordController.text,
                            },
                          )
                          .waitingForFutureWithoutBg()
                          .then((v) {
                            if (v) {
                              Get.offAll(() => NavigationScreen());
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
                  onPressed: () {},
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
                        log("Google Sign-In Payload: $payload");
                        // Hit the API like this
                        await postSocialLogin
                            .postData(data: payload)
                            .waitingForFutureWithoutBg()
                            .then((v) {
                              if (v) {
                                Get.to(() => NavigationScreen());
                                appData.write(kGoogle, true);
                              }
                            });
                      },
                    );
                  },
                  imageUrl: Assets.icons.googleIcon.path,
                ), // Or use an asset icon

                SizedBox(height: 40.h),

                // Sign Up Text
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
                              Get.offAll(() => SignUpScreen());
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

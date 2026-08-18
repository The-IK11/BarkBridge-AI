import 'package:barkbridgeai/constants/app_constants.dart';
import 'package:barkbridgeai/helpers/di.dart';
import 'package:barkbridgeai/helpers/social_auth.dart';
import 'package:barkbridgeai/services/cache_manager/history_cache_manager.dart';
import 'package:barkbridgeai/services/revenuecat_service/revenue_cat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:barkbridgeai/common_widgets/custom_button.dart';
import 'package:barkbridgeai/common_widgets/custom_network_image.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/common_widgets/not_found_widget.dart';
import 'package:barkbridgeai/common_widgets/waiting_widget.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:barkbridgeai/feature/plansAndPricing/screens/plan_and_pricing_screen.dart';
import 'package:barkbridgeai/feature/profile/presentation/screens/change_password_screen.dart';
import 'package:barkbridgeai/feature/profile/presentation/screens/edit_profile_screen.dart';
import 'package:barkbridgeai/feature/profile/presentation/screens/setting_screen.dart';
import 'package:barkbridgeai/gen/assets.gen.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/helpers/loading_helper.dart';
import 'package:barkbridgeai/networks/api_access.dart';
import 'package:barkbridgeai/feature/profile/model/profile_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool deleteAccountSelected = false;
  late TextEditingController deleteReasonController;

  // ── Subscription state ──────────────────────────────────────────────────
  bool _isSubscriber = false;
  bool _isCheckingSubscription = true;

  @override
  void initState() {
    super.initState();
    deleteReasonController = TextEditingController();
    // Fetch user data when screen loads
    getUserData.fetch();
    // Check RevenueCat subscription status
    _checkSubscription();
  }

  Future<void> _checkSubscription() async {
    try {
      final hasSubscription = await RevenueCatService().hasActiveSubscription();
      if (mounted) {
        setState(() {
          _isSubscriber = hasSubscription;
          _isCheckingSubscription = false;
        });
      }
    } catch (e) {
      debugPrint('⚠️ ProfileScreen: Could not check subscription: $e');
      if (mounted) setState(() => _isCheckingSubscription = false);
    }
  }

  @override
  void dispose() {
    deleteReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(97, 3, 27, 69),
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextFontStyle.textstyle11cB8BBCCManrope400.copyWith(
            color: AppColors.cD9DAE4,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 4,
          ),
        ),
      ),
      child: StreamBuilder<GetProfileDataModel>(
        stream: getUserData.getStream,
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingWidget();
          }

          // Handle error state
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const NotFoundWidget(),
                  SizedBox(height: 20.h),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textstyle14c626262Manrope500.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }

          // Handle success state
          if (snapshot.hasData && snapshot.data != null) {
            final userData = snapshot.data!.data;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: kToolbarHeight + 20.h),
                    avatar(imageUrl: userData?.avatar ?? ''),
                    SizedBox(height: 15.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      decoration: BoxDecoration(
                        color: AppColors.c778DFF.withAlpha(30),
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          width: 1.w,
                          color: const Color.fromARGB(
                            255,
                            148,
                            142,
                            142,
                          ).withAlpha(50),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            userData?.name ?? 'Unknown',
                            style: TextFontStyle.textstyle20cFFFFFFManrope600
                                .copyWith(fontSize: 24.sp),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            userData?.email ?? 'No email',
                            style: TextFontStyle.textstyle15c5465A6Manrope400,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.h),
                    dividerLine(),
                    InkWell(
                      onTap: () {
                        Get.to(() => EditProfileScreen(userData: userData));
                      },
                      child: ListTile(
                        leading: Text(
                          "Edit Profile",
                          style: TextFontStyle.textstyle16cFFFFFFManrope500,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                          color: AppColors.c5465A6,
                        ),
                      ),
                    ),
                    dividerLine(),
                    InkWell(
                      onTap: () {
                        Get.to(() => ChangePasswordScreen());
                      },
                      child: ListTile(
                        leading: Text(
                          "Change Password",
                          style: TextFontStyle.textstyle16cFFFFFFManrope500,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                          color: AppColors.c5465A6,
                        ),
                      ),
                    ),
                    dividerLine(),
                    InkWell(
                      onTap: () {
                        Get.to(() => SettingScreen());
                      },
                      child: ListTile(
                        leading: Text(
                          "Settings",
                          style: TextFontStyle.textstyle16cFFFFFFManrope500,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                          color: AppColors.c5465A6,
                        ),
                      ),
                    ),
                    dividerLine(),
                    InkWell(
                      onTap: () async {
                        await _showLogoutDialog();
                      },
                      child: ListTile(
                        leading: Text(
                          "Logout",
                          style: TextFontStyle.textstyle16cFFFFFFManrope500,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                          color: AppColors.c5465A6,
                        ),
                      ),
                    ),
                    dividerLine(),
                    InkWell(
                      onTap: () async {
                        _showDeleteAccountDialog();
                      },
                      child: ListTile(
                        leading: Text(
                          "Delete Account",
                          style: TextFontStyle.textstyle16cFFFFFFManrope500
                              .copyWith(color: Colors.red),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    // ── Plan / Premium banner ────────────────────────────
                    _buildPlanBanner(),
                    SizedBox(height: 25.h),
                  ],
                ),
              ),
            );
          }

          // Default fallback
          return const NotFoundWidget();
        },
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.c1D2031,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Delete Account",
                        style: TextFontStyle.textstyle20cFFFFFFManrope600,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Are you sure you want to delete your account? This action cannot be undone.",
                        style: TextFontStyle.textstyle14c626262Manrope500,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Please tell us the reason for deletion (optional)",
                        style: TextFontStyle.textstyle14c626262Manrope500,
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: deleteReasonController,
                        maxLines: 4,
                        minLines: 3,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13.sp,
                            height: 1.4,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1C1F2A),
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.blueAccent.withOpacity(0.7),
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.blueAccent.withOpacity(0.6),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              buttonType: ButtonType.secondary,
                              fillColor: AppColors.cA2A3A9,
                              text: "Cancel",
                              onPressed: () {
                                deleteReasonController.clear();
                                Get.back();
                              },
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: CustomButton(
                              buttonType: ButtonType.secondary,
                              fillColor: AppColors.cE93820,
                              text: "Delete",
                              onPressed: () async {
                                Get.back();
                                try {
                                  final reason = deleteReasonController.text
                                      .trim();
                                  final Map<String, dynamic> deleteData = {
                                    'reason': reason,
                                  };
                                  if (appData.read(kGoogle) ?? false) {
                                    await SocialAuthHelper.signOut(
                                      onSuccess: () async {
                                        appData.write(kGoogle, false);
                                      },
                                    );
                                  }
                                  await postDeleteAccount
                                      .deleteData(data: deleteData)
                                      .waitingForFutureWithoutBg()
                                      .then((v) {
                                        deleteReasonController.clear();
                                        if (v) {
                                          HistoryCacheManager.instance.clearCache();
                                          Get.offAll(() => SignInScreen());
                                        }
                                      });
                                } catch (e) {
                                  print('Delete account error: $e');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showLogoutDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.c1D2031,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Are you sure you want to logout?",
                  style: TextFontStyle.textstyle20cFFFFFFManrope600,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonType: ButtonType.secondary,
                        fillColor: AppColors.cA2A3A9,
                        text: "No",
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: CustomButton(
                        buttonType: ButtonType.secondary,
                        fillColor: AppColors.cE93820,
                        text: "Yes",
                        onPressed: () async {
                          Get.back();
                          try {
                            if (appData.read(kGoogle) ?? false) {
                              await SocialAuthHelper.signOut(
                                onSuccess: () async {
                                  appData.write(kGoogle, false);
                                },
                              );
                            }
                            await postLogout
                                .postData()
                                .waitingForFutureWithoutBg()
                                .then((v) {
                                  if (v) {
                                    RevenueCatService().logoutUser();
                                    HistoryCacheManager.instance.clearCache();
                                    Get.offAll(() => SignInScreen());
                                  }
                                });
                          } catch (e) {
                            print('Logout error: $e');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Stack avatar({required String? imageUrl}) {
    return Stack(
      children: [
        Container(
          height: 170.h,
          width: 230.w,
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.avatarEillipes.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 28.w,
          child: Container(
            height: 170.h,
            width: 180.w,
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(Assets.images.avatarBorder.path),
                fit: BoxFit.cover,
              ),
            ),

            child: Container(
              margin: EdgeInsets.all(20.sp),
              width: 123.w,
              height: 123.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4.6.w,
                  color: Color.fromARGB(255, 37, 48, 89),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 75.5.w,
          top: 42.5.h,
          child: CustomNetworkImage(
            isCircular: true,
            width: 85.w,
            height: 85.h,
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),

        // Positioned(
        //   left: 130.w,
        //   top: 100.h,
        //   child: InkWell(
        //     onTap: () {},
        //     child: Container(
        //       width: 30.w,
        //       height: 30.h,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: const Color.fromARGB(255, 9, 58, 232),
        //       ),
        //       child: Icon(
        //         Icons.camera_alt_outlined,
        //         size: 18.sp,
        //         color: AppColors.cFFFFFF,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  PLAN BANNER — switches between premium card and upgrade image
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildPlanBanner() {
    // While checking, show a subtle shimmer placeholder
    if (_isCheckingSubscription) {
      return Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.c778DFF.withValues(alpha: 0.08),
          border: Border.all(color: AppColors.c778DFF.withValues(alpha: 0.15)),
        ),
        child: Center(
          child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.c778DFF),
            ),
          ),
        ),
      );
    }

    if (_isSubscriber) {
      // ── PRO MEMBER card ──────────────────────────────────────────────
      return GestureDetector(
        onTap: () => Get.to(() => PlanAndPricingScreen()),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A1060), AppColors.c3B53FF, Color(0xFF2606ED)],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.c3B53FF.withValues(alpha: 0.4),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // Crown icon
              Image.asset(
                Assets.icons.whiteCrownIcon.path,
                width: 38.w,
                height: 38.h,
              ),
              SizedBox(width: 14.w),

              // Text info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.cDAA356.withValues(alpha: 0.2),
                        border: Border.all(
                          color: AppColors.cDAA356.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        '★  PRO MEMBER',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.cDAA356,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Active Subscription',
                      style: TextFontStyle.textstyle16cFFFFFFManrope500
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Tap to manage your plan or buy extra scans',
                      style: TextFontStyle.textstyle15c5465A6Manrope400
                          .copyWith(color: AppColors.cC2C2C2, fontSize: 11.sp),
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withValues(alpha: 0.6),
                size: 16.sp,
              ),
            ],
          ),
        ),
      );
    }

    // ── FREE user: show upgrade banner image ─────────────────────────────
    return GestureDetector(
      onTap: () async {
        await Get.to(() => PlanAndPricingScreen());
        _checkSubscription();
      },
      child: Image.asset(
        Assets.images.upgradePlanImage.path,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget dividerLine() {
    return Container(
      height: 1.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.c0A1C3C.withAlpha(0),
            AppColors.c0A1C3C,
            AppColors.c0A1C3C,
            AppColors.c0A1C3C.withAlpha(0),
          ],
        ),
      ),
    );
  }
}

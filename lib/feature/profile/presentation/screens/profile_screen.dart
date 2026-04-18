import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/custom_network_image.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/common_widgets/not_found_widget.dart';
import 'package:tintpin14_app/common_widgets/waiting_widget.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/plansAndPricing/screens/plan_and_pricing_screen.dart';
import 'package:tintpin14_app/feature/profile/presentation/screens/edit_profile_screen.dart';
import 'package:tintpin14_app/feature/profile/presentation/screens/setting_screen.dart';
import 'package:tintpin14_app/feature/profile/presentation/widgets/upgradePlanBanner.dart';
import 'package:tintpin14_app/gen/assets.gen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/networks/api_access.dart';
import 'package:tintpin14_app/feature/profile/model/profile_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool deleteAccountSelected = false;
  late TextEditingController deleteReasonController;

  @override
  void initState() {
    super.initState();
    deleteReasonController = TextEditingController();
    // Fetch user data when screen loads
    getUserData.fetch();
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
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: TextFontStyle.textstyle20cFFFFFFManrope600,
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
                    InkWell(
                      onTap: () {
                        Get.to(() => PlanAndPricingScreen());
                      },
                      child: UpgradePlanBanner(),
                    ),
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
                                // Prepare data with reason if provided
                                final Map<String, dynamic> deleteData = {};
                                if (deleteReasonController.text.isNotEmpty) {
                                  deleteData['reason'] =
                                      deleteReasonController.text;
                                }
                                await postDeleteAccount.deleteData(
                                  data: deleteData,
                                );
                                deleteReasonController.clear();
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
                          await postLogout.postData();
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:barkbridgeai/common_widgets/custom_app_bar.dart';
import 'package:barkbridgeai/common_widgets/custom_button.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  bool deleteAccountSelected = false;
  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(title: "Account Details"),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight + 20.h),
            InkWell(
              onTap: () {
                customShowDialog(
                  context,
                  "Are you sure you want cancel your subscription ?",
                );
              },
              child: accountDetailsCard(
                "Cancel Subscription",
                Icons.close,
                Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                customShowDialog(context, "Are you sure you want to Log out?");
              },
              child: accountDetailsCard("Log out", Icons.logout, Colors.red),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                setState(() {
                  deleteAccountSelected = !deleteAccountSelected;
                });
              },
              child: accountDetailsCard(
                "Delete Your Account",
                Icons.delete_sharp,
                Colors.red,
              ),
            ),
            if (deleteAccountSelected == true) ...[
              SizedBox(height: 20.h),
              Text(
                "Type a reason for delete your Account",
                style: TextFontStyle.textstyle14c626262Manrope500,
              ),
              SizedBox(height: 10.h),
              TextFormField(
                maxLines: 6,
                minLines: 4,
                style: TextStyle(color: Colors.white, fontSize: 14),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  // hintText:
                  //     "Expectation-Based Reason\n"
                  //     "I enjoyed trying the app, but it didn’t fully match my "
                  //     "expectations or needs over time. As a result, I’ve decided "
                  //     "to remove my account and explore other options.",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                    height: 1.4,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1C1F2A), // dark background
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
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        deleteAccountSelected = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: AppColors.cA2A3A9,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextFontStyle.textStyle18c171717OpenSans600
                            .copyWith(color: AppColors.cFFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: AppColors.cE93820,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      "Delete",
                      style: TextFontStyle.textStyle18c171717OpenSans600
                          .copyWith(color: AppColors.cFFFFFF),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget accountDetailsCard(
    String title,
    IconData suffixIcon,
    Color iconColor,
  ) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      width: double.infinity,
      height: 58.h,
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF.withAlpha(8),
        border: Border.all(width: 2.w, color: AppColors.cE6E6E8.withAlpha(8)),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextFontStyle.textstyle16c2F29FFManrope400.copyWith(
              color: AppColors.cB8B8C3,
            ),
          ),
          Icon(suffixIcon, color: iconColor),
        ],
      ),
    );
  }

  Future<void> customShowDialog(BuildContext context, String title) {
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
                  title,
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

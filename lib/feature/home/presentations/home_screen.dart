import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:barkbridgeai/common_widgets/custom_button.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/feature/home/presentations/file_upload_speed_screen.dart';
import 'package:barkbridgeai/gen/assets.gen.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. Create an instance of ImagePicker
  final ImagePicker _picker = ImagePicker();

  // 2. Main Logic Function
  Future<void> _handleVideoSelection(
    BuildContext context,
    ImageSource source,
  ) async {
    try {
      // Pick video based on source (Camera or Gallery)
      final XFile? video = await _picker.pickVideo(
        source: source,
        maxDuration: const Duration(minutes: 5), // Optional limit
      );

      if (video != null) {
        // Close the dialog box first
        if (mounted) Navigator.of(context).pop();

        // Navigate to the next screen and pass the file
        // Ensure FileUploadSpeedScreen accepts a 'File?' or 'String path'
        print(video.path);
        Get.to(() => FileUploadSpeedScreen(videoFile: File(video.path)));
      }
    } catch (e) {
      debugPrint("Error picking video: $e");
      // Optional: Show a snackbar if permission is denied
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          "BarkBridge AI",
          style: TextFontStyle.textstyle11cB8BBCCManrope400.copyWith(
            color: AppColors.cD9DAE4,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 4,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 20.h),

            Container(
              height: 48.h,
              width: 63.w,
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColors.c778DFF.withAlpha(50)),
                color: AppColors.c778DFF.withAlpha(50),
              ),
              child: Center(
                child: Image.asset(
                  Assets.icons.crownIcon.path,
                  width: 25.w,
                  height: 25.h,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Translating Dog Sounds",
              style: TextFontStyle.textstyle20cFFFFFFManrope600.copyWith(
                fontSize: 35.sp,
                letterSpacing: 4,
                color: AppColors.cD9DAE4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              "Capture the howl to hear what your dog wants to say",
              style: TextFontStyle.textstyle16c5465A6Manrope500.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 245.h,
                  width: 245.w,
                  child: Lottie.asset(Assets.lottie.ringLottie),
                ),
                Positioned(
                  top: -40.h,
                  left: -40.w,
                  child: Image.asset(
                    Assets.icons.homeRingImage.path,
                    height: 330.h,
                    width: 330.w,
                  ),
                ),
                Positioned(
                  top: 60.h,
                  left: 66.w,
                  child: InkWell(
                    onTap: () {
                      customShowDialog(context);
                    },
                    child: Container(
                      width: 122.w,
                      height: 122.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.c3B53FF, AppColors.c2606ED],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          Assets.icons.scanCameraIcon.path,
                          height: 90.h,
                          width: 90.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //Credit Box
            // Credit Box
            SizedBox(height: 20.h),
            Container(
              height: 64.h,
              width: 167,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Color(0xFF031F5A).withAlpha(70),
                border: Border.all(
                  color: const Color.fromARGB(185, 80, 100, 200).withAlpha(80),
                ),
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        // height: 50.h,
                        // width: 50.w,
                        child: CircularProgressIndicator(
                          value: 0.75,
                          strokeWidth: 3.w,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF0454CB),
                          ),
                          backgroundColor: AppColors.c778DFF.withAlpha(50),
                        ),
                      ),
                      Text(
                        "190",
                        style: TextFontStyle.textstyle20cFFFFFFManrope600
                            .copyWith(
                              fontSize: 12.sp,
                              color: AppColors.cFFFFFF,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      "Credit Left",
                      style: TextFontStyle.textstyle11cB8BBCCManrope400
                          .copyWith(
                            fontSize: 14.sp,

                            color: const Color.fromARGB(255, 106, 122, 219),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> customShowDialog(BuildContext context) {
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
                  "Capture Dog Video",
                  style: TextFontStyle.textstyle20cFFFFFFManrope600,
                ),
                SizedBox(height: 10.h),
                Text(
                  "Record live or choose a file to translate",
                  style: TextFontStyle.textstyle11cB8BBCCManrope400.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.cB8BBCC,
                  ),
                ),
                SizedBox(height: 45.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        fillColor: AppColors.c282B3C,
                        buttonType: ButtonType.secondary,
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.cFFFFFF,
                        ),
                        text: "Upload Video",
                        onPressed: () {
                          _handleVideoSelection(context, ImageSource.gallery);
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomButton(
                        text: "Take Video",
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        onPressed: () {
                          _handleVideoSelection(context, ImageSource.camera);
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
}

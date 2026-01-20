import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:tintpin14_app/common_widgets/custom_button.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/home/presentations/file_upload_speed_screen.dart';
import 'package:tintpin14_app/gen/assets.gen.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
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
            letterSpacing: 1.5,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 20.h),
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.c778DFF.withAlpha(50),
              ),
              child: Icon(
                Icons.workspace_premium_outlined,
                size: 20.sp,
                color: AppColors.cFD5900,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Translating Dog Sounds",
              style: TextFontStyle.textstyle20cFFFFFFManrope600.copyWith(
                letterSpacing: 1.4,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Capture the howl to hear what your dog wants to say",
              style: TextFontStyle.textstyle16c5465A6Manrope500,
              textAlign: TextAlign.center,
            ),
            Stack(
              children: [
                Lottie.asset(Assets.lottie.cameraBackground),
                Positioned(
                  top: 118.h,
                  left: 110.w,
                  child: Container(
                    width: 122.w,
                    height: 122.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.c3B53FF, AppColors.c2606ED],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () {
                        customShowDialog(context);
                      },
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.cFFFFFF,
                        size: 70.sp,
                      ),
                    ),
                  ),
                ),
              ],
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

import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/feature/home/presentations/ai_response_screen.dart';
import 'package:tintpin14_app/feature/home/presentations/widgets/speedometer_guage.dart';
import 'package:tintpin14_app/navigation_screen.dart';

// --- MAIN SCREEN ---
class FileUploadSpeedScreen extends StatefulWidget {
  const FileUploadSpeedScreen({super.key, this.videoFile});
  final File? videoFile;

  @override
  State<FileUploadSpeedScreen> createState() => _UploadMediaScreenState();
}

class _UploadMediaScreenState extends State<FileUploadSpeedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _percentage = 0;

  @override
  void initState() {
    super.initState();
    // Logic: Simulate a 5-second upload process
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: 100).animate(_controller)
      ..addListener(() {
        setState(() {
          _percentage = _animation.value.toInt();
        });
      });

    // Start the simulation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        title: "Upload Media",
        backgroundColor: Colors.transparent,
      ),
      child: Column(
        children: [
          SizedBox(height: kToolbarHeight + 20.h),

          // Title Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              "Hang tight! Your file is uploading",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),

          SizedBox(height: 40.h),

          // Custom Speedometer Gauge
          SpeedometerGauge(value: _animation.value),

          SizedBox(height: 40.h),

          // Progress Card
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1125),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Small circular loader
                SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: CircularProgressIndicator(
                    value: _percentage / 100,
                    strokeWidth: 3,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF2E3BFF)),
                  ),
                ),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upload",
                      style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "$_percentage%",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // "Let's Go" Button
          Container(
            width: 160.w,
            height: 50.h,
            margin: EdgeInsets.only(bottom: 120.h), // Space for Nav Bar
            child: OutlinedButton(
              onPressed: () {
                Get.to(() => AiResponseScreen());
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: _percentage == 100
                      ? Color(0xFF2E3BFF)
                      : Color(0xFF2E3BFF).withAlpha(50),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Text(
                "Let's go",
                style: TextStyle(
                  color: _percentage == 100
                      ? Colors.white
                      : Colors.white.withAlpha(30),
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

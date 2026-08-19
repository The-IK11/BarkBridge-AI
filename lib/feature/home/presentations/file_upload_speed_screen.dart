import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barkbridgeai/common_widgets/custom_app_bar.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/feature/home/presentations/widgets/speedometer_guage.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/helpers/all_routes.dart';
import 'package:barkbridgeai/helpers/navigation_service.dart';
import 'package:barkbridgeai/networks/api_access.dart';

// --- MAIN SCREEN ---
class FileUploadSpeedScreen extends StatefulWidget {
  const FileUploadSpeedScreen({super.key, this.videoFile});
  final File? videoFile;

  @override
  State<FileUploadSpeedScreen> createState() => _UploadMediaScreenState();
}

class _UploadMediaScreenState extends State<FileUploadSpeedScreen>
    with SingleTickerProviderStateMixin {
  int _percentage = 0;
  int _lastPercentage = 0;
  bool _uploadComplete = false;
  bool _isUploading = false;
  String? _errorMessage;
  Timer? _progressTimer;
  int _currentUploadId = 0; // Track which upload this is

  @override
  void initState() {
    super.initState();
    // Start the upload immediately
    _startVideoUpload();
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  void _goBack() {
    if (!mounted) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final navigator = Navigator.of(context);
      if (navigator.canPop()) {
        navigator.pop();
      }
    });
  }

  Future<void> _startVideoUpload() async {
    // Cancel any previous uploads first
    _progressTimer?.cancel();

    // Increment upload ID to invalidate old stream events
    _currentUploadId++;
    final uploadId = _currentUploadId;

    if (widget.videoFile == null) {
      _goBack();
      return;
    }

    setState(() {
      _isUploading = true;
      _errorMessage = null;
      _percentage = 0;
      _lastPercentage = 0;
      _uploadComplete = false;
    });

    try {
      // Start simulating progress BEFORE making API call
      _progressTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        // Only update if this is still the current upload
        if (uploadId == _currentUploadId &&
            mounted &&
            _percentage < 95 &&
            _isUploading) {
          // Check if progress is stalled (no change in last 100ms)
          if (_percentage == _lastPercentage && _percentage > 0) {
            print('Upload stalled at $_percentage%');
            timer.cancel();
            _goBack();
            return;
          }
          _lastPercentage = _percentage;
          setState(() {
            _percentage += 1;
          });
        }
      });

      // Make the API call
      final success = await postPetAnalyze.postData(
        data: {'media': widget.videoFile},
      );

      if (!success || uploadId != _currentUploadId) {
        _progressTimer?.cancel();
        if (mounted) {
          _goBack();
        }
        return;
      }

      _progressTimer?.cancel();
      if (mounted) {
        setState(() {
          _uploadComplete = true;
          _percentage = 100;
          _isUploading = false;
        });
      }
    } catch (e) {
      if (uploadId == _currentUploadId) {
        _progressTimer?.cancel();
        print('Upload Error: $e');
        _goBack();
      }
    }
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
          SizedBox(height: kToolbarHeight + 50.h),

          // Title Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              _errorMessage != null
                  ? "Upload Failed"
                  : "Hang tight! Your file is uploading",
              textAlign: TextAlign.center,
              style: TextFontStyle.textstyle11cB8BBCCManrope400.copyWith(
                color: AppColors.cD9DAE4,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 3,
              ),
            ),
          ),

          SizedBox(height: 40.h),

          // Custom Speedometer Gauge or Error Message
          if (_errorMessage == null)
            SpeedometerGauge(value: _percentage.toDouble())
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                _errorMessage ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
            ),

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
              onPressed: _uploadComplete
                  ? () {
                      getUserCredit.fetch();
                      NavigationService.navigateToWithArgs(
                        Routes.aiResponseScreen,
                        {"isAIResponseScreen": true},
                      );
                    }
                  : null,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: _uploadComplete
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
                  color: _uploadComplete
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

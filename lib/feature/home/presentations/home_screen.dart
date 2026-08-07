import 'dart:io';
import 'dart:ui';

import 'package:barkbridgeai/helpers/ui_helpers.dart';
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
import 'package:barkbridgeai/networks/api_access.dart';
import 'package:barkbridgeai/feature/home/model/get_credits_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // 1. Create an instance of ImagePicker
  final ImagePicker _picker = ImagePicker();

  // ── Staggered entrance animation (plays only once per app session) ──
  static bool _hasAnimated = false;
  late final AnimationController _entranceController;
  static const int _itemCount = 5;
  static const Duration _totalDuration = Duration(milliseconds: 2500);
  static const Duration _staggerDelay = Duration(milliseconds: 300);

  List<Animation<double>> _fadeAnimations = [];

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
  void initState() {
    super.initState();
    getUserCredit.fetch();

    // ── Set up staggered entrance ──
    _entranceController = AnimationController(
      vsync: this,
      duration: _totalDuration,
    );

    for (int i = 0; i < _itemCount; i++) {
      final startFraction =
          (_staggerDelay.inMilliseconds * i) / _totalDuration.inMilliseconds;
      // Each item takes ~40% of the total timeline to animate in
      final endFraction = (startFraction + 0.4).clamp(0.0, 1.0);

      _fadeAnimations.add(
        CurvedAnimation(
          parent: _entranceController,
          curve: Interval(startFraction, endFraction, curve: Curves.easeOut),
        ),
      );
    }

    if (!_hasAnimated) {
      // Small delay so the first frame is laid out before animating
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _entranceController.forward().then((_) => _hasAnimated = true);
        }
      });
    } else {
      _entranceController.value = 1.0; // skip animation — show instantly
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  /// Wraps a child with fade + translate (paint-only, no layout thrashing).
  Widget _staggered(int index, Widget child) {
    return AnimatedBuilder(
      animation: _fadeAnimations[index],
      builder: (context, child) {
        final t = _fadeAnimations[index].value;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 40.0 * (1.0 - t)),
            child: child,
          ),
        );
      },
      child: child, // cached — not rebuilt on every frame
    );
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
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 20.h),
            //Header section//////////////////
            _staggered(
              0,
              Container(
                height: 55.h,
                width: 70.w,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 5.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.c778DFF.withAlpha(50)),
                  color: AppColors.c778DFF.withAlpha(50),
                ),
                child: Center(
                  child: Lottie.asset(
                    Assets.lottie.pepitosPet,
                    // width: 25.w,
                    // height: 25.h,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            _staggered(
              1,
              Text(
                "Translating Dog Sounds",
                style: TextFontStyle.textstyle20cFFFFFFManrope600.copyWith(
                  fontSize: 35.sp,
                  letterSpacing: 4,
                  color: AppColors.cD9DAE4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.h),
            _staggered(
              2,
              Text(
                "Capture the howl to hear what your dog wants to say",
                style: TextFontStyle.textstyle16c5465A6Manrope500.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),

            ///Camera button section//////////////////////////
            _staggered(
              3,
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
            ),

            // Credit Box section/////////////////////////
            SizedBox(height: 20.h),
            _staggered(
              4,
              StreamBuilder<GetCreditsModel>(
                stream: getUserCredit.getStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ShimmerGlassContainer(
                      height: 64.h,
                      width: 167.w,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Center(
                        child: SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.w,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF0454CB),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  final model = snapshot.data;
                  final credits = model?.data?.credits ?? 0;
                  final freeCredits = model?.data?.freeCredit ?? 0;
                  final total = credits + freeCredits;

                  if (total == 0) {
                    return ShimmerGlassContainer(
                      height: 64.h,
                      width: 260.w,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          child: Text(
                            "Please buy credits for more translating",
                            textAlign: TextAlign.center,
                            style: TextFontStyle.textstyle11cB8BBCCManrope400
                                .copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(
                                    255,
                                    106,
                                    122,
                                    219,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    );
                  }

                  return ShimmerGlassContainer(
                    height: 64.h,
                    width: 180.w,
                    borderRadius: BorderRadius.circular(20.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        children: [
                          SpinningGlowRing(total: total),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Text(
                              "Credit Left",
                              style: TextFontStyle.textstyle11cB8BBCCManrope400
                                  .copyWith(
                                    fontSize: 13.sp,
                                    color: const Color.fromARGB(
                                      255,
                                      106,
                                      122,
                                      219,
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 50.h),
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
                          fontSize: 13.sp,
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
                          fontSize: 13.sp,
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

class SpinningGlowRing extends StatefulWidget {
  final int total;
  const SpinningGlowRing({super.key, required this.total});

  @override
  State<SpinningGlowRing> createState() => _SpinningGlowRingState();
}

class _SpinningGlowRingState extends State<SpinningGlowRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 52.w,
          height: 52.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0454CB).withAlpha(120),
                blurRadius: 10.r,
                spreadRadius: 1.r,
              ),
            ],
          ),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Rotating gradient border
                RotationTransition(
                  turns: _controller,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          const Color(0xFF0454CB),
                          const Color(0xFF778DFF).withAlpha(100),
                          const Color(0xFF0454CB),
                        ],
                      ),
                    ),
                  ),
                ),
                // Inner solid circle matching background
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF031F5A), // Match the background
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(4.sp),
                      child: Text(
                        "${widget.total}",
                        style: TextFontStyle.textstyle20cFFFFFFManrope600
                            .copyWith(
                              fontSize: 12.sp,
                              color: AppColors.cFFFFFF,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ShimmerGlassContainer extends StatefulWidget {
  final Widget child;
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const ShimmerGlassContainer({
    super.key,
    required this.child,
    required this.height,
    required this.width,
    required this.borderRadius,
  });

  @override
  State<ShimmerGlassContainer> createState() => _ShimmerGlassContainerState();
}

class _ShimmerGlassContainerState extends State<ShimmerGlassContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: widget.borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                color: const Color(0xFF031F5A).withAlpha(40),
                border: Border.all(
                  color: Colors.white.withAlpha(25),
                  width: 1.w,
                ),
              ),
              child: Stack(
                children: [
                  // Shimmer shine highlight line
                  Positioned.fill(
                    child: FractionallySizedBox(
                      alignment: Alignment(
                        -2.0 + (_shimmerController.value * 4.0),
                        0.0,
                      ),
                      widthFactor: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withAlpha(35),
                              Colors.transparent,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Positioned.fill(child: widget.child),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

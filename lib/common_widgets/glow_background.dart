import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/navigation_screen.dart';

class GlowBackground extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final CustomBottomNavBar? bottomNavigationBar;
  const GlowBackground({
    super.key,
    required this.child,
    this.bottomNavigationBar,
    this.appBar, // 2. Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050511), // Very dark blue/black base
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Stack(
        children: [
          // ---------------------------------------------
          // 1. TOP RIGHT GLOW (Cyan/Blue)
          // ---------------------------------------------
          Positioned(
            top: -100.h,
            right: -100.w,
            child: Container(
              width: 400.w,
              height: 400.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.c0454CB, // Center color
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7], // Fade out before edge
                ),
              ),
            ),
          ),

          // ---------------------------------------------
          // 2. BOTTOM LEFT GLOW (Deep Blue/Purple)
          // ---------------------------------------------
          Positioned(
            bottom: -100.h,
            left: -100.w,
            child: Container(
              width: 400.w,
              height: 400.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF3B2DB5).withOpacity(0.5), // Deep Blue
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
          ),

          // ---------------------------------------------
          // 3. BLUR FILTER (The "Mesh" Effect)
          // ---------------------------------------------
          // This makes the glows look soft and diffused like the design
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
            child: Container(
              color: Colors.transparent, // Required for filter to apply
            ),
          ),

          // ---------------------------------------------
          // 4. THE ACTUAL CONTENT
          // ---------------------------------------------
          SafeArea(top: appBar == null, child: child),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

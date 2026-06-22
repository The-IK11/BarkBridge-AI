import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barkbridgeai/common_widgets/custom_app_bar.dart';
import 'package:barkbridgeai/common_widgets/custom_button.dart';
import 'package:barkbridgeai/common_widgets/glow_background.dart';
import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/gen/assets.gen.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/helpers/navigation_service.dart';

/// Enum representing each subscription plan tier.
enum PlanType { free, starter, value, proMonthly }

class PlanAndPricingScreen extends StatefulWidget {
  const PlanAndPricingScreen({super.key});

  @override
  State<PlanAndPricingScreen> createState() => _PlanAndPricingScreenState();
}

class _PlanAndPricingScreenState extends State<PlanAndPricingScreen>
    with SingleTickerProviderStateMixin {
  PlanType _selectedPlan = PlanType.proMonthly;

  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  /// Returns the CTA button label based on the currently selected plan.
  String get _ctaLabel {
    switch (_selectedPlan) {
      case PlanType.free:
        return "Continue with Free";
      case PlanType.starter:
        return "Buy Starter Pack — \$5.99";
      case PlanType.value:
        return "Buy Value Pack — \$9.99";
      case PlanType.proMonthly:
        return "Subscribe for \$19.99/month";
    }
  }

  /// Platform-aware store name for compliance text.
  String get _storeName {
    try {
      return Platform.isIOS ? "App Store" : "Google Play";
    } catch (_) {
      return "App Store / Google Play";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        showBackButton: true,
        title: "Plans and Pricing",
        leading: InkWell(
          borderRadius: BorderRadius.circular(50.r),
          onTap: () {
            NavigationService.goBack;
          },
          child: Icon(Icons.close, color: Colors.white, size: 20.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kToolbarHeight + 60.h),

              // ── Crown icon ──
              Center(
                child: Image.asset(
                  Assets.icons.whiteCrownIcon.path,
                  width: 80.w,
                  height: 80.h,
                ),
              ),
              SizedBox(height: 8.h),

              // ── Free tier teaser ──
              Center(
                child: Text(
                  "Start with 3 free scans",
                  style: TextFontStyle.textstyle15c5465A6Manrope400.copyWith(
                    color: AppColors.c778DFF,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              _dividerLine(),
              SizedBox(height: 20.h),

              // ══════════════════════════════════════════════
              //  PRO MONTHLY HERO CARD — $19.99/month
              // ══════════════════════════════════════════════
              _buildProMonthlyCard(),

              SizedBox(height: 20.h),
              _dividerLine(),
              SizedBox(height: 20.h),

              // ── Section title ──
              Text(
                "CREDIT PACKS",
                style: TextFontStyle.textstyle16c5465A6Manrope500,
              ),
              SizedBox(height: 16.h),

              // ══════════════════════════════════════════════
              //  STARTER PACK — $5.99 one-time, 10 scans
              // ══════════════════════════════════════════════
              _buildCreditPackCard(
                planType: PlanType.starter,
                title: "Starter Pack",
                scans: "10 Scans",
                price: "\$5.99",
                priceSubtitle: "/One-time purchase",
                badge: null,
              ),
              SizedBox(height: 14.h),

              // ══════════════════════════════════════════════
              //  VALUE PACK — $9.99 one-time, 25 scans
              // ══════════════════════════════════════════════
              _buildCreditPackCard(
                planType: PlanType.value,
                title: "Value Pack",
                scans: "25 Scans",
                price: "\$9.99",
                priceSubtitle: "/One-time purchase",
                badge: "MOST POPULAR",
              ),

              SizedBox(height: 24.h),

              // ── CTA Button ──
              CustomButton(
                text: _ctaLabel,
                onPressed: () {
                  // TODO: Trigger purchase flow for _selectedPlan
                },
              ),

              SizedBox(height: 16.h),

              // ── Continue with Free ──
              if (_selectedPlan != PlanType.free)
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() => _selectedPlan = PlanType.free);
                    },
                    child: Text(
                      "Continue with Free (3 scans)",
                      style: TextFontStyle.textstyle15c5465A6Manrope400
                          .copyWith(
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.c5465A6,
                          ),
                    ),
                  ),
                ),

              SizedBox(height: 12.h),

              // ══════════════════════════════════════════════
              //  COMPLIANCE DISCLOSURE TEXT
              //  Required by Apple App Store & Google Play
              // ══════════════════════════════════════════════
              _buildComplianceDisclosure(),

              SizedBox(height: 16.h),

              // ── Restore Purchases ──
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Implement restore purchases
                  },
                  child: Text(
                    "Restore Purchases",
                    style: TextFontStyle.textstyle15c5465A6Manrope400.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.c778DFF,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 4.h),

              // ── Privacy Policy • Terms of Use ──
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: Open Privacy Policy URL
                    },
                    child: Text(
                      "Privacy Policy",
                      style: TextFontStyle.textstyle15c5465A6Manrope400
                          .copyWith(fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    height: 5.h,
                    width: 5.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.c2400FF,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  TextButton(
                    onPressed: () {
                      // TODO: Open Terms of Use URL
                    },
                    child: Text(
                      "Terms of Use",
                      style: TextFontStyle.textstyle15c5465A6Manrope400
                          .copyWith(fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────
  //  PRO MONTHLY HERO CARD
  // ─────────────────────────────────────────────────────────────────
  Widget _buildProMonthlyCard() {
    final bool isSelected = _selectedPlan == PlanType.proMonthly;

    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = PlanType.proMonthly),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: const LinearGradient(
            colors: [AppColors.c3B53FF, AppColors.c2606ED, AppColors.c3B53FF],
          ),
          border: Border.all(
            color: isSelected ? AppColors.c778DFF : Colors.transparent,
            width: isSelected ? 2.w : 0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.c3B53FF.withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header row with badge ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PRO MONTHLY",
                  style: TextFontStyle.textstyle16cFFFFFFManrope500.copyWith(
                    color: AppColors.cC2C2C2,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                // ── Animated "BEST VALUE" badge ──
                AnimatedBuilder(
                  animation: _shimmerController,
                  builder: (context, child) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: LinearGradient(
                          begin: Alignment(
                            -1.0 + 2.0 * _shimmerController.value,
                            0,
                          ),
                          end: Alignment(
                            1.0 + 2.0 * _shimmerController.value,
                            0,
                          ),
                          colors: const [
                            AppColors.cDAA356,
                            Color(0xFFFFF1C9),
                            AppColors.cDAA356,
                          ],
                        ),
                      ),
                      child: Text(
                        "BEST VALUE",
                        style: TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A0A00),
                          letterSpacing: 1.0,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // ── Price ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$19.99",
                  style: TextFontStyle.textstyle28cFFFFFFManrope700,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "/Per Month",
                    style: TextFontStyle.textstyle16c5465A6Manrope500.copyWith(
                      color: AppColors.cC2C2C2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),

            // ── Features ──
            _premiumFacility("100 scans per month"),
            _premiumFacility("Monthly usage counter reset"),
            _premiumFacility("Premium features unlocked"),
            _premiumFacility("Priority support"),

            // ── Selection indicator ──
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "Selected",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────
  //  CREDIT PACK CARD (Starter / Value)
  // ─────────────────────────────────────────────────────────────────
  Widget _buildCreditPackCard({
    required PlanType planType,
    required String title,
    required String scans,
    required String price,
    required String priceSubtitle,
    String? badge,
  }) {
    final bool isSelected = _selectedPlan == planType;

    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = planType),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border.all(
            width: isSelected ? 2.w : 1.w,
            color: isSelected ? AppColors.c778DFF : AppColors.c3B53FF,
          ),
          borderRadius: BorderRadius.circular(26.r),
          color: isSelected
              ? AppColors.c3B53FF.withValues(alpha: 0.08)
              : Colors.transparent,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.c3B53FF.withValues(alpha: 0.25),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Badge row (if applicable) ──
            if (badge != null)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C4DFF), Color(0xFFAD46FF)],
                    ),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      fontFamily: "Manrope",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ── Plan info ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextFontStyle.textstyle16cFFFFFFManrope500
                            .copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        scans,
                        style: TextFontStyle.textstyle16c5465A6Manrope500
                            .copyWith(
                              color: AppColors.cC2C2C2,
                              fontSize: 14.sp,
                            ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            price,
                            style: TextFontStyle.textstyle28cFFFFFFManrope700
                                .copyWith(fontSize: 24.sp),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              priceSubtitle,
                              style: TextFontStyle.textstyle16c5465A6Manrope500
                                  .copyWith(
                                    color: AppColors.cC2C2C2,
                                    fontSize: 13.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── Buy / Selected indicator ──
                isSelected
                    ? Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          gradient: const LinearGradient(
                            colors: [AppColors.c3B53FF, AppColors.c2400FF],
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "Selected",
                              style: TextFontStyle.textstyle16cFFFFFFManrope500
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          gradient: const LinearGradient(
                            colors: [AppColors.c3B53FF, AppColors.c2400FF],
                          ),
                        ),
                        child: Text(
                          "Buy Now",
                          style: TextFontStyle.textstyle16cFFFFFFManrope500
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────
  //  COMPLIANCE DISCLOSURE (Apple & Google required)
  // ─────────────────────────────────────────────────────────────────
  Widget _buildComplianceDisclosure() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Text(
        "Payment will be charged to your $_storeName account at confirmation "
        "of purchase. Subscription automatically renews unless auto-renew is "
        "turned off at least 24 hours before the end of the current period. "
        "Your account will be charged for renewal within 24 hours prior to "
        "the end of the current period. You can manage and cancel your "
        "subscriptions by going to your account settings on the $_storeName "
        "after purchase.",
        textAlign: TextAlign.center,
        style: TextFontStyle.textstyle15c5465A6Manrope400.copyWith(
          fontSize: 11.sp,
          color: const Color.fromARGB(
            255,
            138,
            146,
            180,
          ).withValues(alpha: 0.7),
          height: 1.5,
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────
  //  SHARED HELPERS
  // ─────────────────────────────────────────────────────────────────

  Widget _dividerLine() {
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

  Widget _premiumFacility(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
      leading: Assets.icons.bubbleTickIcon.image(width: 22.w, height: 22.h),
      title: Text(
        title,
        style: TextFontStyle.textstyle16c5465A6Manrope500.copyWith(
          color: AppColors.cFFFFFF,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

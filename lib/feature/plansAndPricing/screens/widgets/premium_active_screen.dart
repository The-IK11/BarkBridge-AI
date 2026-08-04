import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart' hide PurchaseResult;

import 'package:barkbridgeai/constants/text_font_style.dart';
import 'package:barkbridgeai/gen/assets.gen.dart';
import 'package:barkbridgeai/gen/colors.gen.dart';
import 'package:barkbridgeai/helpers/navigation_service.dart';
import 'package:barkbridgeai/networks/api_access.dart';
import 'package:barkbridgeai/feature/home/model/get_credits_model.dart';
import 'package:barkbridgeai/services/revenuecat_service/revenue_cat_service.dart';
import 'package:barkbridgeai/services/revenuecat_service/revenue_cut_constent.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  PremiumActiveScreen
//  Shown when the user already has an active Pro Monthly subscription.
//  Still exposes credit-pack purchases so Pro users who exhaust their
//  100 monthly scans can top up without leaving the screen.
// ─────────────────────────────────────────────────────────────────────────────
class PremiumActiveScreen extends StatefulWidget {
  const PremiumActiveScreen({super.key});

  @override
  State<PremiumActiveScreen> createState() => _PremiumActiveScreenState();
}

class _PremiumActiveScreenState extends State<PremiumActiveScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  // Dynamic prices from RevenueCat
  bool _isLoadingPrices = true;
  final Map<String, StoreProduct> _storeProducts = {};

  bool _isPurchasing = false;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _loadPrices();
    getUserCredit.fetch();
  }

  Future<void> _loadPrices() async {
    try {
      final offerings = await RevenueCatService().getOfferings();
      if (offerings != null && mounted) {
        final Map<String, StoreProduct> loaded = {};
        for (final offering in offerings.all.values) {
          for (final pkg in offering.availablePackages) {
            loaded[pkg.storeProduct.identifier] = pkg.storeProduct;
          }
        }
        setState(() {
          _storeProducts.addAll(loaded);
          _isLoadingPrices = false;
        });
      } else if (mounted) {
        setState(() => _isLoadingPrices = false);
      }
    } catch (e) {
      debugPrint('⚠️ PremiumActiveScreen: Could not load prices: $e');
      if (mounted) setState(() => _isLoadingPrices = false);
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  String get _storeName {
    try {
      return Platform.isIOS ? 'App Store' : 'Google Play';
    } catch (_) {
      return 'App Store / Google Play';
    }
  }

  String _priceFor(String? productId, {required String fallback}) {
    if (productId == null) return fallback;
    return _storeProducts[productId]?.priceString ?? fallback;
  }

  String _starterProductId() {
    try {
      return Platform.isIOS
          ? RevenueCutConstent.credits10AppStoreId
          : RevenueCutConstent.credits10ProductId;
    } catch (_) {
      return RevenueCutConstent.credits10ProductId;
    }
  }

  String _valueProductId() {
    try {
      return Platform.isIOS
          ? RevenueCutConstent.credits25AppStoreId
          : RevenueCutConstent.credits25ProductId;
    } catch (_) {
      return RevenueCutConstent.credits25ProductId;
    }
  }

  Future<void> _purchaseCreditPack({
    required String productId,
    required int credits,
    required String packName,
  }) async {
    if (_isPurchasing) return;
    setState(() => _isPurchasing = true);

    try {
      final result =
          await RevenueCatService().purchaseByStoreProductId(productId);

      switch (result) {
        case PurchaseResult.success:
          Future.delayed(const Duration(seconds: 5), () {
            getUserCredit.fetch();
          });
          if (mounted) {
            Get.snackbar(
              '✅ Purchase Successful',
              '$credits scan credits added!',
              snackPosition: SnackPosition.TOP,
              backgroundColor: AppColors.c3B53FF.withValues(alpha: 0.9),
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
            );
          }
          break;
        case PurchaseResult.cancelled:
          debugPrint('Purchase cancelled by user');
          break;
        case PurchaseResult.alreadyPurchased:
          if (mounted) {
            Get.snackbar(
              'Already Purchased',
              'You already own this product.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.orange.withValues(alpha: 0.9),
              colorText: Colors.white,
            );
          }
          break;
        case PurchaseResult.notAllowed:
          if (mounted) {
            Get.snackbar(
              'Purchase Not Allowed',
              'In-app purchases are disabled on this device.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red.withValues(alpha: 0.9),
              colorText: Colors.white,
            );
          }
          break;
        case PurchaseResult.error:
          if (mounted) {
            Get.snackbar(
              'Purchase Failed',
              'Something went wrong. Please try again.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red.withValues(alpha: 0.9),
              colorText: Colors.white,
            );
          }
          break;
      }
    } catch (e) {
      debugPrint('❌ Credit pack purchase error: $e');
      if (mounted) {
        Get.snackbar(
          'Error',
          'An unexpected error occurred.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      }
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight + 60.h),

            // ── Premium Hero Banner ──────────────────────────────────────
            _buildPremiumHeroBanner(),

            SizedBox(height: 24.h),

            // ── Credits Counter ──────────────────────────────────────────
            _buildCreditsCounter(),

            SizedBox(height: 24.h),

            // ── Divider ──────────────────────────────────────────────────
            _dividerLine(),
            SizedBox(height: 20.h),

            // ── "Need More Scans?" section ───────────────────────────────
            _buildMoreScansHeader(),
            SizedBox(height: 16.h),

            // ── Starter Pack ─────────────────────────────────────────────
            _buildCreditPackCard(
              title: 'Starter Pack',
              scans: '10 Scans',
              price: _isLoadingPrices
                  ? '...'
                  : _priceFor(_starterProductId(), fallback: '\$5.99'),
              priceSubtitle: '/One-time',
              badge: null,
              onBuy: _isPurchasing
                  ? null
                  : () => _purchaseCreditPack(
                        productId: _starterProductId(),
                        credits: 10,
                        packName: 'Starter Pack',
                      ),
            ),
            SizedBox(height: 14.h),

            // ── Value Pack ───────────────────────────────────────────────
            _buildCreditPackCard(
              title: 'Value Pack',
              scans: '25 Scans',
              price: _isLoadingPrices
                  ? '...'
                  : _priceFor(_valueProductId(), fallback: '\$9.99'),
              priceSubtitle: '/One-time',
              badge: 'MOST POPULAR',
              onBuy: _isPurchasing
                  ? null
                  : () => _purchaseCreditPack(
                        productId: _valueProductId(),
                        credits: 25,
                        packName: 'Value Pack',
                      ),
            ),

            SizedBox(height: 24.h),
            _dividerLine(),
            SizedBox(height: 20.h),

            // ── Active Plan Feature Summary ──────────────────────────────
            _buildActivePlanFeatures(),

            SizedBox(height: 24.h),

            // ── Compliance text ──────────────────────────────────────────
            _buildComplianceDisclosure(),

            SizedBox(height: 4.h),

            // ── Legal links ──────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Open Privacy Policy URL
                  },
                  child: Text(
                    'Privacy Policy',
                    style: TextFontStyle.textstyle15c5465A6Manrope400.copyWith(
                      fontSize: 12.sp,
                    ),
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
                    'Terms of Use',
                    style: TextFontStyle.textstyle15c5465A6Manrope400.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  PREMIUM HERO BANNER
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildPremiumHeroBanner() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A1060),
                AppColors.c3B53FF,
                Color(0xFF2606ED),
                Color(0xFF1A1060),
              ],
              stops: [0.0, 0.4, 0.7, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.c3B53FF.withValues(alpha: 0.45),
                blurRadius: 32,
                spreadRadius: 4,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              // ── Shimmer crown icon ────────────────────────────────────
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(
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
                ).createShader(bounds),
                child: Image.asset(
                  Assets.icons.whiteCrownIcon.path,
                  width: 64.w,
                  height: 64.h,
                ),
              ),
              SizedBox(height: 16.h),

              // ── "PRO MEMBER" badge ────────────────────────────────────
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 5.h,
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
                  '★  PRO MEMBER  ★',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1A0A00),
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // ── Headline ──────────────────────────────────────────────
              Text(
                "You're on the Pro Plan",
                textAlign: TextAlign.center,
                style: TextFontStyle.textstyle28cFFFFFFManrope700.copyWith(
                  fontSize: 22.sp,
                  height: 1.3,
                ),
              ),
              SizedBox(height: 8.h),

              Text(
                'Enjoy 100 scans every month,\npriority support, and premium features.',
                textAlign: TextAlign.center,
                style: TextFontStyle.textstyle15c5465A6Manrope400.copyWith(
                  color: AppColors.cC2C2C2,
                  fontSize: 13.sp,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 20.h),

              // ── "Back to App" action button ───────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => NavigationService.goBack,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white.withValues(alpha: 0.15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    minimumSize: Size(double.infinity, 46.h),
                  ),
                  child: Text(
                    'Back to App',
                    style: TextFontStyle.textstyle16cFFFFFFManrope500.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  CREDITS COUNTER PILL
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildCreditsCounter() {
    return Center(
      child: StreamBuilder<GetCreditsModel>(
        stream: getUserCredit.getStream,
        builder: (context, snapshot) {
          final model = snapshot.data;
          final credits = (model?.data?.credits ?? 0) + (model?.data?.freeCredit ?? 0);
          return Column(
            children: [
              Text(
                'Your current balance',
                style: TextFontStyle.textstyle15c5465A6Manrope400.copyWith(
                  color: AppColors.c778DFF,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.c3B53FF.withValues(alpha: 0.2),
                      AppColors.c3B53FF.withValues(alpha: 0.08),
                    ],
                  ),
                  border: Border.all(
                    color: AppColors.c778DFF.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bolt_rounded,
                      color: AppColors.cDAA356,
                      size: 22.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '$credits',
                      style:
                          TextFontStyle.textstyle28cFFFFFFManrope700.copyWith(
                        fontSize: 26.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'scans remaining',
                      style:
                          TextFontStyle.textstyle16cFFFFFFManrope500.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.cC2C2C2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  "NEED MORE SCANS?" HEADER
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildMoreScansHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.add_circle_rounded,
              color: AppColors.c778DFF,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Need More Scans?',
              style: TextFontStyle.textstyle16cFFFFFFManrope500.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          'Used up your 100 monthly scans? Top up with a one-time credit pack — no extra subscription needed.',
          style: TextFontStyle.textstyle15c5465A6Manrope400.copyWith(
            fontSize: 13.sp,
            height: 1.55,
            color: AppColors.c5465A6,
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  CREDIT PACK CARD
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildCreditPackCard({
    required String title,
    required String scans,
    required String price,
    required String priceSubtitle,
    required VoidCallback? onBuy,
    String? badge,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5.w,
          color: AppColors.c3B53FF.withValues(alpha: 0.7),
        ),
        borderRadius: BorderRadius.circular(26.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.c3B53FF.withValues(alpha: 0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Badge ──
          if (badge != null)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C4DFF), Color(0xFFAD46FF)],
                  ),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontFamily: 'Manrope',
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
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.bolt_rounded,
                          color: AppColors.cDAA356,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          scans,
                          style: TextFontStyle.textstyle15c5465A6Manrope400
                              .copyWith(
                            color: AppColors.cC2C2C2,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: TextFontStyle.textstyle28cFFFFFFManrope700
                              .copyWith(fontSize: 22.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            priceSubtitle,
                            style: TextFontStyle.textstyle15c5465A6Manrope400
                                .copyWith(
                              color: AppColors.cC2C2C2,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Buy button ──
              GestureDetector(
                onTap: _isPurchasing ? null : onBuy,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isPurchasing ? 0.5 : 1.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: const LinearGradient(
                        colors: [AppColors.c3B53FF, AppColors.c2400FF],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.c3B53FF.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: _isPurchasing
                        ? SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            'Buy Now',
                            style: TextFontStyle.textstyle16cFFFFFFManrope500
                                .copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  ACTIVE PLAN FEATURE SUMMARY
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildActivePlanFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR PRO BENEFITS',
          style: TextFontStyle.textstyle16c5465A6Manrope500.copyWith(
            fontSize: 12.sp,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 14.h),
        _featureRow(Icons.bolt_rounded, '100 scans per month'),
        _featureRow(Icons.autorenew_rounded, 'Monthly usage counter reset'),
        _featureRow(Icons.star_rounded, 'All premium features unlocked'),
        _featureRow(Icons.headset_mic_rounded, 'Priority support'),
      ],
    );
  }

  Widget _featureRow(IconData icon, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.c3B53FF.withValues(alpha: 0.15),
            ),
            child: Icon(icon, color: AppColors.c778DFF, size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Text(
            label,
            style: TextFontStyle.textstyle16cFFFFFFManrope500.copyWith(
              fontSize: 14.sp,
              color: AppColors.cFFFFFF.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  COMPLIANCE DISCLOSURE
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildComplianceDisclosure() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Text(
        'One-time credit pack payments are charged to your $_storeName account '
        'at confirmation of purchase. Credits do not expire and are separate '
        'from your monthly subscription allowance.',
        textAlign: TextAlign.center,
        style: TextFontStyle.textstyle15c5465A6Manrope400.copyWith(
          fontSize: 11.sp,
          color: const Color.fromARGB(255, 138, 146, 180).withValues(alpha: 0.7),
          height: 1.5,
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  DIVIDER HELPER
  // ─────────────────────────────────────────────────────────────────────────
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
}

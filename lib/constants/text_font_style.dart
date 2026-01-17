import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';

class TextFontStyle {
  TextFontStyle._();

  static const List<String> _fontFamilyFallBackChakraPetch = [
    "HelveticaNeue",
    "Arial",
    "Chakra Petch",
    "SF Compact Display",
    'Poppins',
    'Inter',
    'Roboto',
    'Noto Sans',
    'Manrope',
  ];

  static const String _fontFamilyChakraPetch = "Chakra Petch";
  static const String _fontFamilyOpenSans = "Open Sans";
  static const String _fontFamilyUrbanist = "Urbanist";
  static const String _fontFamilyHelveticaNeue = "HelveticaNeue";
  static const String _fontFamilyArial = "Arial";
  static const String _fontFamilyManrope = "Manrope";

  static final textStylec16c4B5563ChakraPetch400 = TextStyle(
    fontFamily: _fontFamilyChakraPetch,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: const Color(0xFF4B5563),
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.375, // 22/16
  );

  static final headlinec48c02505FChakraPetch600 = TextStyle(
    fontFamily: _fontFamilyChakraPetch,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: const Color(0xFF02505F),
    fontSize: 48.sp,
    fontWeight: FontWeight.w600,
    height: 1.167, // 56/48
  );

  static final textStylec18c121212SFCompact600 = TextStyle(
    fontFamily: "SF Compact Display",
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: const Color(0xFF121212),
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Loading status - 14px, #02505F, 700, uppercase
  static final textStylec14c02505FChakraPetch700 = TextStyle(
    fontFamily: _fontFamilyChakraPetch,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: const Color(0xFF02505F),
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    height: 1.429, // 20/14
  );

  // static final textStylec12c999999Poppins400 = TextStyle(
  //   fontFamily: _fontFamilyPoppins,
  //   fontFamilyFallback: _fontFamilyFallBackChakraPetch,
  //   color: AppColors.c999999,
  //   fontSize: 12.sp,
  //   fontWeight: FontWeight.w400,
  // );

  static const textStylec16c1C1A25NunitoSans700 = TextStyle(
    fontSize: 16,
    color: Color(0xFF1C1A25),
    fontFamily: 'NunitoSans',
    fontWeight: FontWeight.w700,
  );

  static final headlinec32c1F2937ChakraPetch700 = TextStyle(
    fontFamily: _fontFamilyChakraPetch,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: const Color(0xFF1F2937),
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 1.3125, // 42/32
  );

  // Style added by Hridoy

  static final textStyle24cffffffOpenSans700 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.32,
  );

  static final textStyle20cffffffOpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    height: 1.64,
  );

  static final textStyle12c939393OpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c939393,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.64,
  );

  static final textStyle20cffffffOpenSans600 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.64,
  );

  static final textStyle12cEDEDEDOpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cEDEDED,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.64,
  );

  static final textStyle16c380E36penSans600 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c380E36,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final textStyle20c171717OpenSans700 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c171717,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: 1.40,
    letterSpacing: -0.40,
  );

  static final textStyle24c000000OpenSans600 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c000000,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );

  static final textStyle16cffffffOpenSans600 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final textStyle14c171717OpenSans700 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c171717,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    height: 1.20,
    letterSpacing: -0.42,
  );

  static final textStyle16c121212OpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c121212,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static final textStyle16c93268FOpenSans600 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c93268F,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static final textStyle12cEEEEEEOpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cEEEEEE,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  static final textStyle12c939393OpenSans600 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c939393,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );
  static final textStyle18c171717Urbanist700 = TextStyle(
    fontFamily: _fontFamilyUrbanist,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c171717,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
  static final textStyle12c93268FOpenSans700 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c93268F,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );
  static final textStyle12c535353OpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c535353,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  static final textStyle12cEDA922OpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cEDA922,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  static final textStyle14c93268FOpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c93268F,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final textStyle14c939393OpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c939393,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final textStyle14cFFFFFFOpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final textStyle14c989898OpenSans400 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c989898,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final textStyle14c93268FOpenSans600 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c93268F,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );
  static final textStyle24c171717FOpenSans700 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c171717,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );
  static final textStyle18c171717OpenSans600 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c171717,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
  static final textStyle12c171717OpenSans600 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c171717,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );
  static final textStyle14c171717OpenSans600 = TextStyle(
    fontFamily: _fontFamilyOpenSans,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c171717,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.50,
  );
  static final textstyle24c0A0A0AHelveticaNeue500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c0A0A0A,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle16c6C757DHelveticalNenu400 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c6C757D,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle16c0A0A0AArial400 = TextStyle(
    fontFamily: _fontFamilyArial,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c0A0A0A,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle14c6A7282Arial400 = TextStyle(
    fontFamily: _fontFamilyArial,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c6A7282,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle24c99A1AFDHelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c99A1AF,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle20c101828HelveticalNenu400 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c101828,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle24c101828HelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c101828,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle14c364153HelveticalNenu400 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c364153,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle16c4A90E2HelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c4A90E2,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle12c99A1AFHelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c99A1AF,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle24cD1D5DCHelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cD1D5DC,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle14c009966HelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c009966,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle14c99A1AFHelveticalNenu400 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c99A1AF,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle18cFFFFFFHelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle16c3880F2HelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c3880F2,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle18c101828HelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c101828,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle30c3880F2HelveticalNenu700 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c3880F2,
    fontSize: 30.sp,
    fontWeight: FontWeight.w700,
  );
  static final textstyle12c4A90E2HelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c4A90E2,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle20c4A90E2HelveticalNenu700 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c4A90E2,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );
  static final textstyle14c6A7282HelveticalNenu500 = TextStyle(
    fontFamily: _fontFamilyHelveticaNeue,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c6A7282,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle28cFFFFFFManrope700 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
  );
  static final textstyle16c898996Manrope400 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c898996,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle14c626262Manrope500 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c626262,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle16c2F29FFManrope400 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c2F29FF,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle14c898996Manrope400 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c898996,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle20cFFFFFFManrope700 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );
  static final textstyle11cB8BBCCManrope400 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cB8BBCC,
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle20cFFFFFFManrope600 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );
  static final textstyle15c5465A6Manrope400 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c5465A6,
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
  );
  static final textstyle16cFFFFFFManrope500 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle16c5465A6Manrope500 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.c5465A6,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static final textstyle14cFFFFFFManrope500 = TextStyle(
    fontFamily: _fontFamilyManrope,
    fontFamilyFallback: _fontFamilyFallBackChakraPetch,
    color: AppColors.cFFFFFF,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
}

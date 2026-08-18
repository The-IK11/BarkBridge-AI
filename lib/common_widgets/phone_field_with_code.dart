import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

/// A phone-number input that prepends a country-code picker.
///
/// Usage
/// -----
/// ```dart
/// final _phoneKey  = GlobalKey<PhoneFieldWithCodeState>();
///
/// PhoneFieldWithCode(key: _phoneKey, initialFullPhone: '+880 1889254301')
///
/// // On submit:
/// final fullNumber = _phoneKey.currentState!.fullPhoneNumber; // "+880 1889254301"
/// ```
class PhoneFieldWithCode extends StatefulWidget {
  /// Pre-filled full phone number including dial code.
  /// Supports both "+880 1889254301" (space) and "+8801889254301" (no space).
  final String? initialFullPhone;

  /// Fill colour for the text field.
  final Color? fillColor;

  /// Border colour for the text field.
  final Color? borderColor;

  /// Border radius for the text field.
  final BorderRadius? radius;

  /// Optional validator for the number part (digits only).
  final String? Function(String?)? validator;

  const PhoneFieldWithCode({
    super.key,
    this.initialFullPhone,
    this.fillColor,
    this.borderColor,
    this.radius,
    this.validator,
  });

  @override
  State<PhoneFieldWithCode> createState() => PhoneFieldWithCodeState();
}

// ── Dial-code lookup helpers (file-level so they are built only once) ─────────

List<String>? _cachedSortedDialCodes;

/// Returns all known dial codes sorted longest-first for greedy prefix matching.
List<String> _getSortedDialCodes() {
  if (_cachedSortedDialCodes != null) return _cachedSortedDialCodes!;
  _cachedSortedDialCodes = _kAllDialCodes.toSet().toList()
    ..sort((a, b) => b.length.compareTo(a.length));
  return _cachedSortedDialCodes!;
}

/// Comprehensive list of ITU dial codes.
const List<String> _kAllDialCodes = [
  // 1-digit
  '+1', '+7',
  // 2-digit
  '+20', '+27', '+30', '+31', '+32', '+33', '+34', '+36', '+39', '+40',
  '+41', '+43', '+44', '+45', '+46', '+47', '+48', '+49', '+51', '+52',
  '+53', '+54', '+55', '+56', '+57', '+58', '+60', '+61', '+62', '+63',
  '+64', '+65', '+66', '+81', '+82', '+84', '+86', '+90', '+91', '+92',
  '+93', '+94', '+95', '+98',
  // 3-digit
  '+212', '+213', '+216', '+218', '+220', '+221', '+222', '+223', '+224',
  '+225', '+226', '+227', '+228', '+229', '+230', '+231', '+232', '+233',
  '+234', '+235', '+236', '+237', '+238', '+239', '+240', '+241', '+242',
  '+243', '+244', '+245', '+246', '+247', '+248', '+249', '+250', '+251',
  '+252', '+253', '+254', '+255', '+256', '+257', '+258', '+260', '+261',
  '+262', '+263', '+264', '+265', '+266', '+267', '+268', '+269', '+290',
  '+291', '+297', '+298', '+299', '+350', '+351', '+352', '+353', '+354',
  '+355', '+356', '+357', '+358', '+359', '+370', '+371', '+372', '+373',
  '+374', '+375', '+376', '+377', '+378', '+380', '+381', '+382', '+385',
  '+386', '+387', '+389', '+420', '+421', '+423', '+500', '+501', '+502',
  '+503', '+504', '+505', '+506', '+507', '+508', '+509', '+590', '+591',
  '+592', '+593', '+594', '+595', '+596', '+597', '+598', '+599', '+670',
  '+672', '+673', '+674', '+675', '+676', '+677', '+678', '+679', '+680',
  '+681', '+682', '+683', '+685', '+686', '+687', '+688', '+689', '+690',
  '+691', '+692', '+850', '+852', '+853', '+855', '+856', '+880', '+886',
  '+960', '+961', '+962', '+963', '+964', '+965', '+966', '+967', '+968',
  '+970', '+971', '+972', '+973', '+974', '+975', '+976', '+977', '+992',
  '+993', '+994', '+995', '+996', '+998',
  // 4-digit (North American regional codes under +1)
  '+1242', '+1246', '+1264', '+1268', '+1284', '+1340', '+1345', '+1441',
  '+1473', '+1649', '+1664', '+1670', '+1671', '+1684', '+1721', '+1758',
  '+1767', '+1784', '+1787', '+1809', '+1868', '+1869', '+1876', '+1939',
];

// ── Widget state ──────────────────────────────────────────────────────────────

class PhoneFieldWithCodeState extends State<PhoneFieldWithCode> {
  late TextEditingController _numberController;
  String _dialCode = '+1'; // default

  // ── Public API ──────────────────────────────────────────────────────────────

  /// Returns the merged phone string, e.g. "+880 1889254301".
  String get fullPhoneNumber {
    final number = _numberController.text.trim();
    if (number.isEmpty) return '';
    return '$_dialCode $number';
  }

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    final split = _splitPhone(widget.initialFullPhone);
    _dialCode = split.$1;
    _numberController = TextEditingController(text: split.$2);
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  /// Splits a stored phone number into (dialCode, localNumber).
  ///
  /// Handles both:
  ///   - "+880 1889254301"  → ("+880", "1889254301")   [space-separated]
  ///   - "+8801889254301"   → ("+880", "1889254301")   [no space — API format]
  (String, String) _splitPhone(String? full) {
    if (full == null || full.trim().isEmpty) return ('+1', '');
    final trimmed = full.trim();
    if (!trimmed.startsWith('+')) return ('+1', trimmed);

    // 1️⃣ Space-separated format
    final spaceIdx = trimmed.indexOf(' ');
    if (spaceIdx != -1) {
      final code = trimmed.substring(0, spaceIdx);
      final number = trimmed.substring(spaceIdx + 1);
      return (code, number);
    }

    // 2️⃣ No-space format: greedy match from longest dial code first
    for (final code in _getSortedDialCodes()) {
      if (trimmed.startsWith(code) && trimmed.length > code.length) {
        return (code, trimmed.substring(code.length));
      }
    }

    // Fallback: treat whole string as number under +1
    return ('+1', trimmed.replaceFirst('+', ''));
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        widget.radius ?? BorderRadius.all(Radius.circular(16.r));
    final borderColor =
        widget.borderColor ?? const Color.fromARGB(105, 141, 141, 144);
    final outlineBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: borderColor, width: 1.w),
    );

    return Container(
      constraints: BoxConstraints(minHeight: 54.h),
      decoration: BoxDecoration(
        color: widget.fillColor ?? AppColors.cFFFFFF.withAlpha(8),
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, width: 1.w),
      ),
      child: Row(
        children: [
          // ── Country-code picker ────────────────────────────────────────────
          Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: const Color(0xFF1D2031),
              dialogTheme: DialogThemeData(
                backgroundColor: const Color(0xFF1D2031),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
            ),
            child: CountryCodePicker(
              initialSelection: _dialCode,
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
              favorite: const ['+1', '+44', '+880'],
              // ── Closed-state label ────────────────────────────────────────────
              textStyle: TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
                fontSize: 14.sp,
                color: AppColors.cB8B8C3,
              ),
              // ── Dialog dark theme ─────────────────────────────────────────────
              barrierColor: Colors.black.withValues(alpha: 0.7),
              boxDecoration: BoxDecoration(
                color: const Color(0xFF1D2031),
                borderRadius: BorderRadius.circular(16.r),
              ),
              dialogBackgroundColor: const Color(0xFF1D2031),
              dialogTextStyle:
                  TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
                fontSize: 14.sp,
                color: Colors.white,
              ),
              searchStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
              searchDecoration: InputDecoration(
                hintText: 'Search country',
                hintStyle: TextStyle(color: Colors.white38, fontSize: 14.sp),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
              closeIcon: const Icon(Icons.close, color: Colors.white70),
              padding: EdgeInsets.zero,
              onChanged: (code) {
                setState(() => _dialCode = code.dialCode ?? _dialCode);
              },
            ),
          ),

          // ── Vertical divider ───────────────────────────────────────────────
          Container(
            width: 1.w,
            height: 28.h,
            color: borderColor,
          ),
          SizedBox(width: 8.w),

          // ── Number text field ──────────────────────────────────────────────
          Expanded(
            child: TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.phone,
              cursorColor: Colors.white,
              style: TextFontStyle.textStylec14c02505FChakraPetch700.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.cB8B8C3,
              ),
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: 'Phone number',
                hintStyle: TextFontStyle.textStylec14c02505FChakraPetch700
                    .copyWith(color: AppColors.cB8B8C3),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: outlineBorder,
                focusedErrorBorder: outlineBorder,
                errorStyle: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  height: 1,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                isDense: true,
              ),
            ),
          ),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }
}

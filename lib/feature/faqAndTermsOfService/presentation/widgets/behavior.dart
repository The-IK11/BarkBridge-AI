import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';

class Behavior extends StatelessWidget {
  const Behavior({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        settingContent("What is Bark Bridge?"),
        dividerLine(),
        settingContent("Why does Bark Bridge need video?"),
        dividerLine(),
        settingContent("When should I use Bark Bridge?"),
        dividerLine(),
        settingContent("What can Bridge tell me about my dog?"),
        dividerLine(),
      ],
    );
  }

  Widget settingContent(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(title, style: TextFontStyle.textstyle16cFFFFFFManrope500),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 20.sp,
        color: AppColors.c5465A6,
      ),
    );
  }

  Widget dividerLine() {
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

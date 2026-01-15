import 'package:flutter/material.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class CustomAddressField extends StatelessWidget {
  final String title;
  const CustomAddressField({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextFontStyle.textStyle16c121212OpenSans400,
        filled: true,
        fillColor: AppColors.cF5F1EB,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),

        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}

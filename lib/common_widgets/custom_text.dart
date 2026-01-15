import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final int? maxLetters;
  final int? maxLines;
  final TextStyle? style;
  final TextOverflow? overflow;
  final bool showEllipsis;
  final bool withCurrency;
  final TextAlign? textAlign;

  const CustomText(
    this.text, {
    super.key,
    this.maxLetters,
    this.maxLines,
    this.style,
    this.overflow,
    this.showEllipsis = false,
    this.withCurrency = false,
    this.textAlign,
  });
  final String currencySymboil = '\$';
  @override
  Widget build(BuildContext context) {
    String displayText = text ?? 'No Data';

    if (maxLetters != null && displayText.length > maxLetters!) {
      displayText = displayText.substring(0, maxLetters!);
      if (showEllipsis) {
        displayText += '...';
      }
    }

    return Text(
      withCurrency ? '$currencySymboil$displayText' : displayText,
      style: style ?? const TextStyle(fontSize: 14),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}

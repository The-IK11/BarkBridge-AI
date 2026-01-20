import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';

class AccordionItem extends StatefulWidget {
  final String title;
  final String? content;
  final bool isExpanded;

  const AccordionItem({
    super.key,
    required this.title,
    this.content,
    this.isExpanded = false,
  });

  @override
  State<AccordionItem> createState() => _AccordionItemState();
}

class _AccordionItemState extends State<AccordionItem> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          // Removes the default borders/dividers of ExpansionTile
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: _isOpen,
            onExpansionChanged: (value) => setState(() => _isOpen = value),
            tilePadding: EdgeInsets.zero,
            // The Header Text
            title: Text(
              widget.title,
              style: TextFontStyle.textstyle16cFFFFFFManrope500,
            ),
            // Custom Arrow Logic (Down for open, Forward for closed)
            trailing: Icon(
              _isOpen ? Icons.keyboard_arrow_down : Icons.arrow_forward_ios,
              size: 20.sp,
              color: AppColors.c5465A6,
            ),
            children: [
              if (widget.content != null)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 15.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    // Dark bluish-grey background as seen in image
                    color: const Color(0xFF141A2B),
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Text(
                    widget.content!,
                    style: TextFontStyle.textstyle14cFFFFFFManrope500.copyWith(
                      color: const Color(0xFFB8BBCC), // Dimmed text color
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

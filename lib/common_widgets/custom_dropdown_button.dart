import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String> items;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? categoryImage;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final TextStyle? itemStyle;
  final String? selectedValue; // Added selectedValue property

  CustomDropDownButton({
    super.key,
    required List<String> items,
    required this.onChanged,
    this.hintText,
    this.hintStyle,
    this.categoryImage,
    this.validator,
    this.itemStyle,
    this.selectedValue, // Initialize selectedValue
  }) : items = items.toSet().toList(); // Ensure unique items

  @override
  CustomDropDownButtonState createState() => CustomDropDownButtonState();
}

class CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator, // Use the validator
        builder: (FormFieldState<String> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  iconStyleData: IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 22.sp,
                      color: AppColors.c121212,
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    widget.hintText ?? 'Select an option',
                    style:
                        widget.hintStyle ??
                        TextFontStyle.textStyle16c121212OpenSans400,
                  ),
                  items: widget.items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style:
                            widget.itemStyle ??
                            const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  value: widget.items.contains(widget.selectedValue)
                      ? widget.selectedValue
                      : null,
                  onChanged: (String? newValue) {
                    widget.onChanged(newValue);
                    setState(() {});
                  },
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 54.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: AppColors.cF5F1EB,
                      borderRadius: BorderRadius.circular(32.r),
                      // border: Border.all(color: const Color(0xFFDADADA)),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(height: 40.h),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 250.h,
                    decoration: BoxDecoration(
                      color: AppColors.cF5F1EB,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    offset: const Offset(0, 5),
                    elevation: 2,
                  ),
                ),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    state.errorText!,
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

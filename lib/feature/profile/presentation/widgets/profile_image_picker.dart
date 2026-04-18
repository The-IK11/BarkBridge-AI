import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/helpers/ui_helpers.dart';

class ProfileImagePicker {
  final ImagePicker _picker = ImagePicker();

  /// Shows modal bottom sheet with gallery and camera options
  Future<File?> showImageSourceSheet(BuildContext context) async {
    return showModalBottomSheet<File?>(
      backgroundColor: Color.fromARGB(255, 22, 45, 119),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo, color: Colors.grey),
              title: Text(
                "Upload from Gallery",
                style: TextFontStyle.textStyle14cFFFFFFOpenSans400,
              ),
              onTap: () async {
                final file = await _pickImage(ImageSource.gallery);
                if (context.mounted) {
                  Navigator.pop(context, file);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.grey),
              title: Text(
                "Upload from Camera",
                style: TextFontStyle.textStyle14cFFFFFFOpenSans400,
              ),
              onTap: () async {
                final file = await _pickImage(ImageSource.camera);
                if (context.mounted) {
                  Navigator.pop(context, file);
                }
              },
            ),
            UIHelper.verticalSpace(70.h),
          ],
        ),
      ),
    );
  }

  /// Picks image from specified source
  Future<File?> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return null;
  }
}

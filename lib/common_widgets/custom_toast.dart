// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../gen/colors.gen.dart';

SnackbarController customToastMessage(String title, String description) {
  return Get.snackbar(
    title,
    description,
    snackPosition: SnackPosition.TOP,
    backgroundColor: const Color.fromARGB(255, 38, 51, 100),
    colorText: AppColors.cFFFFFF,
  );
}

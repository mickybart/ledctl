import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbarError(String title, String error) {
  Get.snackbar(
    title,
    error,
    icon: const Icon(Icons.error),
    isDismissible: true,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 5),
  );
}

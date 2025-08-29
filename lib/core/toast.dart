import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSnack(String title, String message) {
  Get.showSnackbar(
    GetSnackBar(
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM, // or TOP if you prefer
      borderRadius: 16,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24), // lifts above home bar
      backgroundColor: const Color(0xFFB3261E), // solid red for contrast
      duration: const Duration(seconds: 3),
      isDismissible: true,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
    ),
  );
}

void showOkSnack(String title, String message) {
  Get.showSnackbar(
    GetSnackBar(
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 16,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      backgroundColor: const Color(0xFF2E7D32), // green
      duration: const Duration(seconds: 2),
      isDismissible: true,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
    ),
  );
}

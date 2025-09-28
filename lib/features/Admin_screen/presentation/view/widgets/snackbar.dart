import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarScreen {
  static void showSuccess(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      snackPosition: SnackPosition.TOP,
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

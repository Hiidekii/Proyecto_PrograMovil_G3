import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorSnackbar {
  static final ErrorSnackbar _instance = ErrorSnackbar._internal();

  ErrorSnackbar._internal();

  factory ErrorSnackbar() {
    return _instance;
  }

  void showError(String error) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.snackbar(
      "Error",
      error,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }
}

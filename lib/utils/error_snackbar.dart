import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorSnackBar {
  static SnackbarController show(String message, String type) {
    return GetSnackBar(
      margin: const EdgeInsets.all(8),
      title: type == 'error' ? 'Error' : 'Success',
      message: message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: type == 'error' ? Colors.red : Colors.green,
      isDismissible: true,
      icon: type == 'error'
          ? const Icon(Icons.error, color: Colors.white)
          : const Icon(Icons.check, color: Colors.white),
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
    ).show();
  }
}

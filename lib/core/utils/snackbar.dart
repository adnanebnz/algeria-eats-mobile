import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowSnackBar {
  static SnackbarController show(String message, String type) {
    return GetSnackBar(
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
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

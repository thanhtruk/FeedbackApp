import 'package:feedback_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final username = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;

  final userAccounts = {
    'user': 'user123',
    'admin': 'admin123',
  };

  void login() {
    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      if (userAccounts[username.value] == password.value) {
        final role = username.value == 'admin' ? 'Admin' : 'User';
        // Navigate to the home page or dashboard
        if (role == 'User') {
          Get.toNamed(AppRoutes.HOME);
        } else {
          Get.toNamed(AppRoutes.ADMIN_DASHBOARD);
          // Get.offNamed('/home');
        }
      } else {
        Get.snackbar("Login Failed", "Invalid username or password",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    });
  }
}

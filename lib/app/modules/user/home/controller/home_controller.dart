import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable counter variable
  final counter = 0.obs;

  // Method to increment the counter
  void incrementCounter() {
    counter.value++;
  }

  @override
  void onInit() {
    super.onInit();
    print("✅ HomeController initialized");
    // Any initialization logic can go here
  }

  @override
  void onReady() {
    super.onReady();
    // Logic that needs to run after the controller is ready can go here
  }

  @override
  void onClose() {
    // Cleanup logic can go here if needed
    super.onClose();
  }
}
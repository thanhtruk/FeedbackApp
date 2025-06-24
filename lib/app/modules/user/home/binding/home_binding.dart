import 'package:feedback_app/app/modules/user/home/repository/home_repository.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeRepository>(() => HomeRepository());
  }
}

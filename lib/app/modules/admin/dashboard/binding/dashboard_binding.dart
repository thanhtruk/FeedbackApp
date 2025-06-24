import 'package:feedback_app/app/modules/admin/dashboard/repository/dashboard_repository.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<DashboardRepository>(() => DashboardRepository());
  }
}

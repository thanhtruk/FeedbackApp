import 'package:get/get.dart';

import '../modules/user/home/binding/home_binding.dart';
import '../modules/user/home/view/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = AppRoutes.HOME;

  static final routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    // Add other routes here as needed
  ];
}


import 'package:feedback_app/app/modules/admin/dashboard/binding/dashboard_binding.dart';
import 'package:feedback_app/app/modules/admin/dashboard/view/dashboard_view.dart';
import 'package:feedback_app/app/modules/login/binding/login_binding.dart';
import 'package:get/get.dart';

import '../modules/login/view/login_view.dart';
import '../modules/user/feedback_detail/binding/feedback_detail_binding.dart';
import '../modules/user/feedback_detail/view/feedback_detail_view.dart';
import '../modules/user/feedback_form/binding/feedback_form_binding.dart';
import '../modules/user/feedback_form/view/feedback_form_view.dart';
import '../modules/user/home/binding/home_binding.dart';
import '../modules/user/home/view/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = AppRoutes.LOGIN;

  static final routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.FEEDBACK_DETAIL,
      page: () => const FeedbackDetailView(),
      binding: FeedbackDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.FEEDBACK_FORM,
      page: () => FeedbackFormView(),
      binding: FeedbackFormBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.ADMIN_DASHBOARD,
      page: () => DashboardView(), // Placeholder for admin dashboard
      binding: DashboardBinding(), // Assuming the same binding as home
    ),
  ];
}

import 'package:get/get.dart';

import '../modules/user/feedback_detail/binding/feedback_detail_binding.dart';
import '../modules/user/feedback_detail/view/feedback_detail_view.dart';
import '../modules/user/feedback_form/binding/feedback_form_binding.dart';
import '../modules/user/feedback_form/view/feedback_form_view.dart';
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
    // Add other routes here as needed
  ];
}

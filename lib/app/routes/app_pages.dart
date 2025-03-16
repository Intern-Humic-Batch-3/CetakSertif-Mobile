import 'package:get/get.dart';

import '../modules/AdminPage/bindings/admin_page_binding.dart';
import '../modules/AdminPage/views/admin_page_view.dart';
import '../modules/HomePage/bindings/home_page_binding.dart';
import '../modules/HomePage/views/home_page_view.dart';
import '../modules/LoginPage/bindings/login_page_binding.dart';
import '../modules/LoginPage/views/login_page_view.dart';
import '../modules/inputPage/bindings/input_page_binding.dart';
import '../modules/inputPage/views/input_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.INPUT_PAGE,
      page: () => const InputPageView(),
      binding: InputPageBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PAGE,
      page: () => const AdminPageView(),
      binding: AdminPageBinding(),
    ),
  ];
}

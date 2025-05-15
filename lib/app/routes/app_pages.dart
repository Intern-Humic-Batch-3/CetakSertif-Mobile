import 'package:get/get.dart';
import 'package:humic_mobile/app/modules/SuperAdmin/AdminPage/bindings/admin_page_binding.dart';
import 'package:humic_mobile/app/modules/SuperAdmin/AdminPage/views/admin_page_view.dart';
import 'package:humic_mobile/app/modules/SuperAdmin/DaftarUserPage/bindings/daftar_user_page_binding.dart';
import 'package:humic_mobile/app/modules/SuperAdmin/DaftarUserPage/views/daftar_user_page_view.dart';
import '../modules/HomePage/bindings/home_page_binding.dart';
import '../modules/HomePage/views/home_page_view.dart';
import '../modules/LoginPage/bindings/login_page_binding.dart';
import '../modules/LoginPage/views/login_page_view.dart';
import '../modules/hasil_pengguna/bindings/hasil_pengguna_binding.dart';
import '../modules/hasil_pengguna/views/hasil_pengguna_view.dart';
import '../modules/inputPage/bindings/input_page_binding.dart';
import '../modules/inputPage/views/input_page_view.dart';
import '../modules/template_humic/bindings/template_humic_binding.dart';
import '../modules/template_humic/views/template_humic_view.dart';
import '../modules/result_page/bindings/result_page_binding.dart';
import '../modules/result_page/views/result_page_view.dart';

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
    GetPage(
      name: _Paths.TEMPLATE_HUMIC,
      page: () => const TemplateHumicView(),
      binding: TemplateHumicBinding(),
    ),
    GetPage(
      name: _Paths.HASIL_PENGGUNA,
      page: () => const HasilPenggunaView(),
      binding: HasilPenggunaBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_USER_PAGE,
      page: () => const DaftarUserView(),
      binding: DaftarUserPageBinding(),
    ),
    GetPage(
      name: _Paths.RESULT_PAGE,
      page: () => const ResultPageView(),
      binding: ResultPageBinding(),
    ),
  ];
}

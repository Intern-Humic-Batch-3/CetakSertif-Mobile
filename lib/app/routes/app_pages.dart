import 'package:get/get.dart';
import 'package:humic_mobile/app/modules/SuperAdmin/AdminPage/bindings/admin_page_binding.dart';
import 'package:humic_mobile/app/modules/SuperAdmin/AdminPage/views/admin_page_view.dart';
import 'package:humic_mobile/app/modules/SuperAdmin/DaftarUserPage/bindings/daftar_user_page_binding.dart';
import 'package:humic_mobile/app/modules/SuperAdmin/DaftarUserPage/views/daftar_user_page_view.dart';
import '../modules/LoginPage/bindings/login_page_binding.dart';
import '../modules/LoginPage/views/login_page_view.dart';
import '../modules/inputPage/bindings/input_page_binding.dart';
import '../modules/inputPage/views/input_page_view.dart';
import '../modules/template_humic/bindings/template_humic_binding.dart';
import '../modules/template_humic/views/template_humic_view.dart';
import '../modules/result_page/bindings/result_page_binding.dart';
import '../modules/result_page/views/result_page_view.dart';
import '../modules/certificate_preview/bindings/certificate_preview_binding.dart';
import '../modules/certificate_preview/views/certificate_preview_view.dart';

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
      name: _Paths.DAFTAR_USER_PAGE,
      page: () => const DaftarUserView(),
      binding: DaftarUserPageBinding(),
    ),
    GetPage(
      name: _Paths.RESULT_PAGE,
      page: () => const ResultPageView(),
      binding: ResultPageBinding(),
    ),
    GetPage(
      name: _Paths.CERTIFICATE_PREVIEW,
      page: () => const CertificatePreviewView(),
      binding: CertificatePreviewBinding(),
    ),
  ];
}

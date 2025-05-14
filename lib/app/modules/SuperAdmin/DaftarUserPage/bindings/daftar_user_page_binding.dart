import 'package:get/get.dart';
import 'package:humic_mobile/app/modules/SuperAdmin/DaftarUserPage/controllers/daftar_user_page_controller.dart';

class DaftarUserPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarUserController>(
      () => DaftarUserController(),
    );
  }
}

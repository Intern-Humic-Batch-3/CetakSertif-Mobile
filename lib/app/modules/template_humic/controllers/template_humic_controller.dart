import 'package:get/get.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';

class TemplateHumicController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void Gunakan({int templateIndex = 1}) {
    // Kirim parameter template yang dipilih ke halaman berikutnya
    Get.toNamed(Routes.INPUT_PAGE, arguments: {'templateIndex': templateIndex});
  }
}

void kembali() {
  Get.offNamed(Routes.ADMIN_PAGE);
}

import 'package:get/get.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';

class TemplateHumicController extends GetxController {
  //TODO: Implement TemplateHumicController

  final count = 0.obs;
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

  void increment() => count.value++;

  void Gunakan() {
    Get.offNamed(Routes.INPUT_PAGE);
  }

  void kembali() {
    Get.offNamed(Routes.ADMIN_PAGE);
  }
}

import 'dart:io';
import 'package:get/get.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';

class TemplateHumicController extends GetxController {
  // Tambahkan variabel reaktif untuk menyimpan template yang dipilih
  final selectedTemplateIndex = 0.obs;

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

  void Gunakan({required int templateIndex, String excelFilePath = ''}) {
    selectedTemplateIndex.value = templateIndex;
    print("Template terpilih: $templateIndex");

    String emptyTemplatePath = '';

    switch (templateIndex) {
      case 1:
        emptyTemplatePath = 'assets/images/sertif-kosong-1.png';
        break;
      case 2:
        emptyTemplatePath = 'assets/images/sertif-kosong-2.png';
        break;
      case 3:
        emptyTemplatePath = 'assets/images/sertif-kosong-3.png';
        break;
      default:
        emptyTemplatePath = 'assets/images/sertif-kosong-2.png';
    }

    print("Path template kosong: $emptyTemplatePath");

    Get.toNamed(Routes.INPUT_PAGE, arguments: {
      'templateIndex': templateIndex,
      'emptyTemplatePath': emptyTemplatePath
    });
  }
}

void kembali() {
  Get.offNamed(Routes.ADMIN_PAGE);
}

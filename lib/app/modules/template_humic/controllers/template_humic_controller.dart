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
    // Simpan template yang dipilih
    selectedTemplateIndex.value = templateIndex;

    // Tentukan template kosong yang sesuai berdasarkan template yang dipilih
    String emptyTemplatePath = '';

    switch (templateIndex) {
      case 1:
        emptyTemplatePath = 'assets/images/sertif-kosong-1.png';
        break;
      case 2:
        emptyTemplatePath = 'assets/images/sertif-kosong-2.png';
        break;
      default:
        emptyTemplatePath = 'assets/images/sertif-kosong-1.png';
    }

    // Navigasi ke halaman input dengan membawa informasi template yang dipilih
    Get.toNamed(Routes.INPUT_PAGE, arguments: {
      'templateIndex': templateIndex,
      'emptyTemplatePath': emptyTemplatePath
    });
  }
}

void kembali() {
  Get.offNamed(Routes.ADMIN_PAGE);
}

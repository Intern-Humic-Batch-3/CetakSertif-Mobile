import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';

class InputPageController extends GetxController {
  final selectedExcelFileName = ''.obs;
  final selectedExcelFilePath = ''.obs;
  final tanggalMulai = Rxn<DateTime>();
  final tanggalBerakhir = Rxn<DateTime>();
  final selectedTTD1FileName = ''.obs;
  final selectedTTD2FileName = ''.obs;
  final selectedTTD3FileName = ''.obs;

  // Tambahkan controller untuk nama kegiatan
  final namaKegiatanController = TextEditingController();

  @override
  void onClose() {
    // Dispose controller untuk mencegah memory leak
    namaKegiatanController.dispose();
    super.onClose();
  }

  Future<void> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      selectedExcelFileName.value = result.files.single.name;
      selectedExcelFilePath.value = result.files.single.path!;
    }
  }

  void navigateToTemplateSelection() {
    if (selectedExcelFilePath.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Silakan pilih file Excel terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Tambahkan pengecekan untuk memastikan semua data yang diperlukan tersedia
    if (namaKegiatanController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Silakan isi nama kegiatan terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.toNamed(Routes.TEMPLATE_HUMIC, arguments: {
      'excelFilePath': selectedExcelFilePath.value,
    });
  }

  void navigateToResultPage() {
    if (selectedExcelFilePath.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Silakan pilih file Excel terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Ambil argumen dari halaman sebelumnya
    final args = Get.arguments;
    final templateIndex = args?['templateIndex'] ?? 1;
    final emptyTemplatePath =
        args?['emptyTemplatePath'] ?? 'assets/images/sertif-kosong-1.png';
    final categoryIndex = args?['categoryIndex'] ?? templateIndex;

    print(
        "Navigasi ke Result Page dengan template: $templateIndex, path: $emptyTemplatePath, category: $categoryIndex");

    // Teruskan ke halaman result
    Get.toNamed(Routes.RESULT_PAGE, arguments: {
      'excelFilePath': selectedExcelFilePath.value,
      'templateIndex': templateIndex,
      'emptyTemplatePath': emptyTemplatePath,
      'categoryIndex': categoryIndex
    });
  }
}

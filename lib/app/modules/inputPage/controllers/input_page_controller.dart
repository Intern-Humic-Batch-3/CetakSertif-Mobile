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

    Get.toNamed(Routes.TEMPLATE_HUMIC, arguments: {
      'excelFilePath': selectedExcelFilePath.value,
    });
  }
}

import 'package:get/get.dart';

class InputPageController extends GetxController {
  //TODO: Implement InputPageController

  RxString selectedExcelFileName = ''.obs;
  RxString selectedTTD1FileName = ''.obs;
  RxString selectedTTD2FileName = ''.obs;
  RxString selectedTTD3FileName = ''.obs;

  // Untuk tanggal (jika mau reactive juga)
  final RxString tanggalMulai = ''.obs;
  final RxString tanggalBerakhir = ''.obs;

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
}

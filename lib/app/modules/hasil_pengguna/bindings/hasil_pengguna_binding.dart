import 'package:get/get.dart';

import '../controllers/hasil_pengguna_controller.dart';

class HasilPenggunaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HasilPenggunaController>(
      () => HasilPenggunaController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/template_humic_controller.dart';

class TemplateHumicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TemplateHumicController>(
      () => TemplateHumicController(),
    );
  }
}

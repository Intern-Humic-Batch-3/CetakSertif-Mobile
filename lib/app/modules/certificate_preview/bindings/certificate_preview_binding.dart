import 'package:get/get.dart';
import '../controllers/certificate_preview_controller.dart';

class CertificatePreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CertificatePreviewController>(
      () => CertificatePreviewController(),
    );
  }
}

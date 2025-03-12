import 'package:get/get.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';

class LoginPageController extends GetxController {
  //TODO: Implement LoginPageController

  final count = 0.obs;
  final isPasswordHidden = true.obs;

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

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() {
    // Add your login logic here
    // For now, we'll just navigate to home page
    Get.offAllNamed(
        Routes.HOME_PAGE); // Using offAllNamed to remove previous routes
  }
}

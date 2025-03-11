import 'package:get/get.dart';

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
    // Implement login logic here
  }
}

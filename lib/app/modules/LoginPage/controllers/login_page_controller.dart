import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/data/config/api_config.dart';
import 'package:humic_mobile/app/data/controllers/user_controllers.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageController extends GetxController {
  final isPasswordHidden = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final String loginUrl = ApiConfig.loginUrl;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Fungsi login
  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Email dan Password tidak boleh kosong",
        backgroundColor: AppColors.error,
        colorText: AppColors.putih,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      // respons di log
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      // Cek status code untuk autentikasi gagal (401, 403, dll)
      if (response.statusCode == 401 || response.statusCode == 403) {
        Get.snackbar(
          "Login Gagal",
          "Email atau password yang Anda masukkan salah",
          backgroundColor: AppColors.error,
          colorText: AppColors.putih,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      // login berhasil
      if (response.statusCode == 200) {
        try {
          var responseData = json.decode(response.body);
          var token = responseData['token'];

          // Simpan token di SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);

          // Perbarui data user
          final userController = Get.find<UserController>();
          await userController.getUserData();

          // Tampilkan snackbar login berhasil
          Get.snackbar(
            "Login Berhasil",
            "Selamat datang kembali!",
            backgroundColor: AppColors.success,
            colorText: AppColors.putih,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(10),
            borderRadius: 8,
            duration: const Duration(seconds: 2),
          );

          // Navigasi ke halaman berikutnya
          Get.offAllNamed(Routes.ADMIN_PAGE);
        } catch (parseError) {
          print("Error parsing response: $parseError");
          Get.snackbar(
            "Error",
            "Terjadi kesalahan saat memproses respons server",
            backgroundColor: AppColors.error,
            colorText: AppColors.putih,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(10),
            borderRadius: 8,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        Get.snackbar(
          "Login Gagal",
          "Terjadi kesalahan pada server. Silakan coba lagi nanti.",
          backgroundColor: AppColors.error,
          colorText: AppColors.putih,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar(
        "Error",
        "Koneksi gagal, silakan periksa internet Anda dan coba lagi",
        backgroundColor: AppColors.error,
        colorText: AppColors.putih,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

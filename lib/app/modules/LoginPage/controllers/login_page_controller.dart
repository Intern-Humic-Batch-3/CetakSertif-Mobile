import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:humic_mobile/app/data/controllers/user_controllers.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageController extends GetxController {
  final isPasswordHidden = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // URL endpoint login backend
  final String loginUrl =
      'http://192.168.18.4:4000/api-auth/post/login'; // Gantilah sesuai dengan alamat backend Anda

  // Fungsi untuk toggle visibilitas password
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Fungsi login yang akan dipanggil saat tombol login ditekan
  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    // Pastikan email dan password tidak kosong
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan Password tidak boleh kosong");
      return;
    }

    // Menyiapkan data JSON untuk request
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

      // Menampilkan respons di log
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      // Di dalam fungsi login setelah login berhasil
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        var token = responseData['token']; // Ambil token JWT dari response

        // Simpan token di SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        // Perbarui data user
        final userController = Get.find<UserController>();
        await userController.getUserData();

        // Navigasi ke halaman berikutnya
        Get.offAllNamed(Routes.ADMIN_PAGE);
      } else {
        Get.snackbar("Login Failed", "Email atau password salah");
      }
    } catch (e) {
      // Menampilkan pesan error lebih rinci
      print("Error: $e");
      Get.snackbar("Error", "Terjadi masalah, coba lagi");
    }
  }

  @override
  void onClose() {
    // Jangan lupa untuk membersihkan controller saat halaman ditutup
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

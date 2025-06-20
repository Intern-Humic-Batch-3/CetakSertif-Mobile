import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:humic_mobile/app/data/config/api_config.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';

class UserController extends GetxController {
  final userName = ''.obs;
  final userEmail = ''.obs;
  final isAdmin = false.obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  // Fungsi mengambil data pengguna
  Future<void> getUserData() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(ApiConfig.getMeUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        userName.value = data['data'][0]['nama_depan'] +
            ' ' +
            data['data'][0]['nama_belakang'];
        userEmail.value = data['data'][0]['email'];

        isAdmin.value = data['data'][0]['role'] == 'admin';

        print(
            "Data user berhasil diambil: ${userName.value}, ${userEmail.value}, Admin: ${isAdmin.value}");
      } else {
        Get.snackbar("Error", "Gagal mengambil data pengguna");
        print("Gagal mengambil data: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk logout
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    // Reset data user
    userName.value = '';
    userEmail.value = '';
    isAdmin.value = false;

    // Tampilkan snackbar logout berhasil
    Get.snackbar(
      "Logout Berhasil",
      "Anda telah keluar dari aplikasi",
      backgroundColor: AppColors.info,
      colorText: AppColors.putih,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );

    // Navigasi ke halaman login
    Get.offAllNamed(Routes.LOGIN_PAGE);
  }
}

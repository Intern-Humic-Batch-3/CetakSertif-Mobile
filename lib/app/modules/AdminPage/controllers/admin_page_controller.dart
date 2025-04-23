import 'package:get/get.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminPageController extends GetxController {
  String userName = '';
  String userEmail = '';

  @override
  void onInit() {
    super.onInit();
    _getUserData();
  }

  // Fungsi untuk mengambil data pengguna dari endpoint /get/me
  void _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =
        prefs.getString('token'); // Ambil token dari SharedPreferences

    if (token == null) {
      Get.snackbar("Error", "Token tidak ditemukan");
      return;
    }

    // Panggil API untuk mendapatkan data pengguna
    final response = await http.get(
      Uri.parse('http://192.168.18.4:4000/api-auth/get/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token', // Menambahkan token ke header Authorization
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      userName = data['data'][0]['nama_depan'] +
          ' ' +
          data['data'][0]['nama_belakang']; // Ambil nama lengkap
      userEmail = data['data'][0]['email']; // Ambil email pengguna
      update(); // Perbarui UI
    } else {
      Get.snackbar("Error", "Gagal mengambil data pengguna");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void Tambah() {
    Get.offNamed(Routes.HOME_PAGE);
  }
}

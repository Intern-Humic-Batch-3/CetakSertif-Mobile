import 'package:get/get.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminPageController extends GetxController {
  // Ubah menjadi variabel reaktif
  final userName = ''.obs;
  final userEmail = ''.obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _getUserData();
  }

  // Fungsi untuk mengambil data pengguna dari endpoint /get/me
  void _getUserData() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =
        prefs.getString('token'); // Ambil token dari SharedPreferences

    if (token == null) {
      Get.snackbar("Error", "Token tidak ditemukan");
      isLoading.value = false;
      return;
    }

    // Panggil API untuk mendapatkan data pengguna
    final response = await http.get(
      Uri.parse('http://192.168.56.1:4000/api-auth/get/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token', // Menambahkan token ke header Authorization
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      userName.value = data['data'][0]['nama_depan'] +
          ' ' +
          data['data'][0]['nama_belakang']; // Ambil nama lengkap
      userEmail.value = data['data'][0]['email']; // Ambil email pengguna
    } else {
      Get.snackbar("Error", "Gagal mengambil data pengguna");
    }
    isLoading.value = false;
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
    Get.offNamed(Routes.TEMPLATE_HUMIC);
  }
}

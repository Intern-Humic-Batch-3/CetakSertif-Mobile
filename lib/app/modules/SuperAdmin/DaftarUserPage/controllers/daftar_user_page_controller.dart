import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DaftarUserController extends GetxController {
  var userList = [].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var searchQuery = ''.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers({int page = 1}) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Menggunakan endpoint yang benar sesuai dengan routes di backend
      final response = await http.get(
        Uri.parse('http://192.168.56.1:4000/api-user/get/allUser'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        // Menyesuaikan dengan format respons dari backend
        if (responseData['massage'] == "menampilkan semua akun") {
          userList.value = responseData['data'] ?? [];

          // Karena API tidak menyediakan pagination, kita set nilai default
          totalPages.value = 1;
          currentPage.value = 1;
        } else {
          errorMessage.value = 'Format respons tidak sesuai';
          Get.snackbar("Error", "Format respons tidak sesuai");
        }
      } else {
        errorMessage.value = 'Gagal mengambil data pengguna';
        Get.snackbar(
            "Error", "Gagal mengambil data pengguna: ${response.statusCode}");
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      fetchUsers(page: currentPage.value + 1);
    }
  }

  void prevPage() {
    if (currentPage.value > 1) {
      fetchUsers(page: currentPage.value - 1);
    }
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages.value) {
      fetchUsers(page: page);
    }
  }

  void searchUsers(String query) {
    searchQuery.value = query;
    // Karena API tidak mendukung pencarian, kita bisa melakukan filter lokal
    fetchUsers(page: 1);
  }

  void tambahUser() {
    // Implementasi untuk menambah user baru
    Get.toNamed('/tambah-user');
  }
}

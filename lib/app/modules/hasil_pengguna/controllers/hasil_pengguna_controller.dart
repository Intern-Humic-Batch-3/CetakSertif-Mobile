import 'package:get/get.dart';

class HasilPenggunaController extends GetxController {
  final RxList<Map<String, dynamic>> certificates =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Simulasi data sertifikat
    loadCertificates();
  }

  @override
  void onReady() {
    super.onReady();
    // Tambahkan kode yang perlu dijalankan setelah widget dirender
  }

  @override
  void onClose() {
    super.onClose();
    // Tambahkan kode untuk membersihkan resource jika diperlukan
  }

  void loadCertificates() {
    // Simulasi data sertifikat
    // Nantinya bisa diganti dengan pemanggilan API
    certificates.assignAll([
      {
        'id': 1,
        'title': 'Workshop Humic Engineering',
        'image': 'assets/images/certificate_template_1.png',
        'date': '10 Januari 2023',
      },
      {
        'id': 2,
        'title': 'Workshop Humic Engineering',
        'image': 'assets/images/certificate_template_2.png',
        'date': '15 Februari 2023',
      },
      // Tambahkan data sertifikat lainnya untuk simulasi
      {
        'id': 3,
        'title': 'Workshop Humic Engineering',
        'image': 'assets/images/certificate_template_1.png',
        'date': '20 Maret 2023',
      },
      {
        'id': 4,
        'title': 'Workshop Humic Engineering',
        'image': 'assets/images/certificate_template_2.png',
        'date': '5 April 2023',
      },
      {
        'id': 5,
        'title': 'Workshop Humic Engineering',
        'image': 'assets/images/certificate_template_1.png',
        'date': '15 Mei 2023',
      },
      {
        'id': 6,
        'title': 'Workshop Humic Engineering',
        'image': 'assets/images/certificate_template_2.png',
        'date': '20 Juni 2023',
      },
      {
        'id': 7,
        'title': 'Workshop Humic Engineering',
        'image': 'assets/images/certificate_template_1.png',
        'date': '10 Juli 2023',
      },
      {
        'id': 8,
        'title': 'Workshop Humic Engineering',
        'image': 'assets/images/certificate_template_2.png',
        'date': '25 Agustus 2023',
      },
      {
        'id': 9,
        'title': 'Workshop Humic Engineering',
        'image': 'assets/images/certificate_template_1.png',
        'date': '5 September 2023',
      },
      {
        'id': 10,
        'title': 'Workshop Humic Engineering',
        'image': 'assets/images/certificate_template_2.png',
        'date': '15 Oktober 2023',
      },
    ]);
  }

  void viewCertificateDetail(int index) {
    // Navigasi ke halaman detail sertifikat
    if (index >= 0 && index < certificates.length) {
      // Get.toNamed('/certificate-detail', arguments: certificates[index]);
      Get.snackbar('Info', 'Melihat detail sertifikat ${index + 1}');
    }
  }
}

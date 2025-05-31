import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/data/config/api_config.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class TemplateHumicController extends GetxController {
  final selectedTemplateIndex = 0.obs;
  final selectedCategory = "Merah-Putih".obs;
  final isUploading = false.obs;
  final Rx<File?> selectedFile = Rx<File?>(null);
  var templates = <Template>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTemplates();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void Gunakan(
      {required int templateIndex,
      String excelFilePath = '',
      int? customTemplateIndex}) {
    selectedTemplateIndex.value = templateIndex;
    print("Template terpilih: $templateIndex");

    String emptyTemplatePath = '';
    String? templateUrl;
    int categoryIndex = templateIndex;

    if (templateIndex == 0) {
      int templateIdx =
          customTemplateIndex ?? Get.arguments?['customTemplateIndex'] ?? 0;

      if (templateIdx < templates.length) {
        Template selectedTemplate = templates[templateIdx];
        templateUrl = selectedTemplate.imageUrl;
        categoryIndex = selectedTemplate.categoryIndex;
        print(
            "URL template custom: $templateUrl, Category Index: $categoryIndex");

        Get.toNamed(Routes.INPUT_PAGE, arguments: {
          'templateIndex': 0,
          'emptyTemplatePath': templateUrl,
          'categoryIndex': categoryIndex
        });
      } else {
        Get.snackbar(
          'Error',
          'Template tidak ditemukan',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      return;
    }
    // Template bawaan
    switch (templateIndex) {
      case 1:
        emptyTemplatePath = 'assets/images/sertif-kosong-1.png';
        break;
      case 2:
        emptyTemplatePath = 'assets/images/sertif-kosong-2.png';
        break;
      case 3:
        emptyTemplatePath = 'assets/images/sertif-kosong-3.png';
        break;
      default:
        emptyTemplatePath = 'assets/images/sertif-kosong-2.png';
    }

    print("Path template kosong: $emptyTemplatePath");

    Get.toNamed(Routes.INPUT_PAGE, arguments: {
      'templateIndex': templateIndex,
      'emptyTemplatePath': emptyTemplatePath,
      'categoryIndex': categoryIndex
    });
  }

  // Fungsi untuk memilih file template
  Future<void> pickTemplateFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        // Validasi ekstensi file
        String extension = result.files.first.extension?.toLowerCase() ?? '';
        if (!['jpg', 'jpeg', 'png'].contains(extension)) {
          Get.snackbar(
            'Error',
            'Hanya file JPG, JPEG, dan PNG yang diperbolehkan',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        selectedFile.value = File(result.files.first.path!);
        Get.snackbar(
          'Sukses',
          'File template berhasil dipilih',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memilih file: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Fungsi untuk mengunggah template ke server
  Future<void> uploadTemplate() async {
    if (selectedFile.value == null) {
      Get.snackbar(
        'Error',
        'Silakan pilih file template terlebih dahulu',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isUploading.value = true;

    try {
      // Dapatkan token dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Buat request multipart
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.addTemplateUrl),
      );

      // Tambahkan header
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      int categoryIndex = 1; // Default: Merah-Putih

      // Menambahkan kategori ke request
      String kategoriStr = "";
      if (selectedCategory.value == "Merah-Putih") {
        categoryIndex = 1; // Merah-Putih
        kategoriStr = "merah-putih";
      } else if (selectedCategory.value == "Merah-Abu") {
        categoryIndex = 2; // Merah-Abu
        kategoriStr = "merah-abu";
      } else if (selectedCategory.value == "Merah-Hitam") {
        categoryIndex = 3; // Merah-Hitam
        kategoriStr = "merah-hitam";
      }

      // Kirim string kategori ke backend
      request.fields['kategori'] = kategoriStr;
      request.fields['name'] = selectedCategory.value;

// Menangani pemilihan file dan MIME type
      String fileName =
          selectedFile.value!.path.split(Platform.isWindows ? '\\' : '/').last;
      String extension = fileName.split('.').last.toLowerCase();

// Tentukan MIME type berdasarkan ekstensi
      String mimeType = (extension == 'png') ? 'image/png' : 'image/jpeg';

      var fileStream = http.ByteStream(selectedFile.value!.openRead());
      var fileLength = await selectedFile.value!.length();

      var multipartFile = http.MultipartFile(
        'template',
        fileStream,
        fileLength,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      );

// Menambahkan file ke request
      request.files.add(multipartFile);

// Mengirimkan request ke server
      var response = await request.send();

// Memeriksa respons dari server
      if (response.statusCode == 200) {
        Get.snackbar(
          'Sukses',
          'Template berhasil diunggah',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Reset file yang dipilih setelah upload berhasil
        selectedFile.value = null;

        // Muat ulang daftar template terlebih dahulu
        await fetchTemplates();

        // Kemudian kembali ke halaman template
        Get.offAndToNamed(Routes.TEMPLATE_HUMIC);
      } else {
        var responseBody = await response.stream.bytesToString();
        throw Exception(
            'Gagal mengunggah template: ${response.statusCode} - $responseBody');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengunggah template: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> deleteTemplate(String templateId) async {  // Ubah parameter dari int menjadi String
    try {
      // Dapatkan token dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      print('Menghapus template dengan ID: $templateId');

      // Lakukan permintaan DELETE ke API dengan header Authorization
      final response = await http.delete(
        Uri.parse('${ApiConfig.deleteTemplateUrl}/$templateId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Get.snackbar(
          'Sukses',
          'Template berhasil dihapus',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Refresh daftar template
        await fetchTemplates();
      } else {
        print('Error status code: ${response.statusCode}');
        print('Error response: ${response.body}');
        Get.snackbar(
          'Error',
          'Gagal menghapus template: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchTemplates() async {
    try {
      // Dapatkan token dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Lakukan permintaan GET ke API dengan header Authorization
      final response = await http.get(
        Uri.parse(ApiConfig.getAllTemplatesUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parsing response JSON
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Debug: Cetak respons untuk melihat struktur data
        print('Response data: $responseData');

        // Periksa apakah ada data dalam respons
        if (responseData.containsKey('data') && responseData['data'] is List) {
          final List<dynamic> data = responseData['data'];
          // Parsing response dan menyimpan data ke dalam list template
          templates.value = data.map((e) => Template.fromJson(e)).toList();
          print('Templates loaded: ${templates.length}');
        } else {
          print(
              'Response tidak memiliki format yang diharapkan: $responseData');
          templates.value = [];
        }
      } else {
        print('Error status code: ${response.statusCode}');
        print('Error response: ${response.body}');
        Get.snackbar(
          'Error',
          'Gagal mengambil template: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

class Template {
  final String name;
  final String imageUrl;
  final String id;  // Ubah dari int menjadi String
  final int categoryIndex;

  Template(
      {required this.name,
      required this.imageUrl,
      required this.id,
      required this.categoryIndex});

  factory Template.fromJson(Map<String, dynamic> json) {
    // Ambil kategori dari respons backend dan konversi ke integer yang sesuai
    int categoryIdx = 1; // Default: Merah-Putih

    if (json['kategori'] != null) {
      // Pastikan kategori dikonversi ke string terlebih dahulu
      String kategoriStr = json['kategori'].toString().toLowerCase().trim();

      // Konversi string kategori ke integer
      if (kategoriStr == "merah-putih") {
        categoryIdx = 1;
      } else if (kategoriStr == "merah-abu") {
        categoryIdx = 2;
      } else if (kategoriStr == "merah-hitam") {
        categoryIdx = 3;
      } else {
        // Coba parse jika kategori sudah berupa angka
        try {
          categoryIdx = int.parse(kategoriStr);
        } catch (e) {
          print("Error parsing kategori: $e, using default value 1");
          categoryIdx = 1;
        }
      }
    }

    // Konversi category_index ke nama kategori yang lebih deskriptif
    String templateName = 'Template Custom';
    if (categoryIdx == 1) {
      templateName = 'Template Custom (Merah-Putih)';
    } else if (categoryIdx == 2) {
      templateName = 'Template Custom (Merah-Abu)';
    } else if (categoryIdx == 3) {
      templateName = 'Template Custom (Merah-Hitam)';
    }

    return Template(
      id: json['id']?.toString() ?? '',  // Simpan ID sebagai string
      name: templateName,
      imageUrl: json['img_path']?.toString() ?? '',
      categoryIndex: categoryIdx,
    );
  }
}

void kembali() {
  Get.offNamed(Routes.ADMIN_PAGE);
}

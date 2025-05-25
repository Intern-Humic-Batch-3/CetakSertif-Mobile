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
  // Tambahkan variabel reaktif untuk menyimpan template yang dipilih
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

  void Gunakan({required int templateIndex, String excelFilePath = ''}) {
    selectedTemplateIndex.value = templateIndex;
    print("Template terpilih: $templateIndex");

    String emptyTemplatePath = '';
    String? templateUrl;

    if (templateIndex == 0 && selectedTemplateIndex.value < templates.length) {
      // Template custom dari server
      templateUrl = templates[selectedTemplateIndex.value].imageUrl;
      print("URL template custom: $templateUrl");

      Get.toNamed(Routes.INPUT_PAGE, arguments: {
        'templateIndex': templateIndex,
        'templateUrl': templateUrl
      });
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
      'emptyTemplatePath': emptyTemplatePath
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

      // Periksa ekstensi file untuk menentukan MIME type
      String fileName =
          selectedFile.value!.path.split(Platform.isWindows ? '\\' : '/').last;
      String extension = fileName.split('.').last.toLowerCase();

      // Tentukan MIME type berdasarkan ekstensi
      String mimeType;
      if (extension == 'png') {
        mimeType = 'image/png';
      } else {
        mimeType = 'image/jpeg';
      }

      // Tambahkan file dengan MIME type yang eksplisit
      var fileStream = http.ByteStream(selectedFile.value!.openRead());
      var fileLength = await selectedFile.value!.length();

      var multipartFile = http.MultipartFile(
        'template',
        fileStream,
        fileLength,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      );

      request.files.add(multipartFile);

      // Kirim request
      var response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar(
          'Sukses',
          'Template berhasil diunggah',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Reset file yang dipilih
        selectedFile.value = null;
        // Refresh halaman untuk menampilkan template baru
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

  Future<void> fetchTemplates() async {
    try {
      // Lakukan permintaan GET ke API
      final response = await http.get(Uri.parse(ApiConfig.getAllTemplatesUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Parsing response dan menyimpan data ke dalam list template
        templates.value = data.map((e) => Template.fromJson(e)).toList();
      } else {
        Get.snackbar(
          'Error',
          'Gagal mengambil template',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
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

  Template({required this.name, required this.imageUrl});

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      name: json['name'] ?? 'Unknown',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}

void kembali() {
  Get.offNamed(Routes.ADMIN_PAGE);
}

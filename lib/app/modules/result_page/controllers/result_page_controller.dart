import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/data/models/certificate_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class ResultPageController extends GetxController {
  RxList<Certificate> certificates = <Certificate>[].obs;
  RxBool isLoading = true.obs;
  RxString templatePath = ''.obs;
  RxInt templateIndex = 0.obs;

  // Tambahkan variabel categoryIndex
  RxInt categoryIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      final excelFilePath = args['excelFilePath'] as String;
      templatePath.value = args['emptyTemplatePath'] as String;
      templateIndex.value = args['templateIndex'] as int;

      // Pastikan categoryIndex selalu integer
      if (args['categoryIndex'] != null) {
        if (args['categoryIndex'] is int) {
          categoryIndex.value = args['categoryIndex'] as int;
        } else {
          // Jika bukan integer, coba konversi
          try {
            categoryIndex.value = int.parse(args['categoryIndex'].toString());
          } catch (e) {
            print(
                "Error parsing categoryIndex: $e, using templateIndex as fallback");
            categoryIndex.value = templateIndex.value;
          }
        }
      } else {
        categoryIndex.value = templateIndex.value;
      }

      loadExcelData(excelFilePath);
    }
  }

  Future<void> loadExcelData(String filePath) async {
    isLoading.value = true;

    try {
      final bytes = File(filePath).readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);

      // Ambil sheet pertama
      final sheet = excel.tables.keys.first;
      final rows = excel.tables[sheet]?.rows;

      if (rows != null && rows.isNotEmpty) {
        // Asumsikan kolom pertama adalah nama
        for (var i = 0; i < rows.length; i++) {
          final row = rows[i];
          if (row.isNotEmpty && row[0]?.value != null) {
            final name = row[0]!.value.toString();
            certificates.add(Certificate(
              name: name,
              templatePath: templatePath.value,
              templateIndex: templateIndex.value,
              categoryIndex: categoryIndex.value, // Tambahkan ini
            ));
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data Excel: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<ui.Image> loadTemplateImage() async {
    try {
      print("Loading template from: ${templatePath.value}");

      if (templatePath.value.startsWith('http')) {
        // Jika path adalah URL, gunakan NetworkImage
        final HttpClient httpClient = HttpClient();
        final Uri uri = Uri.parse(templatePath.value);
        final HttpClientRequest request = await httpClient.getUrl(uri);
        final HttpClientResponse response = await request.close();
        final Uint8List bytes =
            await consolidateHttpClientResponseBytes(response);
        final ui.Codec codec = await ui.instantiateImageCodec(bytes);
        final ui.FrameInfo fi = await codec.getNextFrame();
        return fi.image;
      } else {
        // Jika path adalah aset lokal, gunakan rootBundle
        final ByteData data = await rootBundle.load(templatePath.value);
        final Uint8List bytes = data.buffer.asUint8List();
        final ui.Codec codec = await ui.instantiateImageCodec(bytes);
        final ui.FrameInfo fi = await codec.getNextFrame();
        return fi.image;
      }
    } catch (e) {
      print("Error loading template image: $e");
      Get.snackbar('Error', 'Gagal memuat gambar template: $e');
      // Fallback ke template default jika terjadi error
      final ByteData defaultData =
          await rootBundle.load('assets/images/sertif-kosong-1.png');
      final Uint8List defaultBytes = defaultData.buffer.asUint8List();
      final ui.Codec defaultCodec =
          await ui.instantiateImageCodec(defaultBytes);
      final ui.FrameInfo defaultFi = await defaultCodec.getNextFrame();
      return defaultFi.image;
    }
  }

  // Dalam fungsi generateCertificate, gunakan categoryIndex untuk styling
  Future<File> generateCertificate(String name) async {
    try {
      final ui.Image templateImage = await loadTemplateImage();

      // Buat canvas untuk menggambar
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Gambar template
      canvas.drawImage(templateImage, Offset.zero, Paint());

      // Tambahkan nama dengan font Great Vibes
      final textStyle = ui.TextStyle(
        color: categoryIndex.value == 1
            ? Colors.red
            : Colors.black, // Gunakan categoryIndex
        fontSize: 100,
        fontWeight: FontWeight.normal,
        fontFamily: 'Great Vibes',
      );

      final paragraphStyle = ui.ParagraphStyle(
        textAlign: categoryIndex.value == 1
            ? TextAlign.left
            : TextAlign.center, // Gunakan categoryIndex
        fontSize: 100,
        fontFamily: 'Great Vibes',
      );

      final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
        ..pushStyle(textStyle)
        ..addText(name);

      final paragraph = paragraphBuilder.build();
      paragraph.layout(
          ui.ParagraphConstraints(width: templateImage.width.toDouble()));

      // Tentukan posisi nama berdasarkan template yang dipilih
      double x = 0;
      double y = 0;

      switch (categoryIndex.value) {
        // Gunakan categoryIndex
        case 1:
          // Posisi untuk template merah-putih
          x = templateImage.width * 0.33;
          y = templateImage.height * 0.45;
          break;
        case 2:
          // Posisi untuk template merah-abu
          x = (templateImage.width - paragraph.width) / 2;
          y = templateImage.height * 0.43;
          break;
        case 3:
          // Posisi untuk template merah-hitam
          x = (templateImage.width - paragraph.width) / 2;
          y = templateImage.height * 0.45;
          break;
        default:
          // Posisi default
          x = (templateImage.width - paragraph.width) / 2;
          y = templateImage.height * 0.45;
      }

      // Gambar teks nama pada canvas
      canvas.drawParagraph(paragraph, Offset(x, y));

      // Konversi ke gambar
      final picture = recorder.endRecording();
      final img =
          await picture.toImage(templateImage.width, templateImage.height);
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception("Gagal mengkonversi gambar");
      }

      final buffer = byteData.buffer.asUint8List();

      // Simpan ke file sementara
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$name-certificate.png');
      await file.writeAsBytes(buffer);

      return file;
    } catch (e) {
      print("Error generating certificate: $e");
      Get.snackbar('Error', 'Gagal membuat sertifikat: $e');
      throw e;
    }
  }

  // Tambahkan fungsi baru untuk mengunduh sertifikat
  Future<bool> downloadCertificate(String name) async {
    try {
      // Generate sertifikat terlebih dahulu
      final tempFile = await generateCertificate(name);

      if (tempFile == null) {
        throw Exception("Gagal membuat file sertifikat");
      }

      // Dapatkan direktori Pictures
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Pictures/Humic');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
      } else {
        final appDir = await getApplicationDocumentsDirectory();
        directory = Directory('${appDir.path}/Humic');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
      }

      // Buat nama file yang unik dengan timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '$name-certificate-$timestamp.png';
      final targetPath = '${directory.path}/$fileName';

      // Salin file
      final savedFile = await tempFile.copy(targetPath);

      // Beri tahu galeri tentang file baru (hanya untuk Android)
      if (Platform.isAndroid) {
        try {
          // Tambahkan file ke Media Store
          final mediaScanIntent = MethodChannel('com.humic.app/media_scanner');
          await mediaScanIntent
              .invokeMethod('scanFile', {'path': savedFile.path});
        } catch (e) {
          print("Error scanning file: $e");
          // Lanjutkan meskipun gagal scan file
        }
      }

      Get.snackbar(
        'Berhasil',
        'Sertifikat berhasil diunduh ke: ${savedFile.path}',
        duration: Duration(seconds: 5),
      );

      return true;
    } catch (e) {
      print("Error downloading certificate: $e");
      Get.snackbar('Error', 'Gagal mengunduh sertifikat: $e');
      return false;
    }
  }
}

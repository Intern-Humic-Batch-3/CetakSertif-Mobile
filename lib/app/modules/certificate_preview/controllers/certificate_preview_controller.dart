import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class CertificatePreviewController extends GetxController {
  RxString firstCertificateName = ''.obs;
  RxBool isLoading = true.obs;
  RxString templatePath = ''.obs;
  RxInt templateIndex = 0.obs;
  RxString excelFilePath = ''.obs;
  RxString activityName = ''.obs;
  Rx<File?> previewFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      excelFilePath.value = args['excelFilePath'] as String;
      templatePath.value = args['emptyTemplatePath'] as String;
      templateIndex.value = args['templateIndex'] as int;
      activityName.value =
          args['activityName'] as String? ?? 'Workshop Humic Engineering';

      loadFirstCertificate();
    }
  }

  Future<void> loadFirstCertificate() async {
    isLoading.value = true;

    try {
      final bytes = File(excelFilePath.value).readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);

      // Ambil sheet pertama
      final sheet = excel.tables.keys.first;
      final rows = excel.tables[sheet]?.rows;

      if (rows != null && rows.isNotEmpty) {
        // Asumsikan kolom pertama adalah nama
        if (rows.length > 0 &&
            rows[0].isNotEmpty &&
            rows[0][0]?.value != null) {
          firstCertificateName.value = rows[0][0]!.value.toString();
          previewFile.value =
              await generateCertificate(firstCertificateName.value);
        }
      }
    } catch (e) {
      print("Error loading Excel data: $e");
      Get.snackbar('Error', 'Gagal memuat data Excel: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<File?> generateCertificate(String name) async {
    try {
      // Muat gambar template
      ui.Image templateImage;

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
        templateImage = fi.image;
      } else {
        // Jika path adalah aset lokal, gunakan rootBundle
        final ByteData data = await rootBundle.load(templatePath.value);
        final Uint8List bytes = data.buffer.asUint8List();
        final ui.Codec codec = await ui.instantiateImageCodec(bytes);
        final ui.FrameInfo fi = await codec.getNextFrame();
        templateImage = fi.image;
      }

      // Buat canvas untuk menggambar
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Gambar template
      canvas.drawImage(templateImage, Offset.zero, Paint());

      // Tambahkan nama dengan font Great Vibes
      final textStyle = ui.TextStyle(
        color: templateIndex.value == 1 ? Colors.red : Colors.black,
        fontSize: 100,
        fontWeight: FontWeight.normal,
        fontFamily: 'Great Vibes',
      );

      final paragraphStyle = ui.ParagraphStyle(
        textAlign: templateIndex.value == 1 ? TextAlign.left : TextAlign.center,
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

      switch (templateIndex.value) {
        case 1:
          // Posisi untuk template 1
          x = templateImage.width * 0.33;
          y = templateImage.height * 0.45;
          break;
        case 2:
          // Posisi untuk template 2
          x = (templateImage.width - paragraph.width) / 2;
          y = templateImage.height * 0.43;
          break;
        case 3:
          // Posisi untuk template 3
          x = (templateImage.width - paragraph.width) / 2;

          y = templateImage.height * 0.45;
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
      return null;
    }
  }

  void navigateToAllCertificates() {
    Get.toNamed(Routes.RESULT_PAGE, arguments: {
      'excelFilePath': excelFilePath.value,
      'emptyTemplatePath': templatePath.value,
      'templateIndex': templateIndex.value
    });
  }
}

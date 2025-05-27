import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/data/models/certificate_model.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/widgets/custom_drawer.dart';
import 'package:humic_mobile/app/data/controllers/user_controllers.dart';
import '../controllers/result_page_controller.dart';

class ResultPageView extends GetView<ResultPageController> {
  const ResultPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      drawer: Obx(() => CustomDrawer(
            isAdmin: userController.isAdmin.value,
            userEmail: userController.userEmail.value,
            userName: userController.userName.value,
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
                  Text(
                    'Preview Sertifikat',
                    style: AppTypography.bodyLargeBold,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.certificates.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada data yang ditemukan',
                      style: AppTypography.bodyMediumRegular,
                    ),
                  );
                }

                // Menggunakan GridView.builder dengan 2 kolom
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: controller.certificates.length,
                  itemBuilder: (context, index) {
                    final certificate = controller.certificates[index];
                    return _buildCertificateGridItem(context, certificate);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateGridItem(
      BuildContext context, Certificate certificate) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sertifikat
          Expanded(
            child: FutureBuilder<File?>(
              future: controller.generateCertificate(certificate.name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return Center(
                    child: Icon(Icons.error_outline, color: Colors.red[300]),
                  );
                }

                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.file(
                    snapshot.data!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
            ),
          ),

          // Nama dan menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                // Nama dengan elipsis jika terlalu panjang
                Expanded(
                  child: Text(
                    certificate.name.length > 15
                        ? '${certificate.name.substring(0, 15)}...'
                        : certificate.name,
                    style: AppTypography.bodyMediumBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Ikon titik tiga
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    _showCertificateOptions(context, certificate);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCertificateOptions(BuildContext context, Certificate certificate) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Detail Sertifikat',
                style: AppTypography.bodyLargeBold,
              ),
            ),

            // Nama lengkap
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama:',
                    style: AppTypography.bodySmallBold.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    certificate.name,
                    style: AppTypography.bodyMediumBold,
                  ),
                ],
              ),
            ),

            // Tombol unduh
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.download),
                label: const Text('Unduh'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context); // Tutup dialog
                  await controller.downloadCertificate(certificate.name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

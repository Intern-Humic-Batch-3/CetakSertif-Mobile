import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/modules/certificate_preview/controllers/certificate_preview_controller.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/widgets/custom_drawer.dart';
import 'package:humic_mobile/app/data/controllers/user_controllers.dart';

class CertificatePreviewView extends GetView<CertificatePreviewController> {
  const CertificatePreviewView({Key? key}) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Judul kegiatan
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 20.0),
              child: Text(
                controller.activityName.value,
                style: AppTypography.h5SemiBold,
                textAlign: TextAlign.center,
              ),
            ),

            // Spacer untuk mendorong konten ke bawah
            const SizedBox(height: 80),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.previewFile.value == null) {
                  return Center(
                    child: Text(
                      'Tidak ada data yang ditemukan',
                      style: AppTypography.bodyMediumRegular,
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Teks petunjuk
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "Klik sertifikat untuk melihat semua",
                          style: AppTypography.bodyMediumRegular.copyWith(
                            color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Sertifikat di tengah dengan ukuran besar
                      GestureDetector(
                        onTap: () {
                          // Dalam GestureDetector onTap
                          Get.toNamed('/result-page', arguments: {
                            'excelFilePath': controller.excelFilePath.value,
                            'emptyTemplatePath': controller.templatePath.value,
                            'templateIndex': controller.templateIndex.value,
                            'categoryIndex': controller.categoryIndex.value, // Tambahkan ini
                          });
                        },
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.file(
                              controller.previewFile.value!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      // Tombol download di bawah sertifikat
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: ElevatedButton.icon(
                          onPressed: controller.downloadAsZip,
                          icon: const Icon(Icons.download),
                          label: const Text('Unduh Semua (ZIP)'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

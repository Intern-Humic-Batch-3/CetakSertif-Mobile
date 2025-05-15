import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
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

                return ListView.builder(
                  itemCount: controller.certificates.length,
                  itemBuilder: (context, index) {
                    final certificate = controller.certificates[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              certificate.name,
                              style: AppTypography.bodyMediumBold,
                            ),
                          ),
                          FutureBuilder<File?>(
                            future: controller
                                .generateCertificate(certificate.name),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              if (snapshot.hasError) {
                                return SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Gagal memuat preview',
                                          style:
                                              AppTypography.bodyMediumRegular,
                                        ),
                                        Text(
                                          'Error: ${snapshot.error}',
                                          style: AppTypography.bodySmallRegular
                                              .copyWith(color: Colors.red),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              if (!snapshot.hasData) {
                                return SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                      'Gagal memuat preview: File tidak tersedia',
                                      style: AppTypography.bodyMediumRegular,
                                    ),
                                  ),
                                );
                              }

                              return Image.file(
                                snapshot.data!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.download),
                                  label: const Text('Unduh'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () async {
                                    final file = await controller
                                        .generateCertificate(certificate.name);
                                    // Implementasi unduh file
                                    Get.snackbar(
                                      'Sukses',
                                      'Sertifikat berhasil diunduh',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

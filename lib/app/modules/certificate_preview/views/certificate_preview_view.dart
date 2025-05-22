import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/widgets/custom_drawer.dart';
import 'package:humic_mobile/app/data/controllers/user_controllers.dart';
import '../controllers/certificate_preview_controller.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menghapus bagian header dengan teks "Preview Sertifikat" dan ikon kembali
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
                      // Preview sertifikat dalam grid
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          // Item sertifikat
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Sertifikat
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigasi ke halaman semua sertifikat ketika sertifikat diklik
                                    Get.toNamed('/result-page', arguments: {
                                      'excelFilePath':
                                          controller.excelFilePath.value,
                                      'emptyTemplatePath':
                                          controller.templatePath.value,
                                      'templateIndex':
                                          controller.templateIndex.value,
                                    });
                                  },
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        controller.previewFile.value!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Nama kegiatan dan ikon titik tiga
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        controller.activityName.value,
                                        style: AppTypography.bodyMediumSemiBold,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon:
                                          const Icon(Icons.more_vert, size: 20),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Text(
                                                  controller.activityName.value,
                                                  style: AppTypography
                                                      .bodyLargeBold,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              const Divider(),
                                              ListTile(
                                                leading:
                                                    const Icon(Icons.download),
                                                title: const Text('Unduh'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Get.snackbar(
                                                    'Info',
                                                    'Fitur unduh akan segera tersedia',
                                                    backgroundColor:
                                                        Colors.blue,
                                                    colorText: Colors.white,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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

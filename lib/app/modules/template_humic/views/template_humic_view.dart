import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/widgets/custom_drawer.dart';
import 'package:humic_mobile/app/widgets/custom_header_input.dart';
import '../controllers/template_humic_controller.dart';
import 'package:humic_mobile/app/data/controllers/user_controllers.dart';

class TemplateHumicView extends GetView<TemplateHumicController> {
  const TemplateHumicView({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    // Ambil excelFilePath dari arguments jika ada
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String excelFilePath = args['excelFilePath'] ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      drawer: Obx(() => CustomDrawer(
            isAdmin: userController.isAdmin.value,
            userEmail: userController.userEmail.value,
            userName: userController.userName.value,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const CustomInputHeader(showBackButton: true),
              const SizedBox(height: 30),

              // Judul untuk Template Custom
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Template Custom",
                  style: AppTypography.h4SemiBold.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),
              // Template Custom dari Server dalam Grid
              Obx(() {
                if (controller.templates.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Tidak ada template custom"),
                    ),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.templates.length,
                    itemBuilder: (context, index) {
                      final template = controller.templates[index];
                      return _buildServerTemplateItemGrid(
                        context,
                        template.name,
                        template.imageUrl,
                        () => controller.Gunakan(
                          templateIndex: 0,
                          excelFilePath: excelFilePath,
                          customTemplateIndex: index,
                        ),
                        templateId: template.id,
                      );
                    },
                  );
                }
              }),

              const SizedBox(height: 50),

              // Template 1
              _buildTemplateItem(
                context,
                "Template Merah-Putih",
                "assets/images/sertif-kosong-1.png",
                () => controller.Gunakan(
                    templateIndex: 1, excelFilePath: excelFilePath),
              ),

              const SizedBox(height: 50),

              // Template 2
              _buildTemplateItem(
                context,
                "Template Merah-Abu",
                "assets/images/sertif-kosong-2.png",
                () => controller.Gunakan(
                    templateIndex: 2, excelFilePath: excelFilePath),
              ),

              const SizedBox(height: 50),

              // Template 3
              _buildTemplateItem(
                context,
                "Template Merah-Hitam",
                "assets/images/sertif-kosong-3.png",
                () => controller.Gunakan(
                    templateIndex: 3, excelFilePath: excelFilePath),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // Tambahkan Floating Action Button untuk menambah template
      floatingActionButton: Obx(() => userController.isAdmin.value
          ? FloatingActionButton(
              onPressed: () => _showAddTemplateDialog(context),
              backgroundColor: AppColors.primary,
              child: const Icon(
                Icons.add,
                color: AppColors.background,
              ),
            )
          : const SizedBox()),
    );
  }

  // Widget untuk menampilkan template dari server dalam grid
  Widget _buildServerTemplateItemGrid(BuildContext context, String title,
      String imageUrl, VoidCallback onUseTemplate,
      {required String templateId}) {
    final userController = Get.find<UserController>();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header dengan judul dan ikon hapus
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.bodyMediumSemiBold.copyWith(
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Ikon hapus hanya untuk admin
                if (userController.isAdmin.value)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      // Konfirmasi penghapusan
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: const Text(
                              'Apakah Anda yakin ingin menghapus template ini?'),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                                controller.deleteTemplate(templateId);
                              },
                              child: const Text('Hapus'),
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.red),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Gambar Sertifikat dari URL
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(Icons.error, color: Colors.red),
                    );
                  },
                ),
              ),
            ),
          ),

          // Tombol Gunakan Template
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 36),
              ),
              onPressed: onUseTemplate,
              child: const Text("Gunakan", style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  // Dialog untuk menambah template baru
  void _showAddTemplateDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tambah Template Sertifikat",
              style: AppTypography.h5SemiBold.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Kategori Template",
                  style: AppTypography.bodyMediumSemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 3),
                Text(
                  "(styling posisi nama)",
                  style: AppTypography.bodyMediumRegular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Dropdown untuk memilih kategori
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: InputBorder.none,
                  ),
                  value: controller.selectedCategory.value,
                  items: [
                    "Merah-Putih",
                    "Merah-Abu",
                    "Merah-Hitam",
                  ].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedCategory.value = newValue;
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Upload Template",
              style: AppTypography.bodyMediumSemiBold.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            // Tombol untuk memilih file
            Obx(
              () => GestureDetector(
                onTap: controller.pickTemplateFile,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Bagian Kiri: "Chosen File"
                      Container(
                        width: 110,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Chosen File',
                          style: AppTypography.bodyMediumRegular
                              .copyWith(color: Colors.grey[600]),
                        ),
                      ),
                      Container(
                        width: 1,
                        color: Colors.grey,
                      ),
                      // Bagian Kanan: Nama File
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          color: Colors.white,
                          alignment: Alignment.centerLeft,
                          child: controller.selectedFile.value != null
                              ? Text(
                                  controller.selectedFile.value!.path
                                      .split(Platform.isWindows ? '\\' : '/')
                                      .last,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.bodyMediumRegular,
                                )
                              : Text(
                                  'Silakan pilih file',
                                  style: AppTypography.bodyMediumRegular
                                      .copyWith(color: Colors.grey[500]),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Tombol untuk mengunggah template
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: controller.isUploading.value
                      ? null
                      : controller.uploadTemplate,
                  child: controller.isUploading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Upload Template"),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateItem(BuildContext context, String title,
      String imagePath, VoidCallback onUseTemplate) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: AppTypography.h4SemiBold.copyWith(
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/LogoHumic.png',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              "CoE Humic Engineering Research Center",
              style: AppTypography.bodyMediumSemiBold.copyWith(),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Gambar Sertifikat
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Image.asset(
            imagePath,
            width: 300,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 16),

        // Tombol Gunakan Template
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(250, 48),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onUseTemplate,
          child: const Text("Gunakan Template Ini"),
        ),
      ],
    );
  }
}

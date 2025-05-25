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
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Template Custom",
                  style: AppTypography.h4SemiBold.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              // Template Custom dari Server
              Obx(() => controller.templates.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Tidak ada template custom"),
                      ),
                    )
                  : Column(
                      children: controller.templates.map((template) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: _buildServerTemplateItem(
                            context,
                            template.name,
                            template.imageUrl,
                            () => controller.Gunakan(
                              templateIndex: 0, // Gunakan 0 untuk template custom
                              excelFilePath: excelFilePath,
                            ),
                          ),
                        );
                      }).toList(),
                    )),
              
              // Judul untuk Template Bawaan
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Template Bawaan",
                  style: AppTypography.h4SemiBold.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Template 1
              _buildTemplateItem(
                context,
                "Template Merah-Putih",
                "assets/images/sertif-kosong-1.png",
                () => controller.Gunakan(
                    templateIndex: 1, excelFilePath: excelFilePath),
              ),

              const SizedBox(height: 30),

              // Template 2
              _buildTemplateItem(
                context,
                "Template Merah-Abu",
                "assets/images/sertif-kosong-2.png",
                () => controller.Gunakan(
                    templateIndex: 2, excelFilePath: excelFilePath),
              ),

              const SizedBox(height: 30),

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

  // Widget untuk menampilkan template dari server
  Widget _buildServerTemplateItem(BuildContext context, String title,
      String imageUrl, VoidCallback onUseTemplate) {
    return Column(
      children: [
        Text(
          title,
          style: AppTypography.h5SemiBold.copyWith(
              color: AppColors.primary,
              backgroundColor: AppColors.cardBackground),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
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

        // Gambar Sertifikat dari URL
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Image.network(
            imageUrl,
            width: 300,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                width: 300,
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return SizedBox(
                width: 300,
                height: 200,
                child: Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              );
            },
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
            Text(
              "Kategori Template",
              style: AppTypography.bodyMediumSemiBold.copyWith(
                color: AppColors.textPrimary,
              ),
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
            InkWell(
              onTap: controller.pickTemplateFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.upload_file, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      "Pilih File Template",
                      style: AppTypography.bodyMediumBold.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
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
        Text(
          title,
          style: AppTypography.h5SemiBold.copyWith(
              color: AppColors.primary,
              backgroundColor: AppColors.cardBackground),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
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

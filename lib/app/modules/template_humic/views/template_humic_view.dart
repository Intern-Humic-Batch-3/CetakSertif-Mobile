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

              // Template 1
              _buildTemplateItem(
                context,
                "Template Humic Sertifikat",
                "assets/images/sertif-kosong-1.png",
                () => controller.Gunakan(
                    templateIndex: 1, excelFilePath: excelFilePath),
              ),

              const SizedBox(height: 30),

              // Template 2
              _buildTemplateItem(
                context,
                "Template Humic Sertifikat",
                "assets/images/sertif-kosong-2.png",
                () => controller.Gunakan(
                    templateIndex: 2, excelFilePath: excelFilePath),
              ),

              const SizedBox(height: 30),

              // // Template 3
              // _buildTemplateItem(
              //   context,
              //   "Template Humic Sertifikat",
              //   "assets/images/sertif-template-3.png",
              //   () => controller.Gunakan(
              //       templateIndex: 3, excelFilePath: excelFilePath),
              // ),

              const SizedBox(height: 20),
            ],
          ),
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
            color: AppColors.textPrimary,
          ),
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

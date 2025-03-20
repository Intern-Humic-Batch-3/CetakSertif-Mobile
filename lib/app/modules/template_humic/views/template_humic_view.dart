import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/widgets/custom_drawer.dart';
import 'package:humic_mobile/app/widgets/custom_header_input.dart';
import '../controllers/template_humic_controller.dart';

class TemplateHumicView extends GetView<TemplateHumicController> {
  const TemplateHumicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      drawer: const CustomDrawer(
        isAdmin: true,
        userEmail: "Daniel Admin",
        userName: "Danieladmin@mail.com",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CustomInputHeader(showBackButton: false),
            const SizedBox(height: 90),
            Text(
              "Template Humic Sertifikat",
              style: AppTypography.h5SemiBold.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
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
                'assets/images/sertif-template.png',
                width: 300,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),
            const Text(
              "Ukuran A4  29,7 x 21 cm",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 24),

            // Tombol Aksi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(140, 48),
                    backgroundColor: AppColors.putih,
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: AppColors.primary),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Kembali"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(140, 48),
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: AppColors.primary),
                    ),
                  ),
                  onPressed: () => controller.Gunakan(),
                  child: const Text("Gunakan Template Ini"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

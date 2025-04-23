import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/widgets/custom_drawer.dart';
import 'package:humic_mobile/app/widgets/custom_submit_button.dart';

import '../controllers/admin_page_controller.dart';

class AdminPageView extends GetView<AdminPageController> {
  const AdminPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(
        isAdmin: true,
        userEmail: controller.userEmail, // Menampilkan email pengguna
        userName: controller.userName, // Menampilkan nama lengkap pengguna
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/admin-awal.png",
              width: 100,
            ),
            const SizedBox(height: 24),
            Text(
              "Belum ada sertifikat!",
              style: AppTypography.bodyLargeBold.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Silahkan membuat sertifikat\n yang anda inginkan!",
              style: AppTypography.bodyLargeRegular.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomSubmitButton(
              text: "Tambah",
              onPressed: () => controller.Tambah(),
            ),
          ],
        ),
      ),
    );
  }
}

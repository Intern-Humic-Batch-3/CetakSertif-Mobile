import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/widgets/custom_submit_button.dart';
import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Input Data"),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 98), // 🔑 Ini jarak dari AppBar ke konten
            // Certificate Upload Container
            DottedBorder(
              color: AppColors.textPrimary,
              strokeWidth: 5,
              dashPattern: [4, 4], // Length of dashes and gaps
              borderType: BorderType.RRect,
              radius: Radius.circular(8),
              child: Container(
                width: double.infinity,
                height: 460,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.image_outlined,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Silahkan Masukkan Sertifikat Template di Sini!',
                      style: AppTypography.bodyMediumBold.copyWith(
                        color: AppColors.textPrimary,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Hanya Mendukung JPG dan PNG',
                      style: AppTypography.bodySmallRegular.copyWith(
                        color: AppColors.textSecondary,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24), // Jarak sebelum tombol
            CustomSubmitButton(
              onPressed: () {
                Get.toNamed(Routes.INPUT_PAGE);
              },
            ),
          ],
        ),
      ),
    );
  }
}

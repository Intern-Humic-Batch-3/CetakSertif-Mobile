import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';
import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          "assets/images/LogoHumic.png",
          height: 40,
        ),
        actions: [
          Builder(
            // Pakai Builder supaya bisa akses Scaffold.of(context)
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColors.textPrimary,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // Buka sidebar
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Divider(
            color: AppColors.primary,
            height: 1,
          ),
        ),
      ),
      endDrawer: Drawer(
        width: 250,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/LogoHumic.png",
                  height: 100,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: AppColors.textPrimary,
              ),
              title: Text(
                'Riwayat Sertifikat',
                style: AppTypography.bodyLargeRegular.copyWith(
                  color: AppColors.textPrimary,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                Get.back(); // Tutup drawer
                // Arahkan ke halaman riwayat jika ada
              },
            ),
            const Spacer(), // Dorong logout ke bawah
            Divider(color: AppColors.disabled),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: AppColors.error,
              ),
              title: Text(
                'Logout',
                style: AppTypography.bodyLargeRegular.copyWith(
                  color: AppColors.error,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                Get.back(); // Tutup drawer
                Get.offAllNamed(Routes.LOGIN_PAGE); // Pindah ke login
              },
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 98), // 🔑 Ini jarak dari AppBar ke konten
            // Certificate Upload Container
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.textTertiary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
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
            const SizedBox(height: 24), // Jarak sebelum tombol
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi submit
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: AppTypography.bodyLargeSemiBold.copyWith(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

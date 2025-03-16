import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';

class CustomDrawer extends StatelessWidget {
  final bool isAdmin;
  final String userName;
  final String userEmail;

  const CustomDrawer({
    Key? key,
    required this.isAdmin,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 232,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 60),

            // **Logo**
            Center(
              child: Image.asset(
                "assets/images/LogoHumic-Home.png",
                height: 50,
              ),
            ),
            const SizedBox(height: 45),

            Container(
              width: 180,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    userEmail,
                    style: AppTypography.bodyLargeSemiBold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    userName,
                    style: AppTypography.bodySmallRegular.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 45),

            Expanded(
              child: Column(
                children: [
                  _buildDrawerItem(
                    imagePath: "assets/icons/sertif-icon.png",
                    title: "Riwayat Sertifikat",
                    onTap: () => Get.toNamed(Routes.HOME_PAGE),
                  ),
                  _buildDrawerItem(
                    imagePath: "assets/icons/user-icon.png",
                    title: "Daftar Pengguna",
                    onTap: () => Get.toNamed(Routes.HOME_PAGE),
                  ),
                  _buildDrawerItem(
                    imagePath: "assets/icons/file-icon.png",
                    title: "Template Humic",
                    onTap: () => Get.toNamed(Routes.HOME_PAGE),
                  ),
                ],
              ),
            ),

            // **Logout Button**
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.offAllNamed(Routes.LOGIN_PAGE);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 33,
                    ),
                    SizedBox(width: 20),
                    Text("Logout", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Image.asset(
                  imagePath,
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppTypography.bodyMediumSemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

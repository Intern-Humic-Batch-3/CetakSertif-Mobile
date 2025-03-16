import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: AppColors.textPrimary),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                "assets/images/LogoHumic.png",
                height: 40,
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          color: AppColors.primary,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 2);
}

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
      child: SizedBox(
        width: 150, // Lebar sidebar sesuai desain
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo
              Center(
                child: Image.asset(
                  "assets/images/LogoHumic-Home.png",
                  height: 60,
                ),
              ),
              const SizedBox(height: 20),

              // **Informasi Pengguna (Ditengah)**
              Container(
                width: 200,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      userEmail,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // **Menu Drawer**
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

              const Spacer(), // Untuk mendorong logout ke bawah

              // **Logout Button**
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.offAllNamed(Routes.LOGIN_PAGE);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 8),
                      Text("Logout", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Image.asset(
          "assets/images/LogoHumic.png",
          height: 40,
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(
            Icons.menu,
            color: AppColors.textPrimary,
          ),
          offset: Offset(0, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Colors.grey[900],
          onSelected: (value) {
            if (value == 'riwayat') {
              // Navigate to Riwayat Sertifikat page
            } else if (value == 'logout') {
              Get.offAllNamed(Routes.LOGIN_PAGE); // Navigate to login
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'riwayat',
                child: Row(
                  children: [
                    Icon(Icons.history, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Riwayat Sertifikat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10.0),
        child: Divider(
          color: AppColors.primary,
          height: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

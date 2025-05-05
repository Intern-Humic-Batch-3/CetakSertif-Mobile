import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/widgets/custom_drawer.dart';
import '../controllers/hasil_pengguna_controller.dart';
import 'package:humic_mobile/app/data/controllers/user_controllers.dart';

class HasilPenggunaView extends GetView<HasilPenggunaController> {
  const HasilPenggunaView({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      drawer: Obx(() => CustomDrawer(
            isAdmin: userController.isAdmin.value,
            userEmail: userController.userEmail.value,
            userName: userController.userName.value,
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
              child: Text(
                'Sertifikat Anda',
                style: AppTypography.bodySmallBold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                ),
                itemCount:
                    10, // Jumlah sertifikat (bisa diganti dengan data dari controller)
                itemBuilder: (context, index) {
                  // Menentukan template yang akan digunakan (bergantian)
                  final bool isEvenIndex = index % 2 == 0;

                  return _buildCertificateCard(
                    imagePath: isEvenIndex
                        ? 'assets/images/certificate_template_1.png'
                        : 'assets/images/certificate_template_2.png',
                    title: 'Workshop Humic Engineering',
                    onTap: () {
                      // Aksi ketika sertifikat diklik
                      controller.viewCertificateDetail(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateCard({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                // Gambar Sertifikat
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Tombol Opsi (3 titik)
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Tampilkan menu opsi (download, share, dll)
                      ;
                    },
                  ),
                ),
              ],
            ),
          ),
          // Judul Sertifikat
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: AppTypography.bodyMediumSemiBold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

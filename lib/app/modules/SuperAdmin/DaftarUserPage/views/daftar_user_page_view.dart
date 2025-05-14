import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/modules/SuperAdmin/DaftarUserPage/controllers/daftar_user_page_controller.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/widgets/custom_drawer.dart';
import 'package:humic_mobile/app/data/controllers/user_controllers.dart';

class DaftarUserView extends GetView<DaftarUserController> {
  const DaftarUserView({super.key});

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
            // Header dengan judul di tengah
            Center(
              child: Text(
                'Data Pengguna',
                style: AppTypography.bodyLargeBold.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Tombol Tambah
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => controller.tambahUser(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Tambah',
                  style: AppTypography.bodyMediumSemiBold.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Search Bar
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                onChanged: (value) => controller.searchUsers(value),
                decoration: InputDecoration(
                  hintText: 'Cari data pengguna...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Table Header
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.zero,
              ),
              child: Row(
                children: [
                  _buildTableHeader('No.',
                      flex: 1, alignment: TextAlign.center),
                  _buildTableHeader('Nama Pengguna',
                      flex: 4, alignment: TextAlign.center),
                ],
              ),
            ),

            // Table Content
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.userList.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada data pengguna',
                      style: AppTypography.bodyMediumRegular,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    final user = controller.userList[index];
                    final fullName =
                        '${user['nama_depan']} ${user['nama_belakang']}';

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300]!),
                          left: BorderSide(color: Colors.grey[300]!),
                          right: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildTableCell('${index + 1}',
                              flex: 1, alignment: TextAlign.center),
                          _buildTableCell(fullName, flex: 4),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),

            // Pagination dengan border individual
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPaginationButtonWithBorder(
                      'First', () => controller.goToPage(1)),
                  _buildPaginationButtonWithBorder(
                      'Previous', () => controller.prevPage()),
                  Obx(() {
                    return _buildPageNumberButtonWithBorder(
                      controller.currentPage.value.toString(),
                      true,
                      () => {},
                    );
                  }),
                  _buildPaginationButtonWithBorder(
                      'Next', () => controller.nextPage()),
                  _buildPaginationButtonWithBorder('Last',
                      () => controller.goToPage(controller.totalPages.value)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text,
      {int flex = 1, TextAlign alignment = TextAlign.left}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        child: Text(
          text,
          style: AppTypography.bodyMediumBold.copyWith(
            color: Colors.white,
          ),
          textAlign: alignment,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text,
      {int flex = 1, TextAlign alignment = TextAlign.left}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Text(
          text,
          style: AppTypography.bodyMediumRegular,
          textAlign: alignment,
        ),
      ),
    );
  }

  Widget _buildPaginationButtonWithBorder(String text, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            text,
            style: AppTypography.bodySmallRegular.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageNumberButtonWithBorder(
      String text, bool isActive, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          border: Border(
            right: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            text,
            style: AppTypography.bodySmallRegular.copyWith(
              color: isActive ? Colors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

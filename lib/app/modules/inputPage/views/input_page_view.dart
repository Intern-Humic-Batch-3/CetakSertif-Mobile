import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:humic_mobile/app/widgets/custom_drawer.dart';
import 'package:humic_mobile/app/widgets/custom_header_input.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../controllers/input_page_controller.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/data/controllers/user_controllers.dart';

class InputPageView extends GetView<InputPageController> {
  const InputPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan UserController untuk data pengguna
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
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const CustomInputHeader(showBackButton: true),

            const SizedBox(height: 24),

            // // Input Data Sertifikat Title
            // Text("Inputkan Data Seritifikat",
            //     style: AppTypography.bodyLargeBold),
            // const SizedBox(height: 24),

            // File Excel
            _buildFilePickerField(
                "Inputkan File Excel", controller.selectedExcelFileName,
                allowedExtensions: ['xlsx']),
            const SizedBox(height: 8),
            Text('⚠️ Format file XLSX dengan ukuran maximal 3 MB',
                style: AppTypography.bodySmallRegular),
            const SizedBox(height: 24),

            // Nama Kegiatan
            _buildTextField('Inputkan Nama Kegiatan'),
            const SizedBox(height: 24),

            // Tanggal Kegiatan
            Text('Inputkan Tanggal Kegiatan',
                style: AppTypography.bodyMediumBold),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: _buildDateField(
                        'Tanggal Dimulai', context, controller.tanggalMulai)),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildDateField('Tanggal Berakhir', context,
                        controller.tanggalBerakhir)),
              ],
            ),

            const SizedBox(height: 24),

            // Penyelenggara
            _buildTextField('Inputkan Penyelenggara'),
            const SizedBox(height: 24),

            // Tanda Tangan
            Text('Inputkan Tanda Tangan', style: AppTypography.bodyMediumBold),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTTDFilePickerField(
                      'TTD 1', controller.selectedTTD1FileName,
                      allowedExtensions: ['png', 'jpg']),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTTDFilePickerField(
                      'TTD 2', controller.selectedTTD2FileName,
                      allowedExtensions: ['png', 'jpg']),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTTDFilePickerField(
                      'TTD 3', controller.selectedTTD3FileName,
                      allowedExtensions: ['png', 'jpg']),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/nextPage');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Submit',
                    style: AppTypography.bodyLargeSemiBold
                        .copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable TextField
  Widget _buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodyMediumBold),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: '',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.neutral400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.neutral400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}

// File Picker khusus TTD (tanpa "Chosen File")
Widget _buildTTDFilePickerField(String label, RxString fileName,
    {List<String>? allowedExtensions}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTypography.bodyMediumBold),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: allowedExtensions ?? ['png', 'jpg'],
          );
          if (result != null && result.files.isNotEmpty) {
            fileName.value = result.files.single.name; // Set nama file
          }
        },
        child: Obx(() => Container(
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  if (fileName.value.isNotEmpty) ...[
                    const Icon(Icons.insert_drive_file, color: Colors.green),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        fileName.value,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodyMediumRegular,
                      ),
                    ),
                  ] else
                    Text('chosse file',
                        style: AppTypography.bodyMediumRegular
                            .copyWith(color: Colors.grey[600])),
                ],
              ),
            )),
      ),
    ],
  );
}

// File Picker Field
Widget _buildFilePickerField(String label, RxString fileName,
    {List<String>? allowedExtensions}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTypography.bodyMediumBold),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions:
                allowedExtensions ?? ['jpg', 'png', 'pdf', 'xlsx'],
          );
          if (result != null && result.files.isNotEmpty) {
            fileName.value = result.files.single.name; // Set nama file
          }
        },
        child: Obx(
          () => Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Bagian Kiri: "Chosen File"
                Container(
                  width: 110, // Lebar bagian kiri bisa disesuaikan
                  decoration: const BoxDecoration(
                      color: Color(0xFFF1F1F1), // Abu-abu muda
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  alignment: Alignment.center,
                  child: Text(
                    'Chosen File',
                    style: AppTypography.bodyMediumRegular
                        .copyWith(color: Colors.grey[600]),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.grey,
                ),
                // Bagian Kanan: Nama File
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: fileName.value.isNotEmpty
                        ? Text(
                            fileName.value,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.bodyMediumRegular,
                          )
                        : Text(
                            'Tidak ada file',
                            style: AppTypography.bodyMediumRegular
                                .copyWith(color: Colors.grey[500]),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// Date Picker Field
Widget _buildDateField(
    String hintText, BuildContext context, RxString dateValue) {
  return Obx(() => GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primary,
                    onPrimary:
                        AppColors.textTertiary, // Warna teks tanggal dipilih
                    onSurface: Colors.black, // Warna teks default
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          AppColors.primary, // Warna tombol (CANCEL/OK)
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (pickedDate != null) {
            // Format tanggal
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
            dateValue.value = formattedDate; // Simpan ke controller
          }
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateValue.value.isEmpty ? hintText : dateValue.value,
                style: AppTypography.bodyMediumRegular.copyWith(
                  color:
                      dateValue.value.isEmpty ? Colors.grey[600] : Colors.black,
                ),
              ),
              const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ));
}

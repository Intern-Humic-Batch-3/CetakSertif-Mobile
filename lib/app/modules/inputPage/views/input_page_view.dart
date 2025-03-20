import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:humic_mobile/app/widgets/custom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/input_page_controller.dart';
import 'package:humic_mobile/app/widgets/custom_app_bar.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';

class InputPageView extends GetView<InputPageController> {
  const InputPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(
        isAdmin: true,
        userEmail: "Daniel Admin",
        userName: "Danieladmin@mail.com",
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
                Text('Input Data', style: AppTypography.bodyLargeSemiBold),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    _showInfoDialog(context);
                  },
                ),
              ],
            ),
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
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
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
              String formattedDate =
                  DateFormat('dd-MM-yyyy').format(pickedDate);
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
                    color: dateValue.value.isEmpty
                        ? Colors.grey[600]
                        : Colors.black,
                  ),
                ),
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ));
  }

  // Fungsi untuk menampilkan Pop Up Dialog
  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Buat Sertifikat dengan Mudah!',
                    style: AppTypography.bodyLargeBold,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              _buildStep(
                  '1', 'Unggah Template – Pilih desain sertifikatmu (JPG/PNG)'),
              _buildStep('2',
                  'Tambahkan Data Peserta – Upload file Excel (.XLSX, max 1MB)'),
              _buildStep('3',
                  'Lengkapi Detail Acara – Isi nama kegiatan, tanggal, dan penyelenggara.'),
              _buildStep('4',
                  'Tambahkan Tanda Tangan – Unggah file tanda tangan yang diperlukan.'),
              _buildStep(
                  '5', 'Klik Submit – Biarkan sistem memproses sertifikatmu.'),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary, // Warna button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Menutup dialog
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('Tutup', style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

// Widget Step List dengan Icon Angka
  Widget _buildStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circle Number
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          // Description
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMediumRegular,
            ),
          ),
        ],
      ),
    );
  }
}

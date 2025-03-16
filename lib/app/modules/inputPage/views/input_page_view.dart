import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
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
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
                Text('Input Data', style: AppTypography.bodyLargeSemiBold),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Inputkan File Excel',
                hintText: 'Chosen File',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.upload_file),
                  onPressed: () async {
                    // Implement file picker logic here
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['xlsx'],
                    );

                    if (result != null) {
                      // Handle the selected file
                      String filePath = result.files.single.path!;
                      // Update the TextField or perform any action with the file
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('Format file XLSX dengan ukuran maksimal 3 MB',
                style: AppTypography.bodySmallRegular),
            const SizedBox(height: 16),
            _buildTextField('Inputkan Nama Kegiatan', ''),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildDateField('Tanggal Dimulai', context)),
                const SizedBox(width: 8),
                Expanded(child: _buildDateField('Tanggal Berakhir', context)),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField('Inputkan Penyelenggara', ''),
            const SizedBox(height: 16),
            Text('Inputkan Tanda Tangan',
                style: AppTypography.bodyLargeSemiBold),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildTextField('Chosen File', 'TTD 1')),
                const SizedBox(width: 8),
                Expanded(child: _buildTextField('Chosen File', 'TTD 2')),
                const SizedBox(width: 8),
                Expanded(child: _buildTextField('Chosen File', 'TTD 3')),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/nextPage'); // Navigate to the next page
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
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodyMediumBold),
        const SizedBox(height: 4),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilePicker(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodyMediumBold),
        const SizedBox(height: 4),
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['xlsx'],
            );
            if (result != null) {
              // Handle the selected file
            }
          },
          child: Text(hint),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodyMediumBold),
        const SizedBox(height: 4),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            suffixIcon: Icon(Icons.calendar_today),
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              // Handle the selected date
            }
          },
        ),
      ],
    );
  }
}

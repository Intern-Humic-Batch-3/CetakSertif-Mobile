import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';

class CustomInputHeader extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBack;
  final VoidCallback? onInfoTap;
  final String? backRoute; // Tambahkan parameter route tujuan

  const CustomInputHeader({
    Key? key,
    this.showBackButton = false,
    this.onBack,
    this.onInfoTap,
    this.backRoute, // Parameter route tujuan
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (showBackButton)
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack ??
                  () {
                    if (backRoute != null) {
                      Get.offNamed(backRoute!);
                    } else {
                      Get.back();
                    }
                  },
            ),
          ),
        Text(
          'Input Data',
          style: AppTypography.bodyLargeSemiBold,
          textAlign: TextAlign.center,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: onInfoTap ?? () => _showInfoDialog(context),
          ),
        ),
      ],
    );
  }
}

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
                  textAlign: TextAlign.center,
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
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
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

Widget _buildStep(String number, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

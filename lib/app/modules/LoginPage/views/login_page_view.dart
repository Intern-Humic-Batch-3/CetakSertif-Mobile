import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:humic_mobile/app/constants/colors.dart';
import 'package:humic_mobile/app/constants/typography.dart';
import 'package:humic_mobile/app/routes/app_pages.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Center(
                    child: Image.asset(
                      "assets/images/LogoHumic.png",
                    ),
                  ),
                  const SizedBox(height: 29),

                  // Welcome Text
                  Center(
                    child: Text(
                      "Selamat Datang Kembali!",
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.textPrimary,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Center(
                    child: Text(
                      'Masuk untuk melakukan cetak sertifikat sesuai\ndengan kebutuhan anda',
                      style: AppTypography.bodyMediumRegular.copyWith(
                        color: AppColors.textSecondary,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 51),

                  // Email Label
                  Text(
                    'Email',
                    style: AppTypography.bodyLargeBold.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: AppTypography.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Email Field
                  TextField(
                    style: AppTypography.bodyLargeRegular.copyWith(
                      fontFamily: 'Poppins',
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors
                          .background, // Light primary color for background
                      hintText: "Masukkan email anda",
                      hintStyle: AppTypography.bodyLargeRegular.copyWith(
                        color: AppColors.textTertiary,
                        fontFamily: 'Poppins',
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.disabled)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Password Label
                  Text(
                    'Password',
                    style: AppTypography.bodyLargeBold.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: AppTypography.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Password Field
                  Obx(() => TextField(
                        obscureText: controller.isPasswordHidden.value,
                        style: AppTypography.bodyLargeRegular.copyWith(
                          fontFamily: 'Poppins',
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors
                              .background, // Light primary color for background
                          hintText: "Masukkan password anda",
                          hintStyle: AppTypography.bodyLargeRegular.copyWith(
                            color: AppColors.textTertiary,
                            fontFamily: 'Poppins',
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.textTertiary,
                            ),
                            onPressed: () =>
                                controller.togglePasswordVisibility(),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.disabled),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                        ),
                      )),
                  const SizedBox(height: 43),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.login(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: GestureDetector(
                        child: Text(
                          'Masuk',
                          style: AppTypography.bodyLargeSemiBold.copyWith(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

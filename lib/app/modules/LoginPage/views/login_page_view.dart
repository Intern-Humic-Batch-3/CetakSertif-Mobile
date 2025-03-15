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
      backgroundColor: AppColors.putih,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                color: AppColors.primary,
                child: Column(
                  children: [
                    Text(
                      "Website Cetak Sertifikat - HUMIC ENGINEERING",
                      style: AppTypography.bodyLargeBold.copyWith(
                        color: AppColors.putih,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    Container(
                      width: 185,
                      height: 185,
                      decoration: BoxDecoration(
                          color: AppColors.putih, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset("assets/images/LogoHumic.png"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Selamat Datang!",
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.putih,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Masuk untuk melakukan cetak sertifikat sesuai dengan kebutuhan anda",
                      style: AppTypography.bodyMediumRegular.copyWith(
                        color: AppColors.putih,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Login Form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email Field
                    Text("Email",
                        style: AppTypography.bodyLargeBold
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Masukkan email anda",
                        fillColor: AppColors.putih,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.textPrimary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    Text("Password",
                        style: AppTypography.bodyLargeBold
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    Obx(() => TextField(
                          obscureText: controller.isPasswordHidden.value,
                          decoration: InputDecoration(
                            hintText: "Masukkan password anda",
                            fillColor: AppColors.putih,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: AppColors.textPrimary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: AppColors.primary),
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
                          ),
                        )),
                    const SizedBox(height: 32),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.login(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Masuk",
                            style: AppTypography.bodyLargeSemiBold
                                .copyWith(color: AppColors.light)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

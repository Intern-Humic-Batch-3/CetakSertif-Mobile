// import 'package:flutter/material.dart';
// import 'colors.dart';
// import 'typography.dart';

// /// App theme
// /// This class contains the theme configuration for the application
// class AppTheme {
//   /// Light theme
//   static ThemeData get lightTheme {
//     return ThemeData(
//       primaryColor: AppColors.primary,
//       colorScheme: ColorScheme(
//         primary: AppColors.primary,
//         primaryContainer: AppColors.secondary,
//         secondary: AppColors.secondary,
//         secondaryContainer: AppColors.cardBackground,
//         surface: AppColors.surface,
//         background: AppColors.background,
//         error: AppColors.error,
//         onPrimary: Colors.white,
//         onSecondary: Colors.white,
//         onSurface: AppColors.textPrimary,
//         onBackground: AppColors.textPrimary,
//         onError: Colors.white,
//         brightness: Brightness.light,
//       ),
//       scaffoldBackgroundColor: Colors.white,
//       appBarTheme: AppBarTheme(
//         backgroundColor: AppColors.primary,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       fontFamily: AppTypography.fontFamily,
//       textTheme: TextTheme(
//         // Display styles
//         displayLarge: AppTypography.displayBold,
//         displayMedium: AppTypography.h1Bold,
//         displaySmall: AppTypography.h2Bold,

//         // Headline styles
//         headlineLarge: AppTypography.h3Bold,
//         headlineMedium: AppTypography.h4Bold,
//         headlineSmall: AppTypography.h5Bold,

//         // Title styles
//         titleLarge: AppTypography.h4SemiBold,
//         titleMedium: AppTypography.h5SemiBold,
//         titleSmall: AppTypography.bodyLargeSemiBold,

//         // Body styles
//         bodyLarge: AppTypography.bodyLargeRegular,
//         bodyMedium: AppTypography.bodyMediumRegular,
//         bodySmall: AppTypography.bodySmallRegular,

//         // Label styles
//         labelLarge: AppTypography.bodyLargeSemiBold,
//         labelMedium: AppTypography.bodyMediumSemiBold,
//         labelSmall: AppTypography.bodySmallSemiBold,
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: AppColors.primary,
//         textTheme: ButtonTextTheme.primary,
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           foregroundColor: Colors.white,
//           textStyle:
//               AppTypography.bodyLargeSemiBold.copyWith(color: Colors.white),
//         ),
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           textStyle: AppTypography.bodyLargeSemiBold,
//         ),
//       ),
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           side: BorderSide(color: AppColors.primary),
//           textStyle: AppTypography.bodyLargeSemiBold,
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         fillColor: AppColors.surface,
//         filled: true,
//         labelStyle: AppTypography.bodyMediumRegular
//             .copyWith(color: AppColors.textSecondary),
//         hintStyle: AppTypography.bodyMediumRegular
//             .copyWith(color: AppColors.textTertiary),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColors.divider),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColors.divider),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColors.primary),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColors.error),
//         ),
//       ),
//     );
//   }

//   /// Dark theme
//   static ThemeData get darkTheme {
//     return ThemeData(
//       primaryColor: AppColors.primary,
//       colorScheme: ColorScheme(
//         primary: AppColors.primary,
//         primaryContainer: AppColors.secondary,
//         secondary: AppColors.secondary,
//         secondaryContainer: AppColors.cardBackground,
//         surface: AppColors.neutral600,
//         background: Color(0xFF121212),
//         error: AppColors.error,
//         onPrimary: Colors.white,
//         onSecondary: Colors.white,
//         onSurface: Colors.white,
//         onBackground: Colors.white,
//         onError: Colors.white,
//         brightness: Brightness.dark,
//       ),
//       scaffoldBackgroundColor: Color(0xFF121212),
//       appBarTheme: AppBarTheme(
//         backgroundColor: AppColors.neutral600,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       fontFamily: AppTypography.fontFamily,
//       textTheme: TextTheme(
//         // Display styles
//         displayLarge: AppTypography.displayBold.copyWith(color: Colors.white),
//         displayMedium: AppTypography.h1Bold.copyWith(color: Colors.white),
//         displaySmall: AppTypography.h2Bold.copyWith(color: Colors.white),

//         // Headline styles
//         headlineLarge: AppTypography.h3Bold.copyWith(color: Colors.white),
//         headlineMedium: AppTypography.h4Bold.copyWith(color: Colors.white),
//         headlineSmall: AppTypography.h5Bold.copyWith(color: Colors.white),

//         // Title styles
//         titleLarge: AppTypography.h4SemiBold.copyWith(color: Colors.white),
//         titleMedium: AppTypography.h5SemiBold.copyWith(color: Colors.white),
//         titleSmall:
//             AppTypography.bodyLargeSemiBold.copyWith(color: Colors.white),

//         // Body styles
//         bodyLarge: AppTypography.bodyLargeRegular.copyWith(color: Colors.white),
//         bodyMedium:
//             AppTypography.bodyMediumRegular.copyWith(color: Colors.white),
//         bodySmall: AppTypography.bodySmallRegular
//             .copyWith(color: AppColors.neutral300),

//         // Label styles
//         labelLarge:
//             AppTypography.bodyLargeSemiBold.copyWith(color: Colors.white),
//         labelMedium:
//             AppTypography.bodyMediumSemiBold.copyWith(color: Colors.white),
//         labelSmall:
//             AppTypography.bodySmallSemiBold.copyWith(color: Colors.white),
//       ),
//       buttonTheme: ButtonThemeData(
//         buttonColor: AppColors.primary,
//         textTheme: ButtonTextTheme.primary,
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           foregroundColor: Colors.white,
//           textStyle:
//               AppTypography.bodyLargeSemiBold.copyWith(color: Colors.white),
//         ),
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           textStyle: AppTypography.bodyLargeSemiBold,
//         ),
//       ),
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           side: BorderSide(color: AppColors.primary),
//           textStyle: AppTypography.bodyLargeSemiBold,
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         fillColor: Color(0xFF1E1E1E),
//         filled: true,
//         labelStyle:
//             AppTypography.bodyMediumRegular.copyWith(color: Colors.white70),
//         hintStyle:
//             AppTypography.bodyMediumRegular.copyWith(color: Colors.white54),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF2C2C2C)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Color(0xFF2C2C2C)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColors.primary),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColors.error),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class AppThemes {
  static final appTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xff74717D),
          width: 3,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xff1E1E20),
          width: 3,
        ),
      ),
      hintStyle: const TextStyle(
        color: AppColors.grey,
      ),
      contentPadding: const EdgeInsets.all(16),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.backgroundColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.grey,
      showUnselectedLabels: true,
      elevation: 0,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
    ),

    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.black100,
    ),
  );
}

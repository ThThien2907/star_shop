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
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xff1E1E20),
          width: 2,
        ),
      ),
      hintStyle: const TextStyle(
        color: Color(0xffA7A5AF),
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
    iconTheme: IconThemeData(
      color: Color(0xff1E1E20),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
      )
    ),
  );
}

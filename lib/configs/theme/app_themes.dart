import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class AppThemes {
  static final appTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color(0xff74717D),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color(0xff1E1E20),
          width: 1,
        ),
      ),
      hintStyle: TextStyle(
        color: Color(0xffA7A5AF),
      ),
      contentPadding: EdgeInsets.all(16),
    ),
  );
}

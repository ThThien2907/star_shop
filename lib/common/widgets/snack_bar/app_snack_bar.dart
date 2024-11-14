
import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class AppSnackBar {
  static showAppSnackBar({required BuildContext context, required String title,}){
    var snackBar = SnackBar(
      content: Text(
        title,
        style: const TextStyle(
            color: AppColors.textColor, fontSize: 16),
      ),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
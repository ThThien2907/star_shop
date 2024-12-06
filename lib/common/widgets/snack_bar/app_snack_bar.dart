
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

  static showAppSnackBarFailure({required BuildContext context, required String title,}){
    var snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.cancel_outlined, color: AppColors.textColor,),
          const SizedBox(width: 8,),
          Text(
            title,
            style: const TextStyle(
                color: AppColors.textColor, fontSize: 16),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.failColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showAppSnackBarSuccess({required BuildContext context, required String title,}){
    var snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, color: AppColors.textColor,),
          const SizedBox(width: 8,),
          Text(
            title,
            style: const TextStyle(
                color: AppColors.textColor, fontSize: 16),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.successColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
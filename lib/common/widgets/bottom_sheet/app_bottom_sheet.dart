import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class AppBottomSheet {
  static Future<void> display(
      {required BuildContext context, required Widget widget, double? height}) {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
            width: double.infinity,
            height: height,
            child: widget,
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class AppButtonOutline extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final Widget? widget;
  final double? width;
  final double? height;
  final Color? color;

  const AppButtonOutline({
    super.key,
    required this.onPressed,
    this.title,
    this.widget,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 60,
        ),
        backgroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: color ?? AppColors.grey,
          ),
        ),
      ),
      child: widget ??
          Text(
            title ?? '',
            style: const TextStyle(
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
    );
  }
}

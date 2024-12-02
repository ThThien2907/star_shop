import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final Widget? widget;
  final double? width;
  final double? height;
  final Color? color;

  const AppButton({
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
          height ?? 50,
        ),
        backgroundColor: color ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: widget ??
          Text(
            title ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.maxLength,
    this.suffixIcon,
    this.readOnly,
    this.onTap,
    this.keyboardType,
    this.maxLines,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool? readOnly;
  final int? maxLength;
  final int? maxLines;
  final Icon? suffixIcon;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '',
            suffixIcon: suffixIcon,
          ),
          readOnly: readOnly ?? false,
          maxLength: maxLength,
          onTap: onTap,
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1,
        ),
      ],
    );
  }
}

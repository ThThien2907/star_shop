import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class AddressPageTitle extends StatelessWidget {
  const AddressPageTitle({super.key, required this.isEditAddress, required this.onPressed});

  final bool isEditAddress;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Saved Address',
          style: TextStyle(
              fontSize: 16, color: AppColors.primaryTextColor),
        ),
        const Spacer(),
        TextButton(
          onPressed: !isEditAddress
              ? onPressed
              : null,
          child: Text(
            !isEditAddress ? 'Edit Address' : '',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.subtextColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.subtextColor,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class CartPageSubTotal extends StatelessWidget {
  const CartPageSubTotal({super.key, required this.subTotal});

  final num subTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            'Sub-total:',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            '\$$subTotal',
            style: const TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

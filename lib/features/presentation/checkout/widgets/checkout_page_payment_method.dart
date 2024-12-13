import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class CheckoutPagePaymentMethod extends StatelessWidget {
  const CheckoutPagePaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(
              fontSize: 16, color: AppColors.primaryTextColor),
        ),
        const SizedBox(height: 16,),
        Row(
          children: [
            _paymentMethodButton(context, AppColors.primaryColor, Icons.money, 'Cash'),
            const SizedBox(width: 16,),
            _paymentMethodButton(context, AppColors.backgroundColor, Icons.credit_card_outlined, 'Card'),
          ],
        ),
      ],
    );
  }

  Widget _paymentMethodButton(BuildContext context, Color color, IconData icon, String text){
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textColor,),
          const SizedBox(width: 8,),
          Text(
            text,
            style: const TextStyle(
                fontSize: 16, color: AppColors.textColor),
          ),
        ],
      ),
    );
  }
}

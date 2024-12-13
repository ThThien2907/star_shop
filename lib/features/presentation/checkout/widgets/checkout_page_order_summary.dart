import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class CheckoutPageOrderSummary extends StatelessWidget {
  const CheckoutPageOrderSummary({super.key, required this.subTotal, required this.total});

  final num subTotal;
  final num total;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
              fontSize: 16, color: AppColors.primaryTextColor),
        ),
        const SizedBox(height: 32,),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            children: [
              _orderSummaryItem(context, 'Sub-total', '$subTotal', null),
              const SizedBox(height: 16,),
              _orderSummaryItem(context, 'Delivery Fee', '20', null),
            ],
          ),
        ),

        const SizedBox(height: 32,),
        _orderSummaryItem(context, 'Total', '$total', AppColors.primaryTextColor),
      ],
    );
  }

  Widget _orderSummaryItem(BuildContext context, String title, String value, Color? color) {
    return Row(
      children: [
        Text(
          '$title:',
          style: TextStyle(
            color: color ?? AppColors.subtextColor,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Text(
          '\$$value',
          style: TextStyle(
            color: color ?? AppColors.textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

  }
}

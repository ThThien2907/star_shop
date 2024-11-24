import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class ProductDetailRatingReview extends StatelessWidget {
  const ProductDetailRatingReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rating & Reviews',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Ta Thanh Thien',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Text(
            'Great Shopping Experience!',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.subtextColor,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Color(0xff987317),
              ),
              SizedBox(
                height: 16,
              ),
              Icon(
                Icons.star,
                color: Color(0xff987317),
              ),
              SizedBox(
                height: 16,
              ),
              Icon(
                Icons.star,
                color: Color(0xff987317),
              ),
              SizedBox(
                height: 16,
              ),
              Icon(
                Icons.star,
                color: Color(0xff987317),
              ),
              SizedBox(
                height: 16,
              ),
              Icon(
                Icons.star,
                color: Color(0xff987317),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'View all 100 Reviews',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.textColor,
            ),
          ),
        )
      ],
    );
  }
}

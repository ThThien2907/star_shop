import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class ProfilePageItem extends StatelessWidget {
  const ProfilePageItem({super.key, required this.title, required this.value,});

  final String title;
  final String value;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, color: AppColors.textColor, fontWeight: FontWeight.bold,),),
        const SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(value, style: const TextStyle(fontSize: 16, color: AppColors.subtextColor,),),
        )
      ],
    );
  }
}
